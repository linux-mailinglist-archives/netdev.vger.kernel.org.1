Return-Path: <netdev+bounces-76776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C387886EE97
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 05:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A964B23999
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 04:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FE410FF;
	Sat,  2 Mar 2024 04:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqX3gkcK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2217D2
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 04:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709354005; cv=fail; b=bfe3OInea/UtdIseNBS5JbrtD5dmXcIL5+ntVx8EYWN9ryw6lGRPIgS9T3Nq0uJBK9wRb3U2dMW3Py4Ly9SgMcJU37G8r/haDaSbbC+SSV6He34sXZDq3Q9d2a24reqEUt3IM/puIDbzydlEPPzpdsmufgVIVXsAtUWYOdorwQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709354005; c=relaxed/simple;
	bh=DfdT2bOFEGB7/mJNLNJyAwm73TSfBBAG6ofamlFrss8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FSBF3Afkxd4mMKybGdJvjN2ecuMDP3kCyEAc6yrJGzzAsBO2xw0AZMhYwfAdOIBxvGK/Myd2JaIyC9tteZMJ2Htf0+v41BTLx7RTvHjryXM4sKx8emSnX144UBYhWcv5MtOD/dj3AhgGdzQUscC+/OFB+G1+j+Pb7VSliyEFUYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqX3gkcK; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709354004; x=1740890004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DfdT2bOFEGB7/mJNLNJyAwm73TSfBBAG6ofamlFrss8=;
  b=BqX3gkcKjBWj9nozPW1C9oGW1NxaJJ9c7HBkBW4k7DtFeDO9mvVnXmVt
   QG3Kq+qAwGvDpO4T10+PU5n0nZXc2QTzIxaCnVCZxnnqc7L2RBfL/G/uu
   oYsWlLhmW3smGVuNyyh/KVc+4g0jqJYdwRvYuaPJQWEkXwvmNgV5mNBV6
   KxLsyXwu5oOv2Bp39J2T/Zj0iWvOjFHTrs+QuWnQyMIoBg3oUBfa52ocj
   kwW0dbg7jZVOtOt8tYXWfug0MBWc7MKq6ucQROEO2TuJMu1lanWVxEsfu
   BNdUUnYiHhfMHiHM+SQl4p/MTJ8YGNcys0YWHMgtfAyCWlwPmUXq15wLx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3834145"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="3834145"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 20:33:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8342717"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 20:33:23 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 20:33:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 20:33:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 20:33:21 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 20:33:21 -0800
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by SA3PR11MB7628.namprd11.prod.outlook.com (2603:10b6:806:312::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Sat, 2 Mar
 2024 04:33:19 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636%3]) with mapi id 15.20.7362.017; Sat, 2 Mar 2024
 04:33:19 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: "Brady, Alan" <alan.brady@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Hay, Joshua A"
	<joshua.a.hay@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Brady, Alan" <alan.brady@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Bagnucki, Igor"
	<igor.bagnucki@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v6 02/11 iwl-next] idpf: implement
 virtchnl transaction manager
Thread-Topic: [Intel-wired-lan] [PATCH v6 02/11 iwl-next] idpf: implement
 virtchnl transaction manager
Thread-Index: AQHaZcI0KyE73I2z2EirjQJ2FvgerrEj6bpA
Date: Sat, 2 Mar 2024 04:33:19 +0000
Message-ID: <MW4PR11MB59112303C2327179D3BE63CDBA5D2@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20240222190441.2610930-1-alan.brady@intel.com>
 <20240222190441.2610930-3-alan.brady@intel.com>
In-Reply-To: <20240222190441.2610930-3-alan.brady@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|SA3PR11MB7628:EE_
x-ms-office365-filtering-correlation-id: 78af4baf-7336-4e51-00e9-08dc3a71e2da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ZQCfIcYwtwvZAiTBD1dKS2bLuqlFBwvNgSWlXLR2QSH2bzSt+yWBzNdCIrAR/4lI7gxM5qlnsjUaxKYO8GbA6lqHnMPvodku+9zprsP5LBrwof4JrzFX/ZpQkTDVfvZvVIRDRQvVpH2XZ+VLtjwHiC4MS21JZ2ePrqQ8EgW5Nlh6MAzWi5xZcwxyZVuLzoZgJIXHQ65ij4KHFkGdBUBr1Y88xHcVU4vJqlYs1gPgj5USG3X2/GRk/XayJsC8ruloSoBI1vhiFv+EE1y22caZsE4pt6LJnOSuGtf2570mbqHzfM+ryqz6qaBsKSdjHVFQbgvf3+XW3+ny9DeK+XZi7+GNL15wi9mp0Fr3gnZX+T8PWF1bKV6Y5oMCc0dm6n7j1LxvR4waBblbYomoSo+0Ija6vhX/i8xgpi4wj3KQUkSaWHy4d8Qw5+ETUEJInEiI/TkUjN/Fk2BNgHZfSNITyQ6SztaDTv5YvjuO1GDU7iVf6Dz/bCeCcWoaULmaaQbFAksEETwPutU/vOWQfd8S/+zf9psSb6LbW8iddVrc+PFYcEGVOKeS4QRNPbXrZQiPoVe2stwJsgmZqsROUwLAyFys4f0BCZdvFsc6Y2nJ9XZ0R5jmmxCDav5bm23bzxqPK12f7gK3Flag3ap0PF9vTVOJlzSgc8lEcQWekSIBQO8YKjvh/ni1qLUTwbnJ4xJR2G3xyPif0Rhe6Z1tOUuyG9weJWK1kFbXZNdq/FG9A4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yphEzKZ7BTfb9R1KgVFWnJXAeT8XTsMgvV2C0IoCb6+UuN/KyW3QIp0Y39Cn?=
 =?us-ascii?Q?KTogf1fegoz8A5+N6KpQbY7s08tRUPUe1LQ17NVpWMgwZ/wiPpDir0BvSwJu?=
 =?us-ascii?Q?r1Ya27sb8xmApsfbmXmK/vh1qaTkfzgI3gqOACWYY83DhYwnLIVMT1g6a3Qx?=
 =?us-ascii?Q?MG3mktYUpwR096fwX+sJ+IOr39mscKNeePDYNLnGUse3MM3WpPegAVYkm4WD?=
 =?us-ascii?Q?9kb50VHnlmZb8VG5zQDzUtj0jI1duztpKSuWLzsf2+AwkKkjEv0NfkLh35h7?=
 =?us-ascii?Q?cwnp6R/EzgHxALsBRkRU1m6hqEHZSRpfdpo1nhrDv8h48xKobJXfe8MKqHuW?=
 =?us-ascii?Q?u74wSXdrYuHlhSl26M75nSznGSOFeKn20rKoCGwxnIeZKQr2HUFYwJXHb1h2?=
 =?us-ascii?Q?CsZrrI7qnj+GdD82kQGVxUaMH/SRLdeieKj/R3fQcMsdBg4FtfkMg3XN0LJj?=
 =?us-ascii?Q?lAOVR6ajDBSpfCus2UCiHhg0vBYZvGTA5zK4RAPXio9Q7AjmlpZThd1VZR4K?=
 =?us-ascii?Q?aMuB+MfF2T+k6ZDJAtqChsbUTOT/ExSVakXWUXuWC+dK0IlW28/5n7gjgZCw?=
 =?us-ascii?Q?EwRdA/e5x4E4343xKDjPc9WQQ0BEluVP5OZ7O5MyMHGrNt9rwJXyAeKskRwZ?=
 =?us-ascii?Q?bcUshjs1gJJ1nAq9sg3A9VMV4d9Nm4muZBI5X3Dy4Jv8vdosdVMCepMIc+18?=
 =?us-ascii?Q?uiD7w4gnMvtXC3gDXmwJaNAx4RnaGpOoYIbJBNd6A3VGZax4iswLyutnqog9?=
 =?us-ascii?Q?RrHuYPp2Svyy40jDqDUqTEHr0vRw6OxnTanTo6bDdd+uZxMtFMRhM4+aa4L0?=
 =?us-ascii?Q?CNKMu5kfZraG1X5kVInyVS8nkeo5hn8qpg+Mi0vKUQkBzduKTRPW+l5dKoEQ?=
 =?us-ascii?Q?H9z5OXkCz0a0cYMHNLv03MnvueyNzn3BlRBHroUMckrJ8GOZqzDx/ow8MxBH?=
 =?us-ascii?Q?/g0++97cyJGaqHUFJCCNgfxytNQVvRTpg/OoqE0I4YykFuQAITEzCnpGtSeY?=
 =?us-ascii?Q?8MmexAL8FI/87iUxjd3sG/twNdyL6xRugCGTl88dltt619hOjW9injTfdVbJ?=
 =?us-ascii?Q?rWUmONZHxtTgoMQs5HCI1Qs4IpP4uwR6X+G90hKrUDTFpqS6eVMl+4mlydt5?=
 =?us-ascii?Q?Asnh/1LRuVEv6CqHQdRsk+QPrt12sE/bWMuPBwm2cXbwtTLViRopsMZqxX9k?=
 =?us-ascii?Q?Dc1oCvD0cZXxfdYUbmib6wi2mU04n72EM1xgmDU7HEQXQjrVLwcOJBsWZDFT?=
 =?us-ascii?Q?gw/P+mj+mbV6IWkcxCAIcWB6Za98ZW6s801qU+vFa6oL54FxAXlWLXd+nA33?=
 =?us-ascii?Q?4VbpeaQGjYhkW6eAH3jlQVAcoqcraLmqCroORxgknhaaXPnBtKT6d+ZwT1O/?=
 =?us-ascii?Q?w/hx/eRaLyQLy3vHo2QjIKN+c5JJnZB5/1fz/WWX7Xvt+nowS7GOH/Ej88VE?=
 =?us-ascii?Q?qvs55v0A7Gpx6Cdi7xGxeZvDwh5lSCprFmTBbMxrBu7K/u2tsGTQUJ6ghlkY?=
 =?us-ascii?Q?0HipCEvwWoE4J3O1QMg1f+LzL518psBOaQsZ73nH9CIHksvd8xWxWFO9aN33?=
 =?us-ascii?Q?kB/ybbErKqj+7UnA+4Zx85cjqGvNjf4RZiZjnlrFX0w0YtGXz8AaTLpHjhdu?=
 =?us-ascii?Q?Lg=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8D6zmfCpzxK3/zcOmjnEIZZVKa49cOm8bh1+mojQ5LTyCj1P1tVmjf72M4r48fl932iC3IIKQnrjaGy9g5sz3INqPePB7N0ozw98JT9ForaGfpC7V1yzBaIwaoRpskg5oK7n67Gyu20zB1mrPEDYkwxqt9uyRMwzhsK16qAtduGYmOnIyH385ovE3AB5eugla9GxfIzjMFJlW9XSQSEA8NSno/7TguYhONMpl3PHj4Udj4DijkdQEsqD3lQxcUdY/xKc6mGgLznVQgxW9HQYWB63cfWGtaoN0gW1pa+i2pf4W14KE3J0gQboxoL923wKa41lAC6TepaezKCKzlQxA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/+EBG368pfb96GUzPRwEv9SQ0eII7veQkry3c0g7sc=;
 b=lMTESTLr3X1OqK890qElU6za1r5FCJkb8G7/JLon1178+aE0O/+Z0uJ1jJ6ymDlwbVPUBWqUtO8GDqqpi/w+YSlu0nheScipX0Tutl7UQnykxdf/DS6AXxQMA+um6/zbvUDQL0h9P4jLUQN+wNFdyPG3QpAgEsr+X+6ZcRQkEa5wF6BmJPl5kIBY+7i5v+dUD2wPm8aTEvJa5eqPpLAOImRg60HSr584ZM/mVmA+TJp6tHwXweckTxkJgkP9lJR4S3s9wJgduUZWuLJwOsU4ZVboHB49hHT7gceHeZ8xEHRTaa5CjvLnZiEJ7dkjhUHVuwB/oMVpUZD6JZmQpfU0Qw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: MW4PR11MB5911.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 78af4baf-7336-4e51-00e9-08dc3a71e2da
x-ms-exchange-crosstenant-originalarrivaltime: 02 Mar 2024 04:33:19.1122 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: kSYI9S+WpFWyGzpj9LWqEVCXyIwL2RiSmzCpT25V0u9+/Ey1qaJe0BZeYOyxQKXJ2eukmeWuvuL+DtUag98MUTS0czYHfVvEEfdw3t8nN7A=
x-ms-exchange-transport-crosstenantheadersstamped: SA3PR11MB7628
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alan Brady
> Sent: Thursday, February 22, 2024 11:05 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Brady, Alan <alan.brady@intel.com>;
> netdev@vger.kernel.org; Bagnucki, Igor <igor.bagnucki@intel.com>
> Subject: [Intel-wired-lan] [PATCH v6 02/11 iwl-next] idpf: implement virt=
chnl
> transaction manager
>
> This starts refactoring how virtchnl messages are handled by adding a
> transaction manager (idpf_vc_xn_manager).
>
> There are two primary motivations here which are to enable handling of
> multiple messages at once and to make it more robust in general. As it
> is right now, the driver may only have one pending message at a time and
> there's no guarantee that the response we receive was actually intended
> for the message we sent prior.
>
> This works by utilizing a "cookie" field of the message descriptor. It
> is arbitrary what data we put in the cookie and the response is required
> to have the same cookie the original message was sent with. Then using a
> "transaction" abstraction that uses the completion API to pair responses
> to the message it belongs to.
>
> The cookie works such that the first half is the index to the
> transaction in our array, and the second half is a "salt" that gets
> incremented every message. This enables quick lookups into the array and
> also ensuring we have the correct message. The salt is necessary because
> after, for example, a message times out and we deem the response was
> lost for some reason, we could theoretically reuse the same index but
> using a different salt ensures that when we do actually get a response
> it's not the old message that timed out previously finally coming in.
> Since the number of transactions allocated is U8_MAX and the salt is 8
> bits, we can never have a conflict because we can't roll over the salt
> without using more transactions than we have available.
>
> This starts by only converting the VIRTCHNL2_OP_VERSION message to use
> this new transaction API. Follow up patches will convert all virtchnl
> messages to use the API.
>
> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Co-developed-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h        |   6 +-
>  .../ethernet/intel/idpf/idpf_controlq_api.h   |   5 +
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   2 +
>  drivers/net/ethernet/intel/idpf/idpf_main.c   |   3 +
>  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   2 +-
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 614 ++++++++++++++++--
>  .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   2 +-
>  7 files changed, 561 insertions(+), 73 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> index b2f1bc63c3b6..c3b08d4593b0 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

