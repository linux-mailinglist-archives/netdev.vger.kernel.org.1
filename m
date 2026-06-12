Return-Path: <netdev+bounces-298543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3zdNOUfNK2pFFQQAu9opvQ
	(envelope-from <netdev+bounces-298543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:11:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F27FD6781F9
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:11:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=VgQTWg+p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298543-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298543-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57255300869E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D44349CC2;
	Fri, 12 Jun 2026 09:11:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B2E3939C9
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:11:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255488; cv=fail; b=szIvzvi7SQLcjZAVfUJhY0xKGIhnxgJuasnz2b5fHCE4MOlhna9w6x3Yq3k8Q7wZN2yVayDo4qoa075M4tAeoroQsSABcOhEBbWk5ibtM+eoV8e4PgQQAUClG1LehFZ2stFE8qWLv7v6tJ7xyBa0erUU9DpTwRBs2/0INrgIWSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255488; c=relaxed/simple;
	bh=anRKqH2NrzEWri+DVLWTTdB48HaLh08sOMfDOGI324A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ISCrf4lEL1o0IreEIatA5cBULZ5SOslwYKn7wYPYN7MuRm6focsndys7CN7jDcySOW5LwIKbDpqf5+I8qc0T2AHV+OSQ5roc/9jKLrryoBXPQFHGrL3fHmTwmbY+OPy3fKQ9BkU05ixzT0mr/6qAJq9w2sbFpjxdRDVVMHtvNqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgQTWg+p; arc=fail smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781255485; x=1812791485;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=anRKqH2NrzEWri+DVLWTTdB48HaLh08sOMfDOGI324A=;
  b=VgQTWg+pK+SOCWt9N/TNbtqVH+ka0lt4Votoy5Y0zXslvAX+WYdMYrgf
   o+qQuAuYGXPpQtZKBpad8mAwYiLhR4KcDx0JK++IfxlnrtKYNwrJPzQ8E
   RWJlohFuXMNTD9gWJI1lcO0VM1+zUHOUtNsaS/m/gI0moz1KIYL+Xlydi
   5ri926UVVHDrImGhIQEJsfbxiIV8pV2z2WBbY6Cya5T1zIq1dR7xIxYBe
   Wx0Tt1e29ZnW2PWaPc7YPU5ojeYcprZVji72tYN2CocqRr9sNz8/6x73w
   zLje4goqjt+KaiY5PnO5y821aZLKXO675V6+cj5x7akSvycxFrlthZb2K
   Q==;
X-CSE-ConnectionGUID: V8ffvDQTQxeLMmPsh+3PPA==
X-CSE-MsgGUID: tjp3tkeQSBmEMZrRELXsHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81218472"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81218472"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:11:24 -0700
X-CSE-ConnectionGUID: rYOZR1asTbmzNrm0h+ox1A==
X-CSE-MsgGUID: 6Dk9hvxhR3u4t75AO1JoKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="251717285"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:11:23 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 02:11:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 02:11:23 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 02:11:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnGh703tzVqEF04e8xbDKlFJ7ZjZuix/2MHDQlNKr022KcsbG2UWkZVxDTaeX+d2QK9G4zn8YHzqkvG5cDqdM6xWdeFF+LExDnyKmHdYMAyHezpc4GiNsHw/IS6smvv0raEM5UuzPfPdAX96sQQY+Dw7XiYM6LbXGdvPl1JfuokBBZp44K6UAouLs+33gYuzZQdK4hi9EIxfKVQ8MxT9KN1FVONebikbfLOjvDj61swEHMIVMx06sLon4K0+Djv4K1OaP5JtPS9Y3S4xd3024ynNwfYGFLEMzLNPkjk41W/oemocu1wWd+xWzGECaQrINLcLtAW7uPuIeNicJh1ffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIURXjwWthUrYRRMTMaQCXNq3MQHTbSYN1XdJr3WyHA=;
 b=EZP/GouJu+jbxvinthClTcqc43MeQy0/ASNAbWTzhMXuaF0c2PMsf4bvH3seWRM62VWDEpTHJI+J18adDzwHUWg54iBh8xDzab6bwVqu1x7DfWogl1q3sjMcvezhcMOYtzZt6RYSe9APu4XBwq79NRaUxZnhRdDod0OTfykvvK+byHCmqJQGKWq0Qg/tBALV883WgsaxiosSr7UPHCoztfQ0lDF5RK7e0z96nThAeTC8HDKK+1Q1BLja5WZotWcEHpG+6aWEVd5PqxxOff8iNe+YyQmHrR/bkHAiUP8v4bhlpx1a+LTayMMNwBgR+OEcUXdwfiroLMn7gtMqzFX+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by IA1PR11MB6539.namprd11.prod.outlook.com (2603:10b6:208:3a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 09:11:15 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 09:11:15 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Lei Zhu <zhulei_szu@163.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next] ixgbevf: use vmalloc_array() replace vmalloc()
Thread-Topic: [PATCH net-next] ixgbevf: use vmalloc_array() replace vmalloc()
Thread-Index: AQHc+jl0j8KUVRiFsUC4yeUonYovfLY6oWoA
Date: Fri, 12 Jun 2026 09:11:15 +0000
Message-ID: <PH0PR11MB5902A4F00E337C8A643B49C7F0182@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260612065809.164623-1-zhulei_szu@163.com>
In-Reply-To: <20260612065809.164623-1-zhulei_szu@163.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|IA1PR11MB6539:EE_
x-ms-office365-filtering-correlation-id: dbd07120-8c99-43e9-df69-08dec8628e86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: zvu9k/z//VMTailnviWGtw614YsA6Q1JYcYo6L2DoRa0PIKolQ8BdAR8oqizznI+/M/Wd3o4yz+AnOYa2ogJTXNxDS3SsKAm51ElxRJ1tKV9QpXj0RQvCEk4lsHniuxVggnBLgTHEgzdxQuZDd6RQQuiZayJ8vrUs7c9OV4dA1KyZ3Y2l9x5sH9m3Qwbf70oR2bRvWnUr89fTt9fRBoSLvg4rN38fjVpMduWgpYxiQuidO5NYtBIxZBGovjTrSdxKET7xXVID0tTtyMqtFIQmraKUXzOuPtPkTEjFtKrQT1Q6doNT773ehapMkrB8spjUDBCIBeffk2Z7DCGksJUtoE1ZqFcchDqlgq/xeJpP+nW6C80FtnPKR+QGdTDvr1NGXTySa/zBh0uqGP3GWBAX5Zj4HHspz2Dy6isVK2lhEmzyB1wbpjQ/GsGsDOeouk0LRi33UBQ5+aF2Mklc1TT9jPKFTruN9qXU/QFMhgaVvciMn6NdzlqfCnlzRm/uMafblHyF9dGkqIp5EpmTw1MpQLvED2zuyM1tquWM8t8cHbT0qOErmuY49EwhsoG7KoDFXfLu30CyXueFp/f+NNFbWApXP5mMQ4xaTy161c5C902mXJ7TIXr6GFYTtNRhsbXw1Ch4f7a0m89JSR01FDoSpDru3wSPLygn72w2OHibbbU2yY4fIX7kovjmwV73XsLZoTI2ATzqwBXM6hSFnvszJ80L0MltnpKZOXZFnmXIsl16+d78w/9X8cwpAj/tTZO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?psulkXKa7S8axMAEj2MeGI1i+5SdjDP+jI7M3LilDdDKpzT81IsTPgUKCv4c?=
 =?us-ascii?Q?xrb52H8a8SfDBS4beMNjxkNZbtqKCEF+OatqnmKYmPAjhXtbdVf+p7lRX2zO?=
 =?us-ascii?Q?MaojfbIhjMF/v4BzRCd6vrHQ4FC1lObI02m5OsbdzAqYAW3jUgPcvvYgoWtU?=
 =?us-ascii?Q?gXk+fDl5SDOMnb4MwQdDHUEcMktkb34sdPSZ34e+vfecVLcYN598z9cjgd7/?=
 =?us-ascii?Q?SrtI53eDUwnBuuWBiNoOKllJdWKc/IzfpIJhvop/iMOBMjbqoAf/evfaZ/ki?=
 =?us-ascii?Q?WsjIaipGmjwATeXi6USAnIQF3fvYnQB6wVPRkWNGAnMS1THcHXdftA+ylq7U?=
 =?us-ascii?Q?2F1afVW0JZlEWwKfNW6BDGz7m8A5Kr7jY/8u0Ud5FhZmLu0Bdk4SFzbLHp1w?=
 =?us-ascii?Q?XVVLwAvtaH/wmibySQLRmNYW3YpJLZqVqY6F097yOWF6T2VbymFJ0S8zbm1A?=
 =?us-ascii?Q?zMr9KbwCne7rxh5YrVcvBTRBpfQIWog490MXkdxo8GfNn+2bun/0+TQYT43C?=
 =?us-ascii?Q?ABGBupReZuGG4BM39Stv1cvpjGABfZCssxThaoKR1hJVV3XI1lnKIpQkJ949?=
 =?us-ascii?Q?CxB373RG42YDlKZ2nrssuZKuqnDzBeSueD78U2OT4KhH+OpWe1n3ToJy1Isy?=
 =?us-ascii?Q?1AxeaOlyCDY5BISgJ7nyw/F4TD6VtEVPeSl/gq8dHWzvQbr4Gt5tqrSFmqm2?=
 =?us-ascii?Q?UB4ggska4NKur5ZKqNHA2BKOJiV5zW1hqk39YcPKO/6xW9g/zIninzteUAD3?=
 =?us-ascii?Q?rkmp4uCQ7v6PhANTSle+u2rmUdv6Iz5MQbIqx7VndwVllYT8+67I+q4akM9+?=
 =?us-ascii?Q?BNQzkbgbRIKyfl2CZN/3XxIapH6YY0fdF0E7mxvMQyXYVzaH8RQ+wqihyFbH?=
 =?us-ascii?Q?pjkw7G7gV9kH2HXGfTKJGWAhqtqCMW596icvvZ9sXa0keJ9NXMqe6f6UXfo0?=
 =?us-ascii?Q?oieHUDoKn2laQQ/qot5XmZUgMvKUm/GThpTgcDxvS1c2DdHYwVR1xUN84s1t?=
 =?us-ascii?Q?M7wIojRIv5NL3wt7rOIvleEkwQtAsbgWTGSOr9yzqkNdBiAAXaOJRxoaWluD?=
 =?us-ascii?Q?P88bakuRqULGfu2lLlPx0BggjKJfMnivVL44lgdoLcE7UcWUZ33NvMKZtiJp?=
 =?us-ascii?Q?Z8Luk8ILsRuDLJ1YWJWNjGydXn8rWMevpLtyWg67ZvDVDnVoRfeh6m9zapmv?=
 =?us-ascii?Q?V5/cG+C74H3AKXNqRc5Wf8P3BMfS5p+iGQoudHZhGkw2vKjRN2IbsmhB2Cwm?=
 =?us-ascii?Q?6NOyC9glRyVGuYD4di2105BWEyB3oYURHpIxom+tbZzzE2FKOjRvBpQjnh4N?=
 =?us-ascii?Q?2NJ4dxSfbAV1vEJRTaG1Ka3IqJ2xN/HzjS5wU/7CjN23IpCsz4opOgNE17hd?=
 =?us-ascii?Q?z6uLyGHVLoykBxquCFXEpdEy/kcIafWoP1nfglsUt8jdN2D6uFqf9LbGVVf5?=
 =?us-ascii?Q?2/zHP7brOV9A7k+lDdvQ/QgAjjOk4akEOri/GSpYOCYdvk046Sk2uIVplam3?=
 =?us-ascii?Q?/j7VrxS5NO5tXOeU+QrDlFFyFrYgt5pBI3i+Ys0BdjJ8agPl76lpOkj2o7Ec?=
 =?us-ascii?Q?2Jpi2vORECkSpbWEFewJIk9Skfmv7PGxQK1gV5BRceTB61gAVT3FeI+0Zb+B?=
 =?us-ascii?Q?IPcYQ0MzFghpX6nw4gPMqLiEK+ZaJFLRnTEti6fNArZr6fe32QmCldskL4KV?=
 =?us-ascii?Q?yxMDVyohsvNlt3V2Z0GRbfGcfuSHTTwA8lrLNi33jWmJQc+9lBPlSzv9Cwf/?=
 =?us-ascii?Q?MONNdvWtUQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: A4fAEGqXQ0WXeB9TSy9oN2TZb33P1TG5dhAJtkEGvoIdzneTTPDseq0G87OwnM1oUFty0yx635oIm+8o980V4FExf7M3efhPE5CQ6r0A54zDMkwsrmk4swbzMfqN9BOvoBdxTqc6OKPOVJTI9wlw7Zx3v4nm9LcQJe9geakggto9CR9LPf/OxbnJyKlqbY4e5mjPjpDxQApLjdDQIwdzmoqC4rHvG+wplN1OsSaI3rk5YYbUx4m6dKzdNhFIh9TaX10Z9dUr9YGFpOpiObgOwLGwlFMIswCo3jkIVWKxrDtAtj0NTU6n0qZqFPg4JGfuyzWHqTR8RF0KIYQpqxCfrA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd07120-8c99-43e9-df69-08dec8628e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 09:11:15.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETucHHcDzYtDW11Q4kZABnNWjwzr9WJSkwrgqOXUTgm0dvBYli9AwtXxz9i7LM1HkN7sihTDEJde3AvHXbJm+shALUeZJLLonqBadEUNuDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6539
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298543-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhulei_szu@163.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com,intel.com,lunn.ch,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F27FD6781F9

From: Lei Zhu <zhulei_szu@163.com>=20
Sent: Friday, June 12, 2026 8:58 AM

>From: Lei Zhu <zhulei@kylinos.cn>
>
>Replace vmalloc() with the equivalent and more readable
>vmallc_array(). This change has no functional impact.

Hi,

If there's no functional impact what we want to achieve
through this patch? What's the point of touching
the code which works for ages in that case?

>
>Signed-off-by: Lei Zhu <zhulei@kylinos.cn>
>---
> drivers/net/ethernet/intel/ixgbevf/ethtool.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/et=
hernet/intel/ixgbevf/ethtool.c
>index 537a60d5276f..72bdac8c0075 100644
>--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
>+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
>@@ -322,8 +322,9 @@ static int ixgbevf_set_ringparam(struct net_device *ne=
tdev,
> 	}
>=20
> 	if (new_rx_count !=3D adapter->rx_ring_count) {
>-		rx_ring =3D vmalloc(array_size(sizeof(*rx_ring),
>-					     adapter->num_rx_queues));
>+		rx_ring =3D vmalloc_array(adapter->num_rx_queues,
>+					sizeof(*rx_ring));
>+
> 		if (!rx_ring) {
> 			err =3D -ENOMEM;
> 			goto clear_reset;
>--=20
>2.25.1



