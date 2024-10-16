Return-Path: <netdev+bounces-136336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3819A15D0
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 00:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CEC28514B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B301D2B13;
	Wed, 16 Oct 2024 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="io84udQE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0E1B0F29;
	Wed, 16 Oct 2024 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729117896; cv=fail; b=DtW9CQArjCYRETVVpzgJkJR7y8m42NT4QeM+9qwGmtzFSYRXvjGD5Ww7PBviWEc51vHkn3E2WwVm4GtyQ7o2dFDrLDkc4IFBUD5xs0a+ojH/I0XLDP7wowEYOsWKdj66TixZ3AneGT3hw/z5rVP4rALBXwAAt+KC2kPjCrHub8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729117896; c=relaxed/simple;
	bh=BizUtCUwR5ASyQesyOvoWyltEsrFX34Y5FUdrYE+R/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m0viofTjH8CMiwt4qedWvIMLMz7ikT4p1b26MYUWbSDDCVY1TJRFnbr82SGAbCMyEkvFoJ7WjMaMlcQ5EDlrivSmnC3DxcfeKpoBdXIZMQQAbifvsWr6RYcAkF0xSrLjlGKTxZJ459S4ABWi/4dzYcTJgcYSY5uD00TYI9OUuCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=io84udQE; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729117894; x=1760653894;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BizUtCUwR5ASyQesyOvoWyltEsrFX34Y5FUdrYE+R/w=;
  b=io84udQELgwCDIRczIu8E66JS7O6lGFeN3RTWsRNcK9nY1YU669uSn2A
   Pm67rBpB+wsZlUJHqqgUUuD1GEhuV8zSX/xl6FkyJUSA09OxWfkwBagoj
   6YDumLn1lHQty30tIekHcHExaRZpmjxsN14tz455th+wp+WvKGgPa1M0b
   +0JMLEUPXaxLXuz1j1yZJ0QLvoeTG2HGfe+dD24W958qWeNoZ4gvWv6HD
   IPAau5cvdBPlg2gd0sJwxmMoAZ5idAHHw/axJIn/mPOwMjB5Vm/vqxFZX
   3t2DWqgRjSdB0LEzIGgUCbx3+tyQHBfF33o9d7S2TgvtgCWICcsH7jNtb
   w==;
X-CSE-ConnectionGUID: IUHbxkx3Q0iUSCnWLOP5Zg==
X-CSE-MsgGUID: qHgdGT0jSHainbEvMzS7Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39138375"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39138375"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 15:31:34 -0700
X-CSE-ConnectionGUID: utJAFz7nSGmaqq7Hh/Gjsg==
X-CSE-MsgGUID: FvdIPhsaTr6z7vCVeNB/sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="82904601"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 15:31:33 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 15:31:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 15:31:32 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 15:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zqe6g+WCrocq+tu2IUvZ3laLQ7vEmb3pPYW2lCaZMYxs/f8KNWb857IkpA5flOnwSEmdvhqcwISQYHO3aTBFuI+pXcdPph8vE9ViaCiCAzSiJ/YOzSCxgXRYwdK3uf3gfiXPyThxsiI/0SjInl52oln3Nk8qug+SL2X2UuiaIOwcOimpSJbm3Z7Zs2zQlF8AJiDvwLoGR7iasKgrnu1+bcOqrBXfJEoeZqOlRje6AqOLomUNJ+o5je0B2aPLkoOPAFwqIsY7E/rAbdRlBDr5kfNKViSkWJyZc6QRxhYm5gs47PDdKMR59dgMSLPxPDOY5nhFDt03lPyTDNBbMiZbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95uJI37J86n6aSUifxkRxIQkeqZet7stPI6+7kBPrak=;
 b=tV1yQDO+Xt+3p6SJTo2qoZVP7i2O2vyjLdxuY7HLbsslIs84XwhyHcxZi4NVMlsoAIBI7OAY9/4yl+1/Fk3sU4pJfpmyn7460rZ/sFRbjr1MbOgfXV+sbdzVb7d+yPiH1/LexFIsUWuDeQdz8bfR6HXyn80Jx+iiGRUQk7byjNtTUfa3mj25KaztoyoUH+obczPGHuz19Egw6qMyXxvqXdI4bkbLSlDfLjx98nPOChqKWePVQJFms9WlYXvDIJU/IP/Ui1Uo5VUxeUk+u3/uT9ozXwgdA+Y2CVo2a3DyqfC29E6DRP1YkEqZlB3QHwQjLgytG9pvqHm1cQKPJSPipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5093.namprd11.prod.outlook.com (2603:10b6:510:3e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 22:31:29 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 22:31:29 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: RE: [PATCH net-next 3/8] lib: packing: add pack_fields() and
 unpack_fields()
Thread-Topic: [PATCH net-next 3/8] lib: packing: add pack_fields() and
 unpack_fields()
Thread-Index: AQHbHA5vnE2jdv2v3ES9KKHxeuCXIbKJXz0AgAAKlACAAJJnEA==
Date: Wed, 16 Oct 2024 22:31:28 +0000
Message-ID: <CO1PR11MB5089220BBAF882B14F4B70DBD6462@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-3-d9b1f7500740@intel.com>
 <601668d5-2ed2-4471-9c4f-c16912dd59a5@intel.com>
 <20241016134030.mzglrc245gh257mg@skbuf>
In-Reply-To: <20241016134030.mzglrc245gh257mg@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|PH0PR11MB5093:EE_
x-ms-office365-filtering-correlation-id: 156a95d0-67bd-4d7b-1799-08dcee324737
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Pr/KiztzVzHChRr3okWUS+GQcZ5TW0yoH8qlhw9DVPM5d9mkOmEPBs37PVkc?=
 =?us-ascii?Q?ok7BbM8y72XE2iDN5pgVP/t92fhKyGu/OH9wDXrNUOf8ljO8kYuo0BmEKvet?=
 =?us-ascii?Q?f6h0/yr8ulVsoq0BHVHLSCbKlZG0kw2oEqUULw1oBzKBj/35cbpLEeR+tZkx?=
 =?us-ascii?Q?lrdTXCTIiWSyYyjLYE1TEB1qLFuWgcazbqgye9oKtN5eI0/YiVAMeKVJuwSY?=
 =?us-ascii?Q?CUbiXa/plbLDJwbA8zoWEiYAoSi3LxegEYKqSoAAVQdH5DHNLejjtSiCOgCG?=
 =?us-ascii?Q?r2M7hihb6xIz7kOmuwGMsHexLXuH1ynab1QPNgq/uPoiuGfaQJUrqqxnwaH7?=
 =?us-ascii?Q?IaL7W8d5u6iVo2yPNLca+OZ/6XTYu2Gbc+0AY+s+ShcgzxzFMeMahV29iQge?=
 =?us-ascii?Q?UEy46yBxTRM+G5kLSHHWJJAf5e8h+ZGawM6L2qbxdd4O4PKCMJ0EWdOexOlB?=
 =?us-ascii?Q?RwZSUXNFg6DhVrNtPZ2F8agEBMrB5Zk51UUkHh6JYFkT81+iTwzttI4R1pIN?=
 =?us-ascii?Q?jpDHdg4Q9CrtYSEwh/WaVTGO7hrf6ly5j0uzymHYiJr2lbEQ6/NDa7OwdLqS?=
 =?us-ascii?Q?KNMh5WL3i5jDswDhNvQMoQ7KawNV3N/jDmSgfinKDb0gM4kN34T+WpugWCj7?=
 =?us-ascii?Q?w8TvVJ43ONt0eQcFC3VkehUeIHM758xW+waSTJRaPuOfR+FJWQanzMv1hmZZ?=
 =?us-ascii?Q?7d8QsvPvj9f1UOkB419hPq/fs2bQw3FkLX6qRGJgrDSw3K242Hjxv1VfC/7i?=
 =?us-ascii?Q?G+aJ0GCw3yr29WaSCP0LGZIWiNUHgnm0yxv8QRBYM5WQtP8Tihf+Jd4JygKx?=
 =?us-ascii?Q?FqxQ4HfP8j3N0G5dJfWUWCeTZm5mSS29Cl9KNGevEEHmF/nPhrRLcZCCvfdV?=
 =?us-ascii?Q?/MZX9mjChktWGZ+WBVAt62PsQQQx9FlCPLN+wvs8Y/YjaHJnxOqte7bOyRt+?=
 =?us-ascii?Q?ShnUU5mTlqMSUeJFAX8s55RLUwAS4n2RuYjD+eWNADn0IwTSTftJvIzhFcXC?=
 =?us-ascii?Q?Soj/pwEbSEQuTUr38he0ZxxrH8piR5781ezu0RvFojDvpVaXydcTx5KKRHtA?=
 =?us-ascii?Q?8qtK97q8sfZSEou6B2NwZU4xB8Hzx29j77R149s8Pwd2plyY55iOse08o/3e?=
 =?us-ascii?Q?ysTWzqFNtgu2rs4w7ZLtBBHgNb3b0tGtlKPURSeM3H1p72mYRtBJnYJ3kEQJ?=
 =?us-ascii?Q?mkpcjjOuYPJS7sbXZHcX1hfDsyaMZIuPEwbg++KQpXmqgCvFZP2yTt1MDuat?=
 =?us-ascii?Q?MSZCqTGVmRxSeY5EFP3jN1E9M0hljJm0sz8a7Fd+YvHhoBTU38hhZA3XnrcR?=
 =?us-ascii?Q?Zw/hvbeTcCR+kKzqeGYT1cNMh8V4qvqVCslmGJ3KrmLi277mn808c9/e+Cyh?=
 =?us-ascii?Q?DfgWAkw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CvXmlyOBqFTyObinHEfExaYmc6i1vA9K3RHxhjLwzJeEVX3W2S9yvLxv25Pb?=
 =?us-ascii?Q?3Pr/5n6lhpmOpg8Kq/JptmcB5ENR23pq+x9i95Avsz0V3VrMsU7Ytart9jhq?=
 =?us-ascii?Q?HD2S0V9+4Fs4Ud292/Et87nBF+QMRgG8yXeqaHN1qCrPD+k187THRhDwHxlc?=
 =?us-ascii?Q?e45ROykSp1DvdopdDwxAVXJoHprU0yvah5Y6flmHOiX1vjTGcTMF6RVQNiiG?=
 =?us-ascii?Q?uq9Z1tQvJRPvBld6d6Xflk04LhtfzjTEJD12zWUv8x460o+mC3qokeow7Hqc?=
 =?us-ascii?Q?lH1uzqcL9RbInvzzLq08N7FslOUIRe6K41vCebAD8AAXuuTtYzr+7+noqHZ+?=
 =?us-ascii?Q?JADRjEEOjGeV3Jw2YhJ6HtN+LIeRyMYet5tjCOpTlT1cXvpBm+0Xg0wiiCjM?=
 =?us-ascii?Q?8pPpbg0tiKrZbpyWXzgZpKbnHzxvW+GM4LShcUIe04sQxsvZvWZDh3Kvji13?=
 =?us-ascii?Q?AaTo+UVwp+nKZQ/ggiL7sHYJ9l0Orzcspb8FaHKpOf6EJ/UbATluhjw3fN4y?=
 =?us-ascii?Q?iewAa2RCU+p9tTt50lbPYIxjviKO1ef0ihBMqPcbIeDW6PL25TdZVjhlNi1G?=
 =?us-ascii?Q?sD92+A+ORFyZnKIBoyzKbFBJDZlQP/dUNhjntpRLcsNucST3JrlobkzSoJkd?=
 =?us-ascii?Q?0rD5juYX/SPtOP6zp6SIaDqTpVvtrOCQ9ixWZSLZHbkSGc7ihzlxM6G+Ze99?=
 =?us-ascii?Q?BVXOFHzxnyRvXi6wQy4JrezwplebhBs68Uw0p+UOI0RQFYROj4kGj4Nm33SC?=
 =?us-ascii?Q?KVxPIfigJxIp9oAK0viIsKP9eVOItHdSb5iNF8aEpSyXYJlcfibvABDV/gob?=
 =?us-ascii?Q?SoI/N4Xczq9q3rCCT3G1RdQZX8CvgqWNc6z0NfmQDhV1wivTK+tDbGBRWhKK?=
 =?us-ascii?Q?YDJQacWgTdX/TmCsGER9s6+HE8G4PpK36PiEJdKBo0kaSCWpiTHxs2oTn3UJ?=
 =?us-ascii?Q?q9SG2PldhpHYI6B9K1oZsRiIRSzp3+6qAsdP8fscmIA3Yy/v4h+eZbzQH6rt?=
 =?us-ascii?Q?M/1v/j4+kZYxPYl+QO/fPH7ry1Txi/JlXpTVKbG5s4hXa1/n4Sp7gsZITjhl?=
 =?us-ascii?Q?ugxgLvy2/CUD7nObDOpHhKA5yGkR/A2wdnzslvVRygHR9Nq5ReUWBcPrMFzt?=
 =?us-ascii?Q?HNiXYXHPnIo250W4dkD7XkzXJ2fpMv3SlhuINMzddCSN/UJFO5wWxqvmcBLG?=
 =?us-ascii?Q?aTJap8njdy/EwMkq3AwBL4XaHqh55YTtclRFhw2yvjzOcKVdmOmODB9SYc9c?=
 =?us-ascii?Q?6IsT2vOJZY0hpZoE1j0MgisWTMlap/SD20P1wyyd5+La0QJppCvh1oBEEKnL?=
 =?us-ascii?Q?n8F2rTm/9ty9MNPljuuIGGIzKnr/5r4gl4SrkhXaGd+/KnmoPCYu9Ci234qP?=
 =?us-ascii?Q?HiNRO9cF8pXO1GwJt4HvIB6LyZFfF9gWKjmmGRxkfq9wYHPS8rUek6Z+hbAf?=
 =?us-ascii?Q?ildU1gUdd9bg+L/mt7jD7ckgoyZSN3V3BgfKBSmj3hD7OvDsT5zkminrjx2H?=
 =?us-ascii?Q?pYhZNgaIWRPSIIOTkMB6sceJdnzA21/3Coor3syu7xd/Rf9B50SQYOFmV28g?=
 =?us-ascii?Q?M6we28fMNwdWVZOwMNViSKYHv3VONq2vctfWOPPO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156a95d0-67bd-4d7b-1799-08dcee324737
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 22:31:29.0250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8q3z+dWH4hKZ0tRSXSk4Pz3mezVTm4PxexazE9/S116gHQJ4bcihAzts7enQkGnlt6duExx44QJuwBVYY7FFgDF7rG/aAbxth706IvvoYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5093
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Vladimir Oltean <olteanv@gmail.com>
> Sent: Wednesday, October 16, 2024 6:41 AM
> To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; linux-kernel@vger.kernel.=
org;
> Andrew Morton <akpm@linux-foundation.org>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> netdev@vger.kernel.org; Vladimir Oltean <vladimir.oltean@nxp.com>
> Subject: Re: [PATCH net-next 3/8] lib: packing: add pack_fields() and
> unpack_fields()
>=20
> On Wed, Oct 16, 2024 at 03:02:38PM +0200, Przemek Kitszel wrote:
> > On 10/11/24 20:48, Jacob Keller wrote:
> > > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> > >
> > > This is new API which caters to the following requirements:
> > >
> > > - Pack or unpack a large number of fields to/from a buffer with a sma=
ll
> > >    code footprint. The current alternative is to open-code a large nu=
mber
> > >    of calls to pack() and unpack(), or to use packing() to reduce tha=
t
> > >    number to half. But packing() is not const-correct.
> > >
> > > - Use unpacked numbers stored in variables smaller than u64. This
> > >    reduces the rodata footprint of the stored field arrays.
> > >
> > > - Perform error checking at compile time, rather than at runtime, and
> > >    return void from the API functions. To that end, we introduce
> > >    CHECK_PACKED_FIELD_*() macros to be used on the arrays of packed
> > >    fields. Note: the C preprocessor can't generate variable-length co=
de
> > >    (loops),  as would be required for array-style definitions of stru=
ct
> > >    packed_field arrays. So the sanity checks use code generation at
> > >    compile time to $KBUILD_OUTPUT/include/generated/packing-checks.h.
> > >    There are explicit macros for sanity-checking arrays of 1 packed
> > >    field, 2 packed fields, 3 packed fields, ..., all the way to 50 pa=
cked
> > >    fields. In practice, the sja1105 driver will actually need the var=
iant
> > >    with 40 fields. This isn't as bad as it seems: feeding a 39 entry
> > >    sized array into the CHECK_PACKED_FIELDS_40() macro will actually
> > >    generate a compilation error, so mistakes are very likely to be ca=
ught
> > >    by the developer and thus are not a problem.
> > >
> > > - Reduced rodata footprint for the storage of the packed field arrays=
.
> > >    To that end, we have struct packed_field_s (small) and packed_fiel=
d_m
> > >    (medium). More can be added as needed (unlikely for now). On these
> > >    types, the same generic pack_fields() and unpack_fields() API can =
be
> > >    used, thanks to the new C11 _Generic() selection feature, which ca=
n
> > >    call pack_fields_s() or pack_fields_m(), depending on the type of =
the
> > >    "fields" array - a simplistic form of polymorphism. It is evaluate=
d at
> > >    compile time which function will actually be called.
> > >
> > > Over time, packing() is expected to be completely replaced either wit=
h
> > > pack() or with pack_fields().
> > >
> > > Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> > > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > ---
> > >   include/linux/packing.h  |  69 ++++++++++++++++++++++
> > >   lib/gen_packing_checks.c |  31 ++++++++++
> > >   lib/packing.c            | 149
> ++++++++++++++++++++++++++++++++++++++++++++++-
> > >   Kbuild                   |  13 ++++-
> > >   4 files changed, 259 insertions(+), 3 deletions(-)
> >
> >
> > > diff --git a/lib/gen_packing_checks.c b/lib/gen_packing_checks.c
> > > new file mode 100644
> > > index 000000000000..3213c858c2fe
> > > --- /dev/null
> > > +++ b/lib/gen_packing_checks.c
> > > @@ -0,0 +1,31 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include <stdio.h>
> > > +
> > > +int main(int argc, char **argv)
> > > +{
> > > +	printf("/* Automatically generated - do not edit */\n\n");
> > > +	printf("#ifndef GENERATED_PACKING_CHECKS_H\n");
> > > +	printf("#define GENERATED_PACKING_CHECKS_H\n\n");
> > > +
> > > +	for (int i =3D 1; i <=3D 50; i++) {
> >
> > either you missed my question, or I have missed your reply during
> > internal round of review, but:
> >
> > do we need 50? that means 1MB file, while it is 10x smaller for n=3D27
>=20

That is partly why we generate the file instead of committing it. We could =
reduce this to 40, (or make it 40 once we add the sja1105 driver).

This would somewhat limit the size, at least until/unless another place in =
the code adds more fields to an array.

> The sja1105 driver will need checks for arrays of 40 fields, it's in the
> commit message. Though if the file size is going to generate comments
> even at this initial dimension, then maybe it isn't the best way forward.=
..
>=20
> Suggestions for how to scale up the compile-time checks?
>=20
> Originally the CHECK_PACKED_FIELD_OVERLAP() weren't the cartesian
> product of all array elements. I just assumed that the field array would
> be ordered from MSB to LSB. But then, Jacob wondered why the order isn't
> from LSB to MSB. The presence/absence of the QUIRK_LSW32_IS_FIRST quirk
> seems to influence the perception of which field layout is natural.
> So the full-blown current overlap check is the compromise to use the
> same sanity check macros everywhere. Otherwise, we'd have to introduce
> CHECK_PACKED_FIELDS_5_UP() and CHECK_PACKED_FIELDS_5_DOWN(), and
> although even that would be smaller in size than the full cartesian
> product, it's harder to use IMO.
>=20

Another option would be to implement something external to C to validate th=
e fields, perhaps something in sparse? Downside being that it is less likel=
y to be checked, so more risk that bugs creep in.

> > > +		printf("#define CHECK_PACKED_FIELDS_%d(fields, pbuflen) \\\n",
> i);
> > > +		printf("\t({ typeof(&(fields)[0]) _f =3D (fields); typeof(pbuflen)=
 _len =3D
> (pbuflen); \\\n");
> > > +		printf("\tBUILD_BUG_ON(ARRAY_SIZE(fields) !=3D %d); \\\n", i);
> > > +		for (int j =3D 0; j < i; j++) {
> > > +			int final =3D (i =3D=3D 1);
> >
> > you could replace both @final variables and ternary operators from
> > the prints by simply moving the final "})\n" outside the loops
>=20
> I don't see how, could you illustrate with some code? (assuming you're
> not proposing to change the generated output?) Even if you move the
> final "})\n" outside the loop, I'm not seeing how you would avoid
> printing the last " \\" without keeping track of the "final" variable
> anyway, point at which you're better off with the ternary than yet
> another printf() call?
>=20
> > > +
> > > +			printf("\tCHECK_PACKED_FIELD(_f[%d], _len);%s\n",
> > > +			       j, final ? " })\n" : " \\");
> > > +		}
> > > +		for (int j =3D 1; j < i; j++) {
> > > +			for (int k =3D 0; k < j; k++) {
> > > +				int final =3D (j =3D=3D i - 1) && (k =3D=3D j - 1);
> > > +
> > > +				printf("\tCHECK_PACKED_FIELD_OVERLAP(_f[%d],
> _f[%d]);%s\n",
> > > +				       k, j, final ? " })\n" : " \\");
> > > +			}
> > > +		}
> > > +	}
> > > +
> > > +	printf("#endif /* GENERATED_PACKING_CHECKS_H */\n");
> > > +}

