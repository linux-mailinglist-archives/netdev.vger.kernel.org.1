Return-Path: <netdev+bounces-76778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A83B886EE9C
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 05:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491371F22039
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 04:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C0917D2;
	Sat,  2 Mar 2024 04:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ej0Q7EYm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB161C20
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 04:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709354073; cv=fail; b=ClRbukPdufpjOCU/6nTkkDDkZyQ180reXLmE2orW9lt+n9L4jhNz40jr0X9wLD8t04VsJLfQlNIHnVS1Y2qDfAczZ7F1e/YpfLNrkaNDi0h5kyl5FJD2YTgxiKYcxCX4rw2tfpuierT4k6qRumEojTi0VaPGcUOw8hqANTzAFww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709354073; c=relaxed/simple;
	bh=lPgBR377RNHNw4/KqmyVlWxeHQKyFUr7BsTPQj3b1nk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=thGps2HAZEukdlA+ULOXbP7qDGXeI94ORNXVwOHshW0TuMpGDYZiJx0JNJtkk/EyyeLJbgRsV3PNP87JDMLL3VnJrNoX95/3R9x1A+mPO6SiKaMKy4ToYAcrqaY6n8bMi89/xXrW7jGGHH0+t2uD1sNiHlESCyNVnjJA2ASibus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ej0Q7EYm; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709354071; x=1740890071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lPgBR377RNHNw4/KqmyVlWxeHQKyFUr7BsTPQj3b1nk=;
  b=ej0Q7EYmbcTXtkVn11pQ68YRtt3xde6ovNqrNT3py5Nx37YxwSxHTAa4
   IuVQEjeVe7r3RI3/bE30ZOEGP8MqoyWmcNxZt/TS2bFoAL55cYvemISk2
   WUnw1i/kE1k9dORhSXCy1IEmpgJZQuY5/sNDF9RRB5z9aPxnGYiWJz6uv
   jBpRAu0hBpltfKk1Whbo14FeysEq3I7F6TgqPPT9sLs3UgLOYxHWBU1JU
   jeA+rywBq/pVQDdGGHfkqUWHbQTYm0bgX2LHGarw0JwVobZSS7y5CgstE
   CzGctsn+DT6AmwltTE299GGxcGH/poj8AqCnqk8ViuJdcM/kQgLT1pCNv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="15346572"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="15346572"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 20:34:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8777553"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 20:34:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 20:34:31 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 20:34:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 20:34:30 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 20:34:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWcH4qUDkMjfikL0KSG4+++IH7pVOZHhpRKApllO9mUA+arfSjK3I5u4zRIMoJt6V7tQqUMYfXkXVTGMBHUMQN3K9hWNrOFAFY3HLqm41E6FAjI37SbxSrD+sGH/lHdZsIc1p+5VBBbYNmqCldXJJk/wPl6NP078evDRaH7hVtw2Q8mAZworSwvwgqaz10gtBzXaJ5+gkj9gY2UCppWADMUEkWe8JCVqwvvn0Gqbh2KlBkUqjKOPHB3Vo9CdXGU1JqhzHAHdr2x0jsMkFjgvJZavvYRkKdPDABzaLu/UEFIpR4wTjixTcK5C5+oI8rn/OkcunqfZPJ27tbWf6PxSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV3n9X73M+fmllb5qSzRT/ytWD46K/L3q4rNEQpV3ig=;
 b=CWS/2nbUOQj2jHkaYcEKcBkLk0r9DD5iVg2Y7pn3iyecFMgqWj7nympLdTcgyPmKhIARD0KFZDy55QxBe6k8SCMzLGD/TNWys6xCBxC/IA3zVYji11o068Lc0cJpau2iGxkyWrhdHJb4FUvCY4RkrUdYGF8YXcSFdJgtPrFvJlb+oXV/BiwOGSDbfdKbejSpuHZqnKpuE8JiZwS1sct/Rs/rpuqAK5fr89haSyvVu01ZDXAavqxbTchyU1U+W55JL9ykBuzTNqeD0hhEn9rrvlLT7aRV19vd9wbRaJN9UThigcW8zdOvCHmVfQalQawn111/4SQzFN6aBFeuQxflwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by SA3PR11MB7628.namprd11.prod.outlook.com (2603:10b6:806:312::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Sat, 2 Mar
 2024 04:34:27 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636%3]) with mapi id 15.20.7362.017; Sat, 2 Mar 2024
 04:34:27 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: "Brady, Alan" <alan.brady@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Brady, Alan"
	<alan.brady@intel.com>, "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Bagnucki, Igor"
	<igor.bagnucki@intel.com>
Subject: RE: [PATCH v6 04/11 iwl-next] idpf: refactor queue related virtchnl
 messages
Thread-Topic: [PATCH v6 04/11 iwl-next] idpf: refactor queue related virtchnl
 messages
Thread-Index: AQHaZcIk2RWNiTs/PUubal+LdCMD+7Ej6iaQ
Date: Sat, 2 Mar 2024 04:34:27 +0000
Message-ID: <MW4PR11MB5911C0E7DB23BF75E47ABE61BA5D2@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20240222190441.2610930-1-alan.brady@intel.com>
 <20240222190441.2610930-5-alan.brady@intel.com>
In-Reply-To: <20240222190441.2610930-5-alan.brady@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|SA3PR11MB7628:EE_
x-ms-office365-filtering-correlation-id: e8e86f03-985c-4a1e-e3f7-08dc3a720bb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mo5WEQuk1zX4YWPdfXbn9AnSosek+Yd0hjnqhaWA+3X0Mv9OsR/aReDPy2vWvQXAV4YCDWaUcXw7ngiWUvptXaP4v9wYx39h0a2BRcxDBIYonewJot20ZwFjmP+2dWWegoJaW4fCueMo4ntMGPPCYbGcVwHqv7/QyHy8kKwwu3FIJQl6C4tudQNpYZoTQObDxMnyK6sbHQ0tHbNi9Abu5SbeP6BClnizL1uvQjhSr4RgB1sUvgWUfat5rZ2aqC5ZpNAMSpI3PpVXdJwk29tLnS5PHPSr3YW/qbZnebtU6Ooj5fD69voG+IyDtH0mWGIa5e4uVVJX0ubiAnR0TE3UL3chYmlpUM8gQSTBezUrJqLC+LXHtYph4fhg+RDNefhqZRx5C2Aiur41e3hbuZIP3jX0jMBYtS+ZOIIXWAMMhFz0BPKn+Lcrrn2e3zFgDWQC/Xbrq+qRXS5Aj1f7zRNg7TUMQ5fVroFJmCgUcDlwGhKVTGSUfGIo3KaSPLusq+kqNOPk5PUcGLPP5y4+EO93n/kexhunF4lvAmRCbUrSDaAH8GEXCD+ZFFHj/tT880MECIG5icngocEwuMNUz8Omj9y9s6A7w5dfxz5mknxwwaPPK5oqTkannCKhWyOy9Und6aSLwhtGmSxPWhYidQPFKLoLwxAhkc9rXBazdmHyO/o1kAAHpf0UKJXHTex0AOg9H70SStv9uNyJHZkztqIXrtPo6BTGt9JnS+uouuKzNzc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KNcoD0Os6dQUmG1oQ/kd4z4LD09N76T3z5NgcJ9JAAM/LwlgjD5RaJM53ll9?=
 =?us-ascii?Q?KtPMoGpyhKONiXMxPh0Bg4R3eyq8UG/dtf1eqk4xee9O5WUhCzwEcMk7DOdw?=
 =?us-ascii?Q?cF+gOQNwpJB2dyErPFNkv5/E2J4Tn81q3310JX3RX4YvZyF/BURfY9iPsy8T?=
 =?us-ascii?Q?xCK4mPrBINl3JkDy8mWl/37UIeGwbj2HP5d3i7z+PVvJNVIz28wwJmqHozaN?=
 =?us-ascii?Q?/v/jHH+33Gng00wbGui1CD+JE73cXdrtBUjIkb/zASuTeGh6EU+M7WRGHmBo?=
 =?us-ascii?Q?vOWQwCOoVDpcaD0URpAIDdc2eCE9+IwsTls5+ORN1LW+BrqjnlhCxJELFpYh?=
 =?us-ascii?Q?vf/A5+OscTN27yVX14UyKS6WA46XkRK5B2T1kE+YkYq6HgYOhcupY6zM4lah?=
 =?us-ascii?Q?uG7/eXm/gI5dKxZM6Nps7N5mAXM+/6Rdu6bt0qvKWO7kMrrnoS1hYZKxfC4K?=
 =?us-ascii?Q?hf2eZmKRyZ3Y+QTEMw/9buUiV5q4QYw/ymvdgANu6ZYn5a+Z8kQUXzOEn7iV?=
 =?us-ascii?Q?0d1DePMTjt7UCu6hiUJv+aJBUuWB+yh9ZKTmSwv9BRcfVyKwc8O5HsJZpwMZ?=
 =?us-ascii?Q?KHDCZkeHRBIYXys73Qo8z4ZV7hwF0X7aRW+QafxilDZ3yypPyfvWSZEivq2p?=
 =?us-ascii?Q?G0+O8J29s4QdmGOQSihSaW0MqLbGP0ryzovoUePgKPi7cFfo5UmkY+zmkDuY?=
 =?us-ascii?Q?/0GQzPn0YQFmUMkSXj1x/vkUhpT972uRJUkvuu7eo4eX/TfVLWUut32H/WS5?=
 =?us-ascii?Q?9jA5tODpYyBbq5rdm94JObFqRUxdJcd6pRYf4r11xVFl2qT+hfxxpYSu4TLV?=
 =?us-ascii?Q?aVq+OpqKkulr3MmyEnllTkQcFQJOAb4K3Wj6nnpWoUi1ADcoXU7SG+zvb55f?=
 =?us-ascii?Q?A+ZMnjgkKe0HnN+YaMwCF89nFU0ouFAzc0pjewOTfRHvJs/rq2JW83osC46N?=
 =?us-ascii?Q?tiufMIHQ78BvBFupaHL8QiFqQSYErLyTJv3V6a5G5d4Sjk6Byfxogqnfjyd+?=
 =?us-ascii?Q?tN4d5en0IvA18Z0RZ2a2lBaTPyZGEDIGWnt0NdlJnd0BuCHxVg+KCuEx5Qik?=
 =?us-ascii?Q?m8puxxFDazmuIlrqD0/f1YcBPCaOcm+dBCIfxQyt9tdSaRacO0Wdwjm9UxNl?=
 =?us-ascii?Q?E4qHKrUxt6uapiOaxyRuGRYuMEupU9nGY1PdKtpfsbPI9oK4+QDFLl/BDeSq?=
 =?us-ascii?Q?Y9Fj5CeZTVs/bEBW6gUrvSvS8h1FBsBWXHMNarD77lKEepf0xHMDH1XxlSkq?=
 =?us-ascii?Q?0YRbOvyUZb7u+tYd36nHEFndJD+Bv3j05iTkmHqbA6cG2eOEdMiqquYaUQXd?=
 =?us-ascii?Q?2TN7sgZOwJ4HY0JYwSH4htMLEAOidiZzN/swIfnK1ya7E89E9rRZ8TXq29ea?=
 =?us-ascii?Q?2S4/4SKuLBpEoRcjkjBiCBKszxTkIh+FiAy+Faed94oQWD+fJKBOBQ+4p82O?=
 =?us-ascii?Q?hQpqBcdRjFxduWNCNJA0FOJ39VQd7MGeLhBmxKl/H/UlYwxBzQ3a3B2IlWAH?=
 =?us-ascii?Q?0giEDczlSzkZpYq3hKsq/vwjBn+T6zUYycxSPHpJLa/5JqFyUr7PCKPSCbEs?=
 =?us-ascii?Q?d8nUm7KG2GKFvaBeOfNW3T80i52LDaadLp6M36nvOtN5n0UkGfCbSkS5HW0n?=
 =?us-ascii?Q?KA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5911.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e86f03-985c-4a1e-e3f7-08dc3a720bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2024 04:34:27.6565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEQYLLHCHleL6DBVN6pUD1g9KMP93qMbbgROddXbnX3m/2yXsvE5d+yNHD04+1IoBnAYuXd9vowzYTf916X8VfyXEVjjagrh5T7qorJ5XPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7628
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Alan Brady <alan.brady@intel.com>
> Sent: Thursday, February 22, 2024 11:05 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Brady, Alan <alan.brady@intel.com>; Lobakin,
> Aleksander <aleksander.lobakin@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Bagnucki, Igor <igor.bagnucki@intel.com>
> Subject: [PATCH v6 04/11 iwl-next] idpf: refactor queue related virtchnl
> messages
>=20
> This reworks queue specific virtchnl messages to use the added
> transaction API.  It is fairly mechanical and generally makes the
> functions using it more simple. Functions using transaction API no
> longer need to take the vc_buf_lock since it's not using it anymore.
> After filling out an idpf_vc_xn_params struct, idpf_vc_xn_exec takes
> care of the send and recv handling.
>=20
> This also converts those functions where appropriate to use
> auto-variables instead of manually calling kfree. This greatly
> simplifies the memory alloc paths and makes them less prone memory
> leaks.
>=20
> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h        |   2 +-
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 393 ++++++------------
>  2 files changed, 136 insertions(+), 259 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> index c3b08d4593b0..ed5474c1565a 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

