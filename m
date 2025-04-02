Return-Path: <netdev+bounces-178800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20DFA78F91
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F943A9FF5
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FC1235375;
	Wed,  2 Apr 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdEP1jhJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E23D84D08
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743599795; cv=fail; b=lv3UM3PTG3FipR+DUMtf9xkG+xsnmaQbzB3Jr6LkM81N8e95HB+Kt1WZ7qfIw/P0qkYxfL9KeBfUr/k+9X/2fQuVHKHuBrhGxjgZK8dpxr6LPB74ptMdMS5HPhYIwidDVHB5hy+hUpHggWNF3a4J2KbeX8luytIXNPe0+dOOE5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743599795; c=relaxed/simple;
	bh=aonpV65C15vZJ40wyytiCK/v4hMuTWLz9n8myCopnlQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uy6oeC0O2iB9PaMy4zLaJxQwcsLETprVshtrbxaJY+Bt/9ATYlDOI5N9Vq/Jffj9gz49IlMG/S/ND2wdT8C9iikQN6wseDuJtVRp0csIhlBlojTHWhzgPXTP5kkWqpXsPa0HYnod3usWG9N2aPAOM8Ty5J+gkea4CVncUuLNXkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdEP1jhJ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743599793; x=1775135793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aonpV65C15vZJ40wyytiCK/v4hMuTWLz9n8myCopnlQ=;
  b=cdEP1jhJ2GWkv1BEranQvQKTbya8dAOycDfnCQP2rAR21MaJKRAPweMK
   czDTb1u5iJmFP+dvw9tkB/TqUT4fQ6VTjkKwF06gBK5YYPP7Gf1zjjlTX
   D+P1v4lN8/pwRdoo+t/Ure6yalLHeuKflyBkuKG/Z0OfX576qj5dHns+o
   9+6wZKSu3WINleJo1kGQjC0/JyBl60KlTxN7YVfOQfxG5jNkA4tOCTjsB
   td71tnU4HVL7n5TDJgC0TUhgfzEt3zchfQnZwae8fhDcHGqHUpxLiEL0y
   FxZGTI4e7bHSni+ZxnoPgQbZyqqmORhcSyMhZ9SCYLAfdpv+c9eFSKQvz
   Q==;
X-CSE-ConnectionGUID: fMhx29VaRYOrX2FaahKZhQ==
X-CSE-MsgGUID: S6mg93ZMRg++hNYn44zvjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44221049"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44221049"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 06:16:32 -0700
X-CSE-ConnectionGUID: GPT3Dg5hSgWwz+lMVjI/tQ==
X-CSE-MsgGUID: at2zmcluQnSDItTy0dUrSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="127534820"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 06:16:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 06:16:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 06:16:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 06:16:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL5LxMJruHiEKtQwU7Th265OhoBTOShSaEx5b3tR1LxNc8qveTnGWUBThu4LiU+p5pY4L/6EUvZkxENIbOJAzTwSbkcGL4lrOv7uCJANvlMh4RobSVrC+angAknp7JGD2ZuD8cmhPlsPMMdgfuQpO8QZi3iZvyczvG1ZYpXgi7Jqlxshcce08uzm3odrDZSoJZVF6qz5t7BhHmlo6mp3hUzHs84lc5lUfoYWDyPA7B6kytbiNJMNseGal4Fh6ZHMTOt5xdhP9Cpfn0K6lzFolHUxScyTS6x9HpLNyzHvT5gcxwfv+txT0m2RQ2WNLO5lU5GT/SC9dBjryIwWHyRakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ax5Rtb70SxpKeOWaZb/sdlamIjkxVsDjmWnY4j66L9I=;
 b=MudJTJtqyixTbEQdenN5ovzqgBCfzasppz6QfZNbO9+qb2n/6jILoIvKTN+wRCSmmcmu5ksI7ZmegDy4bSlstAAmL+2FG7N0vGXGjaVezzab3idBC02xAeGcP3FK/IYs5Iwu52bn3bE9aJ0sNtuKiCq6Xi4lpI4RLJnMlgCztDNnTrcrg/KGtLwrdpN9V/qFL/UdKIKTsAzy3HMQpX9ff+G8yl9s5hAUKRHtQFWWFbD+Rf96MWqZpWe8cWufEnOFLMg55L0J5tZTtE7HVDa18V7vj4WuhsAfAVZbQlDGVLMGniDTx5/5SkrpKbPBITVs564CZ5pCVPf9HCOdSrzOnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10)
 by MW6PR11MB8437.namprd11.prod.outlook.com (2603:10b6:303:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 13:16:26 +0000
Received: from MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073]) by MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073%3]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 13:16:26 +0000
From: "Olech, Milena" <milena.olech@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "Dumazet, Eric" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>,
	"Salin, Samuel" <samuel.salin@intel.com>
Subject: RE: [PATCH net-next 01/10] idpf: add initial PTP support
Thread-Topic: [PATCH net-next 01/10] idpf: add initial PTP support
Thread-Index: AQHbmCC3Yfj2SC1JIkGvjz8aPRkcPbOD1wGAgACMDgCADA5ZsA==
Date: Wed, 2 Apr 2025 13:16:26 +0000
Message-ID: <MW4PR11MB58891AED0B67637F23AD9C3C8EAF2@MW4PR11MB5889.namprd11.prod.outlook.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
 <20250318161327.2532891-2-anthony.l.nguyen@intel.com>
 <20250325054421.7e60e5ad@kernel.org>
 <08a7931e-3374-44e7-971a-e8e2a876eb9e@intel.com>
In-Reply-To: <08a7931e-3374-44e7-971a-e8e2a876eb9e@intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5889:EE_|MW6PR11MB8437:EE_
x-ms-office365-filtering-correlation-id: cb824c7d-64f1-4898-412e-08dd71e892b2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TPOLJa+a32MfxeCH1txWo1XPqYF1R2MLGCsDr15ISXJDm2BbZNKz4yLN4djc?=
 =?us-ascii?Q?Q76CkXVkEWZLxMCCV745AFsAeTw46X6nXSHkwX96WaE1sxXsvTs2nwWKO+Cp?=
 =?us-ascii?Q?5YkLbPo/poGCg/5KcffmLOVQNtErJvQR92iPDKuIKT32pbft5l0/ZGldBSyM?=
 =?us-ascii?Q?BSx+ZOt2VOpIbplQeHc2Vk5BQ4NybbhOLmN0SxJTNEpTto74c1V747xOaszF?=
 =?us-ascii?Q?IMUKl2Smw+gbFwbGrIrWZG4v3ezSmktSeAYD1DiKbH3M9OMXsCndbcpQK1CS?=
 =?us-ascii?Q?RSjnb1e7wTofjBMinvoBfYWMIvATsKkDBw7CnHzP+hp0EZ8mgDrSPawwVBFb?=
 =?us-ascii?Q?De6Dkie3CXt5EgWKQsuXBVX+Od3hz+n1epBubn7YAJ98rSNSGtm+7zd5L40w?=
 =?us-ascii?Q?T2ZjhMR4j1+gTOT9iUgr6Lf9zTOkGlwMS+JBIeRQCeWgZF0lIP9VDiXCzWpM?=
 =?us-ascii?Q?i6QmFKxdCl7ONVIlZLo9Vw6uaoiNJ1D+AoeJYeLr+u3FljWVnsULtdgHYFXx?=
 =?us-ascii?Q?fepuls6eXoYL9KDKX2RLCWmbWwrawZqVEdE8Vg1XsF7JI44z0qS0qPkq/14U?=
 =?us-ascii?Q?ChSSvrHa9hxWIx5UIO7lu0ufAH8dtIniY9TOSKDyQRSuMIE4+upyzrUOw6AQ?=
 =?us-ascii?Q?qYlpa+x6kCtb2Oir5fP3wMc7qIqQ0/31gyUvjTKMHg8Isci6TrPduRqg+txt?=
 =?us-ascii?Q?88n7VJHfE276K3UAtx0xOAf/M4PgChSO+Fs6XVeXxY3thEMte9RNH6cfJzG+?=
 =?us-ascii?Q?lq2gfRGJhUP0+4j0pwiXCtmE1/fteWdy5g1WitjUlZnaBZp0EJeEjjBqh8WO?=
 =?us-ascii?Q?Tc5tbYx3xTTRY8ne43aVdmVH8CeOoYSXzYy9fRtabRQfPpLh+JuS3lPmrELd?=
 =?us-ascii?Q?V0IovxN9esl83OyGatzpeJHiUrQfNHOIdMTY6/AmMWq9cvmBns/7emqO+enT?=
 =?us-ascii?Q?tGRdbq2IfLhNtelZoh/815wVfZcFVmNyVsJZSYL+UZIw4h1c+HijFcjwgLzR?=
 =?us-ascii?Q?PRygLxJ2sqliVfqTRGbya8HAKUiFZk+o6zQEcbeMB8f1stURgNpWqjAEEDdx?=
 =?us-ascii?Q?0VZIzvxLXvi52OSqnxx3wjvsTvlk1zxujkz3j7Ggw4sMZjAF6AscaFBZbNps?=
 =?us-ascii?Q?M4jWASDc42w9czaPpI19F3cSgk9yNQ5Q7fALHRbDRzo+Bbcj67yfQwplX6nJ?=
 =?us-ascii?Q?An2LOT23AS96Q1pJMfKvFVwKVbgr2FV5P+68+LTTMYHZCKzm7PpHBpPpdbl/?=
 =?us-ascii?Q?K0oyTQ4hWdNjLY6mOmiZ00g3zpAqsKC4eTrE33drag+HWCFiogM1QwdlM0Pq?=
 =?us-ascii?Q?XSVmKX5nM1cnw4zcO94og6uXWaGW4H648TPxyglg8Sxwi1wb/mXBuxj0mzgb?=
 =?us-ascii?Q?NTObIwO56wrYACyz4XHwx5QnYjqTwxXPXthqCs8s7gtO1W92d26uwoBaHpUa?=
 =?us-ascii?Q?T9ZAbWnzwpFLujZHyqJlysoVKl85M4sr?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5889.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uVT1p8ZiqNQDIKNd2/QHVcg0Ow7oLYd9lwVL/9X1spD2KNGEeXTErWy8A5Yn?=
 =?us-ascii?Q?MffQlTqCs2K7SUSwAXZ4AMeltiCNLCioIg0XW+HS8ioirTzPh7u9/yUVWL1x?=
 =?us-ascii?Q?/nlVAZJpO8KNUrwb4hc8nURT0hZHgVnG0bluKxk3cYi40L13UZ6zmDDJxwDQ?=
 =?us-ascii?Q?+LqRQBh1Igm18M+qlNmwUh/NpyUvc97kbf+8wHxxzVMv6w7cbQmFhqZaWlpu?=
 =?us-ascii?Q?dzY9kJ7U6V8E2mx42g2+hTRXzC2uyrH2fRsNu+HqprSlsgvKXXyKeSzAJNgA?=
 =?us-ascii?Q?qQ1q2D5lSS/XCvRWGp72SjreG67m6616zzziLRy39bao/MKKfoya9jrIb3YW?=
 =?us-ascii?Q?d+qHgigcQI18M7AZ+yFKibZtvnqusJGIS5hmcn4XCZSVSd+R0IBRlODIVG6A?=
 =?us-ascii?Q?KGg8puEWUIh0fQ4Jv4oDS5zGRIKsuVCMNapUBPzmxrgvigRGfGXH6kTT2+Gu?=
 =?us-ascii?Q?14oSsiEWfTHdUSBzdgVIOBu0ug/KuUqRahmwVxjEoK5bZ5PJcaAu80OettnU?=
 =?us-ascii?Q?ya9ldSU85IkYxSYjA+/Zhig9XBsJhl0YDn92z3mnPwYTruXci8TISNOxFgWr?=
 =?us-ascii?Q?Tmn8StR5ZoIMIK/R09G0a+wTnFJcvZC9LaxRyhGdUTEViHS1TmxcIxNGxAql?=
 =?us-ascii?Q?KkPzOqBHYqhF88wwdQJBQziw2g/knFvLt9SRMKuxwyDNZ2yigk7/tAJWt/ck?=
 =?us-ascii?Q?rmIYt0ikaebaeaFFo9e1bt7KATltgloRF0d/TZ4WE+Rx7FnWS/oa5jg28jOj?=
 =?us-ascii?Q?1Nj9fw8KMxQ9AsVujUMOFCZ9tujdGOOKATXI4BSHjTT7rUC5oKJQzXgpr+fC?=
 =?us-ascii?Q?XwLk3ClsOz1i9WbDxz4lpF0d5W2nKGm5ZKZdjg4sNoWCQUhUS2nJh0vqkAr5?=
 =?us-ascii?Q?wxrP3J85xRF5NhUwLG5Ob1v472LG4+FhIgNLhZjoPR+fQdxQb5ofUKYMunUt?=
 =?us-ascii?Q?zztMpwh4gq/5SqDTuNtX8fBw5AJ6DocTLo+DpryJU/fvjoQYNkbIarAfUsBS?=
 =?us-ascii?Q?ZwlmxzpumodyNiblVeBUv7ZBhTQTLHK3Vgz4e9fkuB1xXbll8ttFg+TMwdgt?=
 =?us-ascii?Q?1ycAsPCJsfYs+g98aKI469zC7YiBauQhnUdRkmC8QiHLNyIZaocFA5XpvJZT?=
 =?us-ascii?Q?soz1/SuXasJdkCxaktDB9jysDv+H2zXgKDDGuKD8ObQ/lj/VIJ5H+qNJqheB?=
 =?us-ascii?Q?wMcVKPsR1Ijxo5vX2M9oBDzdf206abZHdTdxNoVJbqjSXrsUt0MU9v6Eb4o6?=
 =?us-ascii?Q?1t8gyaF/cy1W+jGGgqvutaybGW7WSwghCfLr6mlMV+Ui95HdVrP32e7NBhLG?=
 =?us-ascii?Q?ZtCPxYyMhPLw3YRIL/Vth72ZFnXw+4lFfWWb4nv35gvBCipGNTUSPYUdH5+6?=
 =?us-ascii?Q?V0LBH87ZFyr/AtBCDO557vO6UFTB8VsqcjE3wah2cos6c9zfmCBXnpSgdUb5?=
 =?us-ascii?Q?kf2EgXxdMqqSIhENGJ8Nr/9c79xVA26CW9cyBunVzpYzoDS4G5wBnfiynxOL?=
 =?us-ascii?Q?FCrdV+qlk+0r9eA8j+LYlTZWpQLZMfbofEYw/ASy+dw9jBgvfkBQuGa2ntC5?=
 =?us-ascii?Q?FKUnWrqp/b+xqCHH9oefU4ktXXxKywOyl2KDZ74M?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5889.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb824c7d-64f1-4898-412e-08dd71e892b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 13:16:26.3545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8aUUHyrfTmCikDvKBFd/9kXP+LNoNLX3RuaQmVxUefOeFEzo58sXRJ8Zz+dKYU1EPBomfCbm2+PLAwWD+ShQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8437
X-OriginatorOrg: intel.com

On 03/25/2025 10:06 PM, Jacob Keller wrote:

>On 3/25/2025 5:44 AM, Jakub Kicinski wrote:
>> On Tue, 18 Mar 2025 09:13:16 -0700 Tony Nguyen wrote:
>>> From: Milena Olech <milena.olech@intel.com>
>>>
>>> PTP feature is supported if the VIRTCHNL2_CAP_PTP is negotiated during =
the
>>> capabilities recognition. Initial PTP support includes PTP initializati=
on
>>> and registration of the clock.
>>>
>>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>>> Tested-by: Mina Almasry <almasrymina@google.com>
>>> Signed-off-by: Milena Olech <milena.olech@intel.com>
>>> Tested-by: Samuel Salin <Samuel.salin@intel.com>
>>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>=20
>> Would be great to see a review tag from Jake on these :(
>>
>
>I saw these go by on IWL, and did give some comments. However, I didn't
>have the time to do a proper review so I didn't tag them.
>
>I'm happy to look these over and review them before the submission next
>cycle :)
>

First of all, sorry for delayed response - I was OOO :)

+ Thanks Jake!

>>> +#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
>>> +int idpf_ptp_init(struct idpf_adapter *adapter);
>>> +void idpf_ptp_release(struct idpf_adapter *adapter);
>>> +#else /* CONFIG_PTP_1588_CLOCK */
>>> +static inline int idpf_ptp_init(struct idpf_adapter *adapter)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>> +static inline void idpf_ptp_release(struct idpf_adapter *adapter) { }
>>> +#endif /* CONFIG_PTP_1588_CLOCK */
>>> +#endif /* _IDPF_PTP_H */
>>=20
>> You add an unusual number of ifdefs for CONFIG_PTP_1588_CLOCK.
>> Is this really necessary? What breaks if 1588 is not enabled?
>>=20
>
>This style of converting the init and release to no-op is fairly common
>in Intel drivers. I don't know about other places, but I think the
>init/release is good since it just makes us disable the PTP
>functionality when not supported.
>
>We should make sure to try and limit these checks to the idpf_ptp.h
>header file in one place, and make everything transparently disable if
>the kernel lacks the PTP support :)
>

Ofc I've checked IDPF behavior when PTP support is disabled.

About the number of CONFIG_PTP_1588_CLOCK in the code - apart of ptp.h,
it's used in idpf_txrx.c and idpf_virtchnl.c, in both places it's about
defining static function. Let me know if you prefer to have it in
idpf_ptp.h.

Regards,
Milena

