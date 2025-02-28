Return-Path: <netdev+bounces-170599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5708A4932A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 09:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73AC87A2B15
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 08:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7BB241CA9;
	Fri, 28 Feb 2025 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YarTbfiE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CE7241C8C
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730673; cv=fail; b=bwf9tnITzsHljTpLLBUwEd9Y+1jcpIg+CxTxmGmSOntSJM0TFxr4Dx/Ewn4AFYLF7TPCaFXueqlsRbTjHjFT2vXNUyF85A3DSeCAZbbuWgL+zyymYFGbM3HFVhFJ0InlMf2//3uDEVbF2tATZoS4C0YSqx2esOPnyHn5ZDUCU40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730673; c=relaxed/simple;
	bh=KG2SjBNS8lZi6dcIXbe/cLrsM2/VQH1xREk7qG8RtXE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OKhQRcD6gWDmZ71Yg7nr59HiijYax+gY+hc8rkK/mt4dzYuD/SmfJG+DnRW38NJfX8Oa4JymH9vMgfMXe1lgxiSz0I6Pb/UOH0yzKj8a+CF/Dppi9noAxg7pZX2t4mufRE7cCA7x1RRSXXgVWjTT7Tvga14IwgVTHgny4e5KvtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YarTbfiE; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740730671; x=1772266671;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KG2SjBNS8lZi6dcIXbe/cLrsM2/VQH1xREk7qG8RtXE=;
  b=YarTbfiEvpvJjRO4xP80TWToyDL5n4zN8Pu+T/r6RFmz4gY0q3Zoec1T
   PChYfvSCKmLE9I18b/3rwAsNokpkEOjp+pVYSGRebNgThNpbvpA9zTniL
   zju7i/pXVUeFwt2xatCkjkRNPWF6K1TUFjFldUTbZaL1skQ8vF+1gAz2K
   zL1vBgYj2czr4Zfj4h4MI8lniRJWp9+kPaAbohQ/ykHtxzy2si9eJKJcl
   OTAezmbk3F1r9QDh7dptHMhTCTeEmT77hViIc6C8A4Djr2fkFd5WaPPTl
   2HsQSXdMl5JL8PXB/y3r5fWNgrHpUTVa0l1oD2X5u3iFiBCXgUCmwRMF5
   g==;
X-CSE-ConnectionGUID: FxEgZHJRQUWqRvisMhIVdw==
X-CSE-MsgGUID: D9gBbZ3/QFCXeut+gp2yJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52295612"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="52295612"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 00:17:50 -0800
X-CSE-ConnectionGUID: 2FjETLsLR/Cuvsqn3at3Hw==
X-CSE-MsgGUID: 8cGXHQJmSTepxfsWCpYrfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="122285904"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 00:17:51 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 00:17:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 00:17:49 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 00:17:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJCK/nDa2CrFNYoAhDq32uVT+npgFCGdtNlk0u+2XwoXZ6JaWFPdAtOd1B5biDUBU0q+khTiBdSuy+toxfC/lyLuyvhoQfJiybDdVebrBFphgEWEJ694OzvjJ0ZSTFIKopa9ZhxmoXkqQRUNal5hJZIJ14wWwEfFLok8YXQ7J4R2q8k7IExh9kmhpmclrBK/dFnDC0No3B4FaAnuE1RJoyA1n5rLe2kXVMlGpJ/h0Num+Oes5mc9ejIaJM4deesazkoo6hRKybZqK44/GbpOhaN27gAUH/eI3VdqXtSgDP8tzEyL3xPBMC9Gs+sqWLrliU3+FuI6t2VyDp7nvAmEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htL2Mv6JMH2t5Zf6tN6ktEF+JgsOZcyPw4ndBKyq05Q=;
 b=rEWyKrmjjuFolPBg0cJJIVf0ycT9Z9/vp4r1rC3AwLH4082D1Fj7Y1QnHWO6ByBGCxnXU9Y5xBcGq55Qn9MrAjxpO4e3Vmq4EwqSnMHpADIJkB7e5wVI614PAqPD3LGmN7boJtYsQnJ8rz17YTOAzeD8y7f2czZ/MvigUFXILDBVD1KXNimZpUjcUGPN8Mib9eSyRGOGmZnTiQguvC/ADNf+NVcxmkGIZpRVo0mlccV9AhrYViG/FBXS4FwJ5ohZTjKgHxgVx4M/66N2CsLHgSJQ9lgH/VGR4bD/bivH4CLqvxZeviF7gLK11M72so8d3sjXEZWHbcFlYZu2licmeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 08:17:48 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 08:17:48 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: Fix switchdev slow-path in
 LAG
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: Fix switchdev slow-path
 in LAG
Thread-Index: AQHbXUkpqrY+BZuBp0GpUp8gdKyMl7Nct8LA
Date: Fri, 28 Feb 2025 08:17:47 +0000
Message-ID: <PH0PR11MB501334B966F8F96EDE9040C696CC2@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20250102190751.7691-2-marcin.szycik@linux.intel.com>
In-Reply-To: <20250102190751.7691-2-marcin.szycik@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|MW3PR11MB4523:EE_
x-ms-office365-filtering-correlation-id: 0a882f93-2e35-4267-37f0-08dd57d062ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?bEQ7h7rN688zsplP//XrDUQ7TFklwDcaS6E0n0GEEl35SQdnSzfLPDFNdE9B?=
 =?us-ascii?Q?acFEqRfD66A07SqjSDlGAJvt3Q2oJ7VlZT6REy5ZpcavDTNT09Ty2caCUxbR?=
 =?us-ascii?Q?ptTHucc4EkBWJ2f56HaE28tf1rvpN9lD3SdL7tQDclM404yaOCpbCpIho7Qh?=
 =?us-ascii?Q?v5TkK2LGI3hphxg9tH7G0aAKEg3YG5VgqJurObiODhNPBuUkDrvUo1qtVyAz?=
 =?us-ascii?Q?nsvkL+nYn/h08Q1Vf3T/G3lx0E2S5pZEAo5sdmkPj/wXgnJMtGGRaJxQQCUB?=
 =?us-ascii?Q?I7XD+pgo+xhUDtwr1nUc2ZgtOVtxuZ1Edbehc70XbOQDiv3ZI4Mvv3LoCk48?=
 =?us-ascii?Q?9hIAvLchmzY6CxeRheE6RisjhM/3jX22cFelHPqeKbCad5n54LVa8YnrmCke?=
 =?us-ascii?Q?nxsABxa7QX6qZOV22JzW7mP9ehakiDH6lL8D+LkuZw2yqkOuKg2XmRwlmRhI?=
 =?us-ascii?Q?9OK5Luhi+sBPkWd2FTi/Tkhwge0l0Ykx6jXTD431vAkEZtBBiexc116rMfiM?=
 =?us-ascii?Q?GOPfN14feu/zIHKOa75MYVGO7npGvUJcdJvXn7b+adeQZvgRgUGsuZl1L8S6?=
 =?us-ascii?Q?gAfbVxpzNqnGf3UMcou1qR0x9GvOYM5ZmDDK1E52/Xe8TD0Hu8EABUJqtoMF?=
 =?us-ascii?Q?L86B56PBzVGttSOB6znW1qBJy5OzCzg4guEHcZzevunMmEuFj2I0YhsngPBV?=
 =?us-ascii?Q?Ub2jek9ml3QVwMReKK+8hYtxUu3WfZ3lcBeS8JfDtANrHnbQp1xreXL1aA44?=
 =?us-ascii?Q?WBoOPm93JnyvWweZ8Sb6HbsuxxX0PCPGl8hKe/S4MOh1AurLnOiH6QI3+ciH?=
 =?us-ascii?Q?ifGy8MvocG05Bh72eBp2Qa2yZbSn+KhCRR2hxXvx2IS9B09F7VQqLtzxmrVP?=
 =?us-ascii?Q?y58S1EdQzXa7374eHT7Boom9j2XX3xMy4RIMQMdVzDoGslDc/XaYz0rlytCs?=
 =?us-ascii?Q?S+Y4ibuibbUv4ewqD1YlN2VASp6NNXOEUgrd68FiDuSHaPIGkS+hQDR+N+hh?=
 =?us-ascii?Q?q5caV/JHgunlmM++8RkzXxUchvvX2eEm18dreX/CWRx24FuP2/Du9Yo5k1Rw?=
 =?us-ascii?Q?j2Ref0/XPeUqwqP6qP/yzw3Mw6ZsuS4YNkfxgF8uMKxYRobkWXilYHH2hP8x?=
 =?us-ascii?Q?97NphQFvMI6eEdrnD4fYzKEOpat6i+pIQJKFspxmR6wuUD27FzJ9V2OMjcrD?=
 =?us-ascii?Q?KvZc8iggmmPFIcZTUd+us7Od3MCbarvo4vWNMXTbZ5VkPLSaXBx/KEygT1lW?=
 =?us-ascii?Q?1wlXeP6a1WL0657+Pko6+lq0wEz5dPEx6/9iYdZbjOS0UgHZs7hFgRFsvoJN?=
 =?us-ascii?Q?nlhPshWyu44XeFHvulIdrv7gIaqoGiFhpHst08/bWYbMg0qLT8yCIuoA9c20?=
 =?us-ascii?Q?we7P/bQOsWe3+YQ0B+vX/RWTumhgUw4K12nfFrrtrFvYjYq4LNp1Iwn7UQ21?=
 =?us-ascii?Q?MlvDRnUvxGXkUBzgdocyLaSw25XgwxDo?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0NYBZ4WS++eEMKGWeEGBI5Y5qowVoEtrvlFrgEhOUIxPDZ9qdV5On52GbFc1?=
 =?us-ascii?Q?QFyQD2Kiu3jDRSQg9aXWa0KAtJCt+0wdRoK/LveMo+dWFt02TWwzlbKPmzh6?=
 =?us-ascii?Q?3ofnDYnALdeepAYty276lJ34Am3Mm4syb1L/s9eYl1uNCL/4cF6bYnMK+j16?=
 =?us-ascii?Q?fp0Kt42LdD1HvZHcvqCrD3vwYlFtV11GEQkUNadOOYXj279pIhevy2mtqey8?=
 =?us-ascii?Q?y8+FgOyPstv9D3DSz2wtMZxNSNOHSomYGF+sxZEHWY0M5AJwkdBIvJgcsPV9?=
 =?us-ascii?Q?WnXOWKVwoKH3nbw2VLbXWOTui2ppX4xtMicG5+XKQ+1mE4KOZ9A362HSSvHS?=
 =?us-ascii?Q?78el+yY3yTdHb6L7qbfgwddp+DT/1ezf5JnRgmkHyxWSD9oYOZk3uS8lGdLX?=
 =?us-ascii?Q?lGhPbP5Sz5ezWei6y41QzlEX0rqtW/JvKIMo0VgZNqMXpCimD2/evwaXfRGU?=
 =?us-ascii?Q?UHj14CxHVOw5YYxH5Sf/txpF0IuJE1bmL/3iCvbmYiVpNeIH/rttGAn2/JEL?=
 =?us-ascii?Q?13vWe7/YufBs6hL04MLZb8vgyvg8WcaA2o8nAccjjfOpD6vw7NRK5Tfg2dX7?=
 =?us-ascii?Q?ksS1D+j5ZUyJZ84RXRmtyw0kj5wscRK+5I3SCdPGTCxJURAdciG1D4zmSYpu?=
 =?us-ascii?Q?0SDM8bynYaOLbDoi7bNT0iaowy03cE7f7BOEFvk8JnLWaFVE7MOsJWUisB3q?=
 =?us-ascii?Q?mLbEuGp/Gx5MN+3haLCU+UjW1F4cSDWr8h0d7o67urg40uQ01xcnFcg4vBqr?=
 =?us-ascii?Q?Ux6W0bRqGh6rQSS8QIC0d/QV7BLSFL8nA2BSv17FLwkmm3c4K3dGFjiDaugp?=
 =?us-ascii?Q?jWIEoBMmeMAbQTsilgd7argL0/niZo9ZeVwZGUsyPCXZgmP7jlKMgnZ1doQ4?=
 =?us-ascii?Q?AVCC0uaTDnxXbzAGqJnPrby2nQthaqYgymCUrQU0vvKGOslfhWMEMLobw4LH?=
 =?us-ascii?Q?E1myKit2N6RFo7FYcOUKg/+537GQxxsN8+Lr+ZrdyRUKptjPavb2Lq7+KChD?=
 =?us-ascii?Q?Vo+gD62OAcZHQR/ZvHp03VBAg8xe1eCUfbcnin0owhTfYyMtkE1yNZLPYPph?=
 =?us-ascii?Q?J9cOJsRJftgTGDGUgmiJ5Z3xvGhtD9P212dUbFV3/cFrt6cNfDOHgNYh/XRp?=
 =?us-ascii?Q?1p1JrkwwVTDDxvhBKrlA0WTJyg9Fmh5BmsvU0109ZrI4AlJcjEjVkUDtBq5O?=
 =?us-ascii?Q?9w7JHsv30NFCoFqfGqDN0vOSyEVxtjswG2qhIl+F4Kkuk3XhjK7au5xnJT7O?=
 =?us-ascii?Q?X7a/WaBSxygxgV2ftWioLDjOpTC5GxtAY6wgbA2x6n/CweBtWztxzQs6O/V7?=
 =?us-ascii?Q?CVQwPSEll4bnuihGQ+Ps+4NcqIiiUpmdCbmenpq0F5EKvMV7ttK93z4Bfm6M?=
 =?us-ascii?Q?vVGcV/tVA89GKEMB2aoGxCOl7XkN9uCkyesswvyA3LT9Xrl4AB2pbt3TTTu1?=
 =?us-ascii?Q?NurFWijNHZyNYmUgkPIZUJAc+sWdx9tGwh5TyL/jZn/HzZrtdDBc/Gy4PNsi?=
 =?us-ascii?Q?XFZifmL59C/1kB1IeeSWtd+e86H+epKMmhRuEfu0Z3g8oacfYhOtS2fyERQ6?=
 =?us-ascii?Q?AVbePZB7/V60OPwhfJvEItsr2nQhKJe40ovEE0zuc5OmlneE8K0mFy2xtqnk?=
 =?us-ascii?Q?vA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a882f93-2e35-4267-37f0-08dd57d062ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 08:17:48.0475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XlDqPWFoBf41Uh8Xp2O6yaTjPRX6esttqtf65pR4NGvThXEpFYstVPfXWyOl2Wx/7urP72UzRPVTSPFdhTsSs95lrxsdYmdRYXjTfDX60YY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4523
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Marcin Szycik
> Sent: Friday, January 3, 2025 12:38 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Marcin Szycik <marcin.szycik@linux.intel.com>=
;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: Fix switchdev slow-path i=
n LAG
>=20
> Ever since removing switchdev control VSI and using PF for port represent=
or
> Tx/Rx, switchdev slow-path has been working improperly after failover in =
SR-
> IOV LAG. LAG assumes that the first uplink to be added to the aggregate w=
ill
> own VFs and have switchdev configured. After failing-over to the other
> uplink, representors are still configured to Tx through the uplink they a=
re set
> up on, which fails because that uplink is now down.
>=20
> On failover, update all PRs on primary uplink to use the currently active
> uplink for Tx. Call netif_keep_dst(), as the secondary uplink might not b=
e in
> switchdev mode. Also make sure to call
> ice_eswitch_set_target_vsi() if uplink is in LAG.
>=20
> On the Rx path, representors are already working properly, because defaul=
t
> Tx from VFs is set to PF owning the eswitch. After failover the same PF i=
s
> receiving traffic from VFs, even though link is down.
>=20
> Fixes: defd52455aee ("ice: do Tx through PF netdev in slow-path")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c  | 27 +++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_txrx.c |  4 +++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

