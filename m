Return-Path: <netdev+bounces-293661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BqmIYVUHWqnYwkAu9opvQ
	(envelope-from <netdev+bounces-293661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:44:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C616C61CB0A
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 417FD302BBDD
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7DA3438B4;
	Mon,  1 Jun 2026 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sd8AEISO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E29D30E0DC
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306648; cv=fail; b=KbTUvekty81KVntrEd217QThtCO4J+pBRqnRQCLtOKysC4jwxRJ6esGCSroOpN/lswoaZIX4Eivygo/S9UbyTBNJ+trLjoNvAlC0BipK/pFYcsLhSxtY1XOahj4R3YRVr1KjpQw+wbF9T2YKNGIV2B8KS0R+eM+HREtv4xmI8CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306648; c=relaxed/simple;
	bh=/LmGUxh9/RnTbreQJrohDFe4Ix/Xcmh8ufAe8BOKu54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z0Bxgq0eWG8BRAC8hVlEuIl9JKlUugetQFBhuoGkJnAv1LEsGEs+Xt94yLjs5uOJCDP55zRA9Ytjbv/77XXNPS2BW5BHCAE0dQ/BpTaTjoq+6mGvDipWSWZonRgV+jowNhR/J+RjMWwmdik8+cUEyskM4bIJexcikg9K1GZOKFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sd8AEISO; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780306646; x=1811842646;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/LmGUxh9/RnTbreQJrohDFe4Ix/Xcmh8ufAe8BOKu54=;
  b=Sd8AEISOnxHO4RQxAIhTqPrnFCv/Bdi40/2euboZOeJs+HZs0k3QtKNm
   m66tOqZ1IHlVdHRCMwhEfW27YLYt97nlYbiWXk1IBrpcO/sLTrvg0LLPd
   uzUU4HiZ4aanc4R2mQleetUUVwE5chKy3UJlh9Xtd2nsWN7EXEGA22G9y
   TXNRuK8GQDyrH0YBoG0pbq2QPwf+3ysLGMtkm8pY6nCGRvwBUz6nub8G1
   bzkAdZnCyDZEypnAuWFstuKrlSIjEsrINZWc75YlLc1O5Me21dBgwf1BB
   JyrPuj+M4SrnzQahUKomK2mKgK/eGYgnDD++B2DulemSIOdal9cYuqyQU
   Q==;
X-CSE-ConnectionGUID: UXAjTFSzQ5Cin9l/UwwZpw==
X-CSE-MsgGUID: pVSuGvJhTDKNK47pD/gD5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80200409"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="80200409"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:37:25 -0700
X-CSE-ConnectionGUID: +IJ2L6B8S0q8VcYF5ZDpXQ==
X-CSE-MsgGUID: hPwJjrjfREqqqU4RmpPxaw==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:37:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:37:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 02:37:24 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:37:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjAhzBc3UNrNv+ZmDnn8rUwAlYVyQ+13r0D39SFio15pkoQE0gQEyGYUk1bVqvs5uTqUKKdn/nJDjkWxpIijvE2dHV7ds97iDqkdvnzUqbw2OXhah8VVWixU3j7RyH8zH4zas9vczDHPnCwX1vcIAgUVH86PhKSaCPPHCq+VkL9zgdOBQ4+DKZpRDCTg1P0r1hFARdOxXg0PHEfT/L/hnFhIV4M7yXE+UOn7NLlqmlGL6SMJOA0ihNtk+QWI6440k2giHRh0ZTC6izJdvakP1olBZHAREhE860VdMvk0je0tgpb+4LVTWGpgwL8/NaYXuSo6vRZPTdTEA4x6fSxf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj29eXKI3e1S1zyWoTqVLETO7D9TaSnOwRDo//0W+n4=;
 b=syIU9eDy8d4Hl5dVHd7PPqowXvF6+eOZujR1e8JJP8nOrvfQY61xHdJq3cOlxWQGaiKx1x1coArPFkep6lo2aTezEOlAIJeRtqlJTR/IKLz78vdzgwoFT93E9vNJaBQKlfXB4bUQ8ZvGhiDO63W8BlIMcBPeJ+8bLoDa7uqrriFQ3CjHSI9etfwOkffYQCijrbZIpSYVt57spElkeUhHuBdcvAaEbC7H6jnZV/p1Qc/0hEhQk2QlkpKhGuJJ8KvlCXXN34Zdd6IoE0q++YY0pYNbD8mFN2MzZC8i3wgwP+t7Wna8nhq3gwAI+zv3GlMLwsqFF9nIS3a1SDe1z6q60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY5PR11MB6534.namprd11.prod.outlook.com (2603:10b6:930:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 09:37:20 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 09:37:20 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "Keller, Jacob E" <jacob.e.keller@intel.com>, Michal
 Swiatkowski <michal.swiatkowski@linux.intel.com>, Simon Horman
	<horms@kernel.org>, Kees Cook <kees@kernel.org>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, Ingo Molnar <mingo@kernel.org>, Joe Damato
	<joe@dama.to>, Breno Leitao <leitao@debian.org>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Johannes Berg <johannes@sipsolutions.net>,
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: RE: [PATCH net-next v4 5/5] net: wangxun: implement
 pci_error_handlers ops
Thread-Topic: [PATCH net-next v4 5/5] net: wangxun: implement
 pci_error_handlers ops
Thread-Index: AQHc8Ze6ZhUC7F7uh0eKB3FEJNd9/rYpcGWg
Date: Mon, 1 Jun 2026 09:37:20 +0000
Message-ID: <IA3PR11MB8986104B1CB7F3582CE9D5D8E5152@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260601072221.2952-1-jiawenwu@trustnetic.com>
 <20260601072221.2952-6-jiawenwu@trustnetic.com>
In-Reply-To: <20260601072221.2952-6-jiawenwu@trustnetic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY5PR11MB6534:EE_
x-ms-office365-filtering-correlation-id: bf5e855c-2d92-4c6e-dd9f-08debfc160d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|11063799006|4143699003|5023799004|56012099006|38070700021;
x-microsoft-antispam-message-info: ZU90q/beIrFnl87j48emKyzp0amRnlpw6+mCu6pFiN/0h054l5vf68BfDZ6uFF24U+uy2s5P6v7+OcK4zT4NQXV/H5ktKZCNIdTWwWcQ/98ABFSkIWC+b603t3vlChEYrh52UaTOLFpnsf+WOsX4ri1M7pxxcDJb0Vc5SQcL+D6TpmtaZQ0RpM56p6l30AAGlKBUYXEDn4rN3yL8eWnCdUjIjvyMakIQ0ueJh2lZG8r2qQ017ET4PQ3rN3bEfV+mibAdDFYSIttShnSZS/5k9QEs+vOl8R6XPI4sXxYEnXskwvhAKFWzOk6/R9ExseProzZ2v6c+0da4UWRM4hMkrSNIPjMEYS4CdUAI1biMPqGBMMJcjcy+tunKfo26YQXZFr8h4uSAx18tM0D15YMVyW5Kd32ka1ST3V2sxll9Z2GxALIFh6I7+YjqhCf3E2UUtMAUUfD8KkHrGcIzFYXT/04mWTJ7b04PJ4kiXBvSo+JrpUpyj5xhFHitFERKqh8la2FrqMlOua3d3vkCYzObWoEmvbtRst3bOEUbXDlg1RpLvlXpmS827VW2OTopKkdfUqLEuBVUs7nWoZgR5/n7/9oGZ4BP337nV8DRLTDRFLqQGZjJv5HA7kD4DCfKCdqqa2jAcxe7qVgnEOoa+WIpabIFTMN+Dr7j24cuNNdrwh1++DfoP8teYJJLw7DSHbFxDwwCLOfYyWHv7IsNFR5ifDvOdoIpVutQYYj0E7OzvKBtQoZHwM7jLeodZzhhLvLV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pnQVnOXUjcRggKhU5MCo/mPNgNfCIbHwDaREmopwhNcKDMUBzVuqFc2KuD?=
 =?iso-8859-1?Q?p+eUmiF3ibZSIaWXVOn+ESLKDbBzbpS1BLCoghGPFwDZf7oz1/mIY8Uutm?=
 =?iso-8859-1?Q?+7DChQRbN/sKqPx2s9V/K2/UaWOa07yYvLyrAxD8Oq4fQfLoG81EPGWjTt?=
 =?iso-8859-1?Q?OjdBa0DH+hFFlIKQHeB/XuKzWKuleJPN1PSjpkIRTfHhdBI94cyn5BamdH?=
 =?iso-8859-1?Q?ht1bJUsKKO9TCp7Q9C3Z/Q8y6N++x8PEec2lEM/RHRSA5GnXHXaxISwc2f?=
 =?iso-8859-1?Q?NZ+jakVErRPTtYTuMeZI+hfF7MvX6bDYOquYMuHVslhInrYkW1agwjPVCb?=
 =?iso-8859-1?Q?xv/eHFdKcnePMqy2x5d3PH4npzIgiK9bGb1Un2w8n43ivSxuUJhbwi1aAS?=
 =?iso-8859-1?Q?q+xNo5uJwGuqsFPgSK5i6CKd9J9FNnDFgX5NzKKfZXc310S4AzPswdWfGu?=
 =?iso-8859-1?Q?3CSn2h9ZpnBA8hMKzJXgAWzUn9b5DdYQds/GbMpSByOOwcdN0AVKKt81V+?=
 =?iso-8859-1?Q?spK8lUIDqdNI5TJ/yen+qsDVVX/lJ4JdUL/keTrcDKOf3rBQMn/EoBL+Jv?=
 =?iso-8859-1?Q?D/9rFL24Uknafl9fzJH21VjMyRN7QPu7FsjHBqwDG3McgVmBu+I1DvqqL7?=
 =?iso-8859-1?Q?2OkkXgjA+nTUrJqUisVTFzPxUuF748beXmww9iaqWvEnSOdDDvvHq54mva?=
 =?iso-8859-1?Q?DYvSW62BnFMupbOPNfcbw6LEHORsp5XX/T4kE4kiRRlTZ82p65Xb9jtP13?=
 =?iso-8859-1?Q?GtcqGVLu2M4JYrVGZdVN9g36CKvIpVTpPSiWxB1VJ80dZE5fI5PK+lMJKm?=
 =?iso-8859-1?Q?mzzbGnomLRV4wUz2+w24Rr09LRtMHcZ+PeYApwjx8ualsGeVApNnMETRvj?=
 =?iso-8859-1?Q?LZxdIAa4+waBLp5SLoI/ocZ2WLQcTK58hNA+zsCIFWeOjOok5xXudGbUbV?=
 =?iso-8859-1?Q?7r6okPBPFmgtW8lkwaTbOH6J9A1Q6KXISZwH0b01MGkhChyjsU7s4rDeRt?=
 =?iso-8859-1?Q?Nug7NxuYiACmmVKIi2YVjWa2B6YNQOjJm5MpTGMeY4uhxG/nh2+Q/yimz0?=
 =?iso-8859-1?Q?YOaVYUxH9NOVGYjDowMRcBGaR9xvCIi1pIM27HVHizQaFL9JD2T3JzuzYk?=
 =?iso-8859-1?Q?FbloaOwuemopEVjQN+VnENArhDj9YmRuDB+xSb/xZsaxXuy7wLbEdnPM0c?=
 =?iso-8859-1?Q?E7EJDSE8QmyiOanLk+QX6zxAdBfuRRo3exQ50QNicgxetS+vhdpjYuNujM?=
 =?iso-8859-1?Q?0Rq5MsYWVu9hg7HUJL002KUHXslkZXF2maxpfyHGURARWEN+30ymFVGyPb?=
 =?iso-8859-1?Q?dmFHla+KGz11ZdXO/0aYUtiVthbATid8Ll6V5W6wfu5Be+M11JMLSrXcq/?=
 =?iso-8859-1?Q?HDfbEcK2ENN4O70g4FhWyficcXgp7HLd09ycOId7dL456EqR740tLIMKs+?=
 =?iso-8859-1?Q?gVSd3m+gTu1p/1lRBGhlRWBaqzPo1PsI4nBa+htE2E/wORd3+PVmiaT/xK?=
 =?iso-8859-1?Q?ikhS0EqoVGIr17VCXFmeBkvQrhC+jRVe0OIyjjEjj7j5Mu0rwrcHmPkl9Q?=
 =?iso-8859-1?Q?HuqvSfGE0qiKYsxWwmBB+5XOwMi8LM21xmIiqur23y7xPM6YPl3W8dBlvO?=
 =?iso-8859-1?Q?W35VkUsXOVz8QgrtfDgoUCSdLal/PT9CKDB5skf/pHeIwyhBZQKIZmEXLX?=
 =?iso-8859-1?Q?4X77vejEXYgKeJV4pdajIPUCP0dXsL6CHtENtlpIW6gQytWtmh8agHnUbV?=
 =?iso-8859-1?Q?A7YBtBIgmB8gSV6yPzTsxEFR/UWdR9m+e5s4fPDH7iD7vafX04XjMWhP9C?=
 =?iso-8859-1?Q?BVPvWpEgHahcbZ6BXGBqXPR5iteceQs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hs4cKBP2lKzupCqX3z6+uACDflatQF/o3G1LlQKpGymYSlHgD2s4yullDVGJvD8j/9Qk9LuTCy8N+bhc3ePETu2vOU0gYqeCHEkU5zx5KGcxV+PQm0kW+5vLnc/Ns8E88gz1S8bnpBSUCQ3/sivH/eNZ61UL/l9cKR58I9gi8AkcUw93vtltbiUBIugoxF7ZG/47FrgTnMD7039Xj73ZgUt/y9UnlnZVoYRxou8ZbhFp7xwTEEDp3TOWuCUdF//xSdkRphIQXQHskqvGDnPEHM6wKBAh5QnjwP1EwcNPLnxULA1MyJor931OTk6LIx/KmYgJ5yJNsivSF2lFN+nNHg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5e855c-2d92-4c6e-dd9f-08debfc160d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 09:37:20.7261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nMuldjFxIYtny88ESGq0XLKb2wnFh5cl/Dea8syKHuSDiQVBDtaeGcLvRHpNYrpc3YYvyvz/pUxlBnyHJy0F9rOZCTyhA5JKBf57vkSh4+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6534
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293661-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,sipsolutions.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C616C61CB0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Jiawen Wu <jiawenwu@trustnetic.com>
> Sent: Monday, June 1, 2026 9:22 AM
> To: netdev@vger.kernel.org
> Cc: Mengyuan Lou <mengyuanlou@net-swift.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Richard Cochran <richardcochran@gmail.com>;
> Russell King <linux@armlinux.org.uk>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Simon Horman <horms@kernel.org>;
> Kees Cook <kees@kernel.org>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Ingo Molnar <mingo@kernel.org>; Joe Damato
> <joe@dama.to>; Breno Leitao <leitao@debian.org>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Uwe Kleine-K=F6nig (The Capable Hub)
> <u.kleine-koenig@baylibre.com>; Johannes Berg
> <johannes@sipsolutions.net>; Fabio Baltieri
> <fabio.baltieri@gmail.com>; Jiawen Wu <jiawenwu@trustnetic.com>
> Subject: [PATCH net-next v4 5/5] net: wangxun: implement
> pci_error_handlers ops
>=20
> Support AER driver to handle the PCIe errors.
>=20
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_err.c   | 111
> ++++++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_err.h   |   2 +
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 +
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   9 +-
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   8 +-
>  5 files changed, 127 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> index e249cea874be..ae5d14071f3d 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> @@ -4,11 +4,122 @@
>=20
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
> +#include <linux/aer.h>
>=20
>  #include "wx_type.h"
>  #include "wx_lib.h"
>  #include "wx_err.h"
>=20

...

> +
> +/**
> + * wx_io_resume - called when traffic can start flowing again.
> + * @pdev: Pointer to PCI device
> + *
> + * This callback is called when the error recovery driver tells us
> that
> + * its OK to resume normal operation.
> + */
> +static void wx_io_resume(struct pci_dev *pdev)
> +{
> +	struct wx *wx =3D pci_get_drvdata(pdev);
> +	struct net_device *netdev;
> +	int err;
> +
> +	netdev =3D wx->netdev;
> +	rtnl_lock();
> +	if (netif_running(netdev)) {
> +		err =3D netdev->netdev_ops->ndo_open(netdev);
> +		if (err) {
> +			wx_err(wx, "Failed to open netdev after
> reset\n");
If you jump over the netif_device_attach(netdev);=20
I'm afraid the interface probably will be UP (IFF_UP set, because netif_run=
ning() returned true)
but permanently "detached" - the kernel's watchdog, TX queue wakeups,
and carrier-change notifications all check netif_device_present() and=20
will silently no-op.

> +			goto out;
> +		}
> +	}
> +	netif_device_attach(netdev);
> +out:
> +	rtnl_unlock();
> +}
> +
> +const struct pci_error_handlers wx_err_handler =3D {
> +	.error_detected =3D wx_io_error_detected,
> +	.slot_reset =3D wx_io_slot_reset,
> +	.resume =3D wx_io_resume,
> +};
> +EXPORT_SYMBOL(wx_err_handler);
> +
>  static void wx_pf_reset_subtask(struct wx *wx)
>  {
>  	if (!test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.h
> b/drivers/net/ethernet/wangxun/libwx/wx_err.h
> index a529bf54eeac..de5d02316230 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_err.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.h
> @@ -7,6 +7,8 @@
>  #ifndef _WX_ERR_H_
>  #define _WX_ERR_H_
>=20

...

>  };
>=20
>  module_pci_driver(txgbe_driver);
> --
> 2.51.0


