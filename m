Return-Path: <netdev+bounces-307722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YMIiODtVV2q7JQEAu9opvQ
	(envelope-from <netdev+bounces-307722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:39:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8164275C947
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:39:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="i6DiV/o7";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307722-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307722-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F241B300558E
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B1F3C945A;
	Wed, 15 Jul 2026 09:39:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D793CA4AF;
	Wed, 15 Jul 2026 09:38:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108342; cv=fail; b=UAXnjIGRdnl96WrjVyrnp6vctn/8If4MQbsB2/qthFxtJ+j/NyyMuK5UHGDxsSqihaiWEnkAQxHRHikuYsDAVmikt85dTfdxPpADu8NNqTpuhjBnqluV8BaRU3ryJBFIhSzZ9nAs71n9u6P5k6gYAt6KS+Z4QqFkJA74Cph2LqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108342; c=relaxed/simple;
	bh=RCg2fFTbnIX6Nnzqb9S0uAludpOd/EFiaVum7KL8Nbg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hSVDPBYzmee2lEyvLxC0CRXBQumlnofvJNFSG7iRzRWZcyEhxtcdl60c8bNwQj5cwezst1thNwdUTvYpu206vy9kChEnQcU6OWzFTQqqkDk3Hf20lY3hpIuFaLsQ/Q/K7/eae9BibBiG7Yk08pcZ09zZL1THfq/lSumsalUT0j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6DiV/o7; arc=fail smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784108328; x=1815644328;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RCg2fFTbnIX6Nnzqb9S0uAludpOd/EFiaVum7KL8Nbg=;
  b=i6DiV/o71YatOTqbMl2CaDM2+G6BmUveoW+s1aXD2R381a/LEfgHyZt/
   7Jyzac9i4qSxSWJVqzsO4qmLjnApCxa+XflcQ8B/Z7KvInKeB6BDrrXN6
   febZcmuM4mNfgUT4xp4662SJJ9PttpZm/N4PLgmfTHHoCgtWYuMh+P4tP
   R/QpSee3tc0E9pDAJDfSg5V6rlF5ro2fV2OaReqrEFB8sza7945ZaeNZS
   fb63ChqkuBpNXxNpEgQVLxj7bt1vpddbU2yhfP/tY3cDRSayKcblqs09l
   xrD071jCav2T/fs5SGMr1mjbzRh2IivEMrUdw02dM35WL8s/GxUaGU66D
   Q==;
X-CSE-ConnectionGUID: +x3TJVvZTWeCcr4CMIeCew==
X-CSE-MsgGUID: xzYnxGk0RrqHk61yq1u0ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="102163436"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="102163436"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:38:42 -0700
X-CSE-ConnectionGUID: AlTII0tIQ2KcOZO8rOhmFA==
X-CSE-MsgGUID: 1aX1tQ0KTM2904QXJf8F2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="279418325"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:38:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 02:38:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 02:38:41 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 02:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SacJi7sSI4SM+GCBkZqRUI4/FMLZD+s3Q0A0eGve5yZid8mblbj0JFHEJBp9keF7dTr8njQ6dY1Licb41ptE2iBZEA7M+ZIfAeu/obf/qm54QJQzWpAEWFp8iVzO97G88+soFf8KM9lohxEiqaArC10fhvjqXh6uUNRUUKnh80SQyYV+p6HZ2/8Q7gNnoJZBjOCLQp9fw3XqPaXdbs2zmW/npNBIZS8758OJvI8EmNMQcJIsPm8FpKcJcWYGtnB/wczfYsOz5gpfQzHxaVS5T8DqsQnHwxTElxH3iBZd86B65XzgRunHxXgFKdfBty35LGl3uoP7jMcPk4HtkTGy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtAZGRHqS3Ukoxjkh/SxXN0t2twzU7+YA6l+ohrVTf4=;
 b=NZg7zynQYQZEy39pWm2wxJdbTWY5Ro1FBoCa9GscsrfOEm5pIlM04jZQS3WkHiXU09kw+1LgMELpqee4rSBtYvM95qTXoeVbG1Tvfzfdf4y+RqMqYmsWRgxHA8U3LY98rgrR9vJN3IbsZVogKQzHAo+/BeKUeS0Ze6sELCnFrbWRNTwnzLeA/AuVkSgneX/Viicp5uBxt06p2Ma+4vMZ2fAD/W58WmO7QyfrYskn5W56IjCRMG0ayAadRQG94fYiOLKxupc0QnTL7j2HvqfCoVFhcrXnRp9aDPyqleNJy8NSvr1d0uwwCXwaIceVgm3Cc1Ej/2XWp1PzxS44Vb2vaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL1PR11MB5287.namprd11.prod.outlook.com (2603:10b6:208:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 09:38:36 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:38:36 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Myeonghun Pak <mhun512@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Olech, Milena" <milena.olech@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ijae Kim
	<ae878000@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH v2] idpf: disable PCIe PTM on probe
 failure and removal
Thread-Topic: [Intel-wired-lan] [PATCH v2] idpf: disable PCIe PTM on probe
 failure and removal
Thread-Index: AQHdFC3AZHm9yyn95EixDZMW4WHV3bZuUv+Q
Date: Wed, 15 Jul 2026 09:38:36 +0000
Message-ID: <IA3PR11MB8986F325F096F9B8A4B96E12E5F82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260715074342.49281-1-mhun512@gmail.com>
In-Reply-To: <20260715074342.49281-1-mhun512@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL1PR11MB5287:EE_
x-ms-office365-filtering-correlation-id: 32f7a85e-6ec2-4acc-6d88-08dee254d829
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|38070700021|11063799006|6133799003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: OPa9mLMlIN4dtMmywPyYAHEziQsXeh4KofybgtbrkVVcdavXn9HWd2ZoLpbnYcCI3sz+VMMwPL0Q9HYOZij9fYq0MFRQYckbhz0sZrw7gQa5WvhhFumgNUoZdNsw/Lf8P2IKC1JWZfuhUimo38LkvoIvduNcDDva5AXn9qDhfwaYHS8KiQCGzVkNeGtDmuhoW/0PbhGLVWfRJDvaePDvgJ+urG7xwKQFa/u82CeqoypRRZG8s4mLTWZjpl+QZHHZ1Y7ATCIPVyRkIHhWdOcDHRim+aJcsi1K6ORV6/kvhRogW5bFReulY4Z3zr1XI3n56LMoOuXHjuk9rxYN8O1k5B0isq4UZxFbmWHVAAin/vzvQMKoNKErpfIWZ3aBKuTwxUCZi3bei7WX5L8mzsFgtF82q/GxYsAxqN8euSWA+u9J7bCVxTmsddwwU9v1FgmB6a6pRmjRkngmRN6PVjLDrCZuqUrT+TDoIwihmKn6L4A/bIQt0RbyBcONh6l5qvPUhpJaN+U1pqHo0FkZ2dNXGf67Z9y42ghUGAcKzN8C35x+zM/tuaJ3jdkVIw2ricXpfs4SOEypmm55zWcOCl4FSaCYuTQy2IkmEbEB53lFu5RfFicAGq8gZPjyw74O94n/sIgveTW8X1rtzQjNDq/lECcBMGPdgUV7O+HT1JSh/4wVd4XEYw7T+0QQpU4cE2QW3s2chpWPscpGqz7HX+e9TL9FreIZYAx8D6rWDkTA6fM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(38070700021)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JmoRWZyWAdNEm+tKWxu+JOGGnO5eqQADIsnOzCLcTBH2SaZ0tYxi/aKx08cf?=
 =?us-ascii?Q?hDHU7brqV1UXQ3HaCyoh5wnhVtcXy2tk3ENcsZ6xn8NJtONQEXp8Pkab58Wu?=
 =?us-ascii?Q?Su4E/gRaAgz0SrKNd8Eu9Jpt0GJ5wBqRayR//HfkIClL+ruhlawZyvQ2MZlJ?=
 =?us-ascii?Q?juTuqNtyUUyfkaeyn2RTHRNJ/LdCF32B+rIfg5y2Hx1xZbD1QbylKChd2vTD?=
 =?us-ascii?Q?luQ6W/hTpQMoqD7jNmPTnhhfRuHI4n722VNI/5Nhb90d/0s1Jfs5ERDQ4MU2?=
 =?us-ascii?Q?wbqdja/tbm+ZF6XPB8dW1RNHiX2LjCna2CXMKzDhGD10hOkOBlrjX0DSLhpm?=
 =?us-ascii?Q?e6o6ZMaAWC2DgVPhz7We2+s9XwbyY82b6g+ZJ2/RJ2abcqlfaY8B0MlABlgV?=
 =?us-ascii?Q?ekTwjhDLLMLqxvW6/kAGoZRzfRHW8BqPsJ2a1/z0FnJRD+6WLvgDuRUovAdI?=
 =?us-ascii?Q?KDr0cXYWAb00QbyjDTXLCr9Z2eiYLwkfwC2VXSZqvvluZXANPeIoCbIwCXKt?=
 =?us-ascii?Q?JCLhN7gZOKWdDPYoDSx/aYcOxg6L5LB8TQkMAZaA8mKKKaBUKWC1EAqWZIJk?=
 =?us-ascii?Q?N3Y61RzLt7WxKOavIyPr9mjP6QP/MyhNL8T+32MFW5EPmJQlw0wtXbv+qQYA?=
 =?us-ascii?Q?O2oOrljFTVDW46rHye/mQjzu8B+txnZsKA75drFLeoCiu+NixnjTaOESACIH?=
 =?us-ascii?Q?3FTpbHY7dakTnC5VixHjk7Gv9FnDTsm7ICYrKipSp+rmSNvEzjOM+zxJXKFP?=
 =?us-ascii?Q?SeYyB0Qixe8goJ29ByOlIXxZviNc4jrsDgyBf5UVmjBWO4NHT9R+qzY/TdTd?=
 =?us-ascii?Q?dupR2+l9L885i1qoC2rrweXE5oXfNMvlRnZBR20eP21lOPt33fTg4+JWe1jz?=
 =?us-ascii?Q?dKiZhweDh1Kw0TCOGdTXorceP3BKs6+U1l/DEIW3GnsnonUWzXXtDqeXUGjr?=
 =?us-ascii?Q?p/LZTi06ip/WrET9lOWTlsXJeSo2+GbWmBBP/XenNnftMVYr+TieVM/B39II?=
 =?us-ascii?Q?pSp7dgLY9TvBHYHDDmCe6TDBQvX41hnYlK11fHzyrzWw6XOHsLQmjsjTs5fT?=
 =?us-ascii?Q?6evN8sKGSuK8PlQ8rZAZkEPogzG8w25nGn8SdFLTTnWBbBpgXWIm+XWD02dd?=
 =?us-ascii?Q?Xjq0ofsy0JoXx5FWdb86NQfQrTc5IS3WYo7JSC2b1kCNwAVyvpFRjsyfV6D2?=
 =?us-ascii?Q?VcV0RpGzQIlDzxdz8gYGew+SYGyyQRHHs9VpBIB6O3XsGyyybJ9mlOJls0cU?=
 =?us-ascii?Q?uMQU7DFQYkBvmaaL7jA59kuhxzyRSOB+Jjou2iWQTAZSSS35h8sTxgc1uX4x?=
 =?us-ascii?Q?KZkbwAi3sCTUC4x8qlkhCRcNkF4eRqU8fSLz7boQmjNqYaa9Qu7MaY9MIB5E?=
 =?us-ascii?Q?5tL6VMu3HMlDuUNLUPjNtxq9iq+K5O/MO3PREzuWj2eEqVDe2tEZ/PKKVJkp?=
 =?us-ascii?Q?xC+xGqIjfeNhmWUFZNgsAb/R6+mTipsyqKpM3Yw1ucN1BFwY4+npAx5Z/MXE?=
 =?us-ascii?Q?P//MS9E1C9ZX/OxSjKLt/RNwkrL6PSwn/CZ73V6rLVilwrv1SQFN8a3H7hIw?=
 =?us-ascii?Q?dwhaYRN8rVbxs8jYBVbiiwzeJWHKQpPMGIq/rzwx4/oxTNOgWZJQIEqrBzTo?=
 =?us-ascii?Q?4fkdl30b/pL3ZOHa5jJmCV+G0ziRP8NNd95SOt8NV636UzzpmfQyT1iHOMUd?=
 =?us-ascii?Q?nq/ULJpWFf4UUaK6HdWmpvjvF1gXmBSllG190MGzNrBHrBFmAyz7iNj1RV2e?=
 =?us-ascii?Q?i4lpgOtrtPwMvgBJDcRdBHv7IjhhCUM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OXdS9lsMJBL7NIj1Z6jjgtd6fuvG73E9+G0z565zrXQlMRwIDaQx6Xq1BeOgjltS7GYlMr28QtnB7GLCBhvCknEmRZ3Kj/n8cGbK4DumL6zlWGIi+EmtzXkSqgC/IUc/rsE7ErMepL2qsR7++2+T1L6/AX/6fya+w9me6vRnjt6Ap9blYgqUynOUVuvXxij7XsiB+tn1X+nf6m5WKbCjelEAx0lfmqAY+QUYC93rg+ZFn74xLCoGO67e2bHsu//s0gxIFuJU2mto+w53X380pHcCzGHmrjnPRwyITSW2RVE1rX44GRLM9HI4Ri1kVPv4+4s1EIuD1wvsTbPFxmaD4g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f7a85e-6ec2-4acc-6d88-08dee254d829
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 09:38:36.4701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5p7tubDYQhVkwv4k2EhoAjcODUqTBcVEpvTngmofnpeOB95NpPdX0lXXMyqFelTRNPMB2iUMCQA1+2T5OkHWKV7BrEIwXk1rJxYdLUg850=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5287
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307722-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,lists.osuosl.org];
	FORGED_RECIPIENTS(0.00)[m:mhun512@gmail.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:milena.olech@intel.com,m:emil.s.tantilov@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ae878000@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:email,davemloft.net:email,intel.com:from_mime,intel.com:email,intel.com:dkim];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8164275C947



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Myeonghun Pak
> Sent: Wednesday, July 15, 2026 9:44 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; intel-wired-
> lan@lists.osuosl.org
> Cc: Olech, Milena <milena.olech@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Myeonghun Pak <mhun512@gmail.com>; Ijae Kim
> <ae878000@gmail.com>
> Subject: [Intel-wired-lan] [PATCH v2] idpf: disable PCIe PTM on probe
> failure and removal
>=20
> idpf_probe() enables PCIe Precision Time Measurement with
> pci_enable_ptm(pdev, NULL), which programs the PTM control bits and
> sets
> pdev->ptm_enabled when the bus/controller supports it.
>=20
> If a later probe step fails, the error path releases the allocated
> workqueues and adapter memory without disabling PTM.  The remove path
> has the same imbalance when a successfully probed device is detached.
> In both cases, the PCI core's software PTM state and the device's PTM
> control bits remain set with no bound driver.
>=20
> Add pci_disable_ptm() to the common probe unwind after the PTM enable
> and to idpf_remove().  pci_disable_ptm() is a no-op when PTM was not
> enabled, so the non-fatal pci_enable_ptm() failure remains safe.
> pcim_enable_device() only arranges for pci_disable_device() and does
> not undo the PTM enable.
>=20
> Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Changes in v2:
> - Disable PTM in the probe error path, as requested by Emil Tantilov.
>=20
>  drivers/net/ethernet/intel/idpf/idpf_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c
> b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index 0dd741dcfc..f08ce13c20 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -159,6 +159,7 @@ static void idpf_remove(struct pci_dev *pdev)
>  	mutex_destroy(&adapter->queue_lock);
>  	mutex_destroy(&adapter->vc_buf_lock);
>=20
> +	pci_disable_ptm(pdev);
>  	pci_set_drvdata(pdev, NULL);
>  	kfree(adapter);
>  }
> @@ -266,7 +267,7 @@ static int idpf_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
>  	if (err) {
>  		pci_err(pdev, "DMA configuration failed: %pe\n",
> ERR_PTR(err));
>=20
> -		goto err_free;
> +		goto err_disable_ptm;
>  	}
>=20
>  	pci_set_master(pdev);
> @@ -279,7 +280,7 @@ static int idpf_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
>  	if (!adapter->init_wq) {
>  		dev_err(dev, "Failed to allocate init workqueue\n");
>  		err =3D -ENOMEM;
> -		goto err_free;
> +		goto err_disable_ptm;
>  	}
>=20
>  	adapter->serv_wq =3D alloc_workqueue("%s-%s-service", @@ -366,6
> +367,8 @@ err_mbx_wq_alloc:
>  	destroy_workqueue(adapter->serv_wq);
>  err_serv_wq_alloc:
>  	destroy_workqueue(adapter->init_wq);
> +err_disable_ptm:
> +	pci_disable_ptm(pdev);
>  err_free:
>  	kfree(adapter);
>  	return err;
> --
> 2.47.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

