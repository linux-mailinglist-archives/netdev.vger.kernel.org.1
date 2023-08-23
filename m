Return-Path: <netdev+bounces-30161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9190578640F
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 01:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBC51C20D5B
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 23:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4312C200D5;
	Wed, 23 Aug 2023 23:46:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5481F17F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:46:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D3F10E0;
	Wed, 23 Aug 2023 16:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692834393; x=1724370393;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4sSx2QPSggkQ6ureHbGSjzmT/k+a4KEv0+Jz8kY/CVM=;
  b=k0pv3PDm7JUsxNbfN5S70/tRR1/WVmku8GwsCcepyUezTwyYcIyiJQdb
   UkTwfVrdNZVJSKS80myIsBe8oo6eQ4sSpuw+b94pxVdA/xMmlrEtbQmYV
   qImcEywk5ZepQJ1r7vHN8wLZIG3gRbPOp8vIyook4bQJ6i29XGUMkKZGQ
   aC+X6v4yBteAht5tvXLTxxt9ChuG3G1kUB1QZkELXCvHseo7B6UZzyw92
   YVyvjq8IbwtMotqV2dsLT9e9rBMFXRrEsFce7Eaw2s4IFlWhpF9S7BRG7
   VhAG10ZY58Ykx6VEPc9YuXp6MALnO26SXTJgi4c4uH3qpBWkD1ufNe1Uc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="374275379"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="374275379"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 16:46:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="766316095"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="766316095"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 23 Aug 2023 16:46:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 16:46:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 16:46:04 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 16:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTZSC9lyNXSg7uNHjf1Xpdz2ACTJKq+WTBdcumGHGFEM1N8s9leYa2yxoT1T7N5myI9BMan6E0pfq8nRZ5WvB8WE1Qk77UJRcWvF8JrudCjDorDvtfiJMnKSbsmORWI8z1cI5YyaSFGsSrtoEovOYnDGUPoU1tJxv8b9Rn/wEIKRHMh4SrsK7xa7D60cKNHBe6/UDDh4bT9rXuuHuxLKnrVXGcP0IOtbM3nlfDkX2x1VaP2FSjuWCJ+G1aJ9UP1XN7/3HzLAJuTDSJvoZ/ndCNult/L2fsvKHz2U+QmdwZeQXP8aDReNwQN6z6F4Kv6a+egCEywq0n9cIMS76wH9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sj7jqL7tklBRkT/2Aa1/1jjNwD7pfrscj2AlcRfGhHk=;
 b=hJtfoJqCvjq+GqApUGnZnfjDP0arL9f07uC1qtl5PTQZeMjxkC+K46kipmSON5Vq9u4SUc5gNEn6bOhSpgTDvkLnAWjey73E8ATAJFYupTfAWJXqBoVFLy1v6BVnKxPPLBVPQ0yFHskR0tM5wdaQOeuDbhvzJJf6M4pMpkv89BsBhD3OOmyT0MzY4ZbVNTdTU+tXhPy42BC99I/QhDEvWQ9PjF+i7rBLh7wDOMAaeu7h0IBHgk+pClTbkSwrCatYZgrpp/YqVXZm9zuI11FvllJoeMRb82/c/Yip9lknP4gByaGyc9PYPBjgNRe+7+Lt510RLoFZzj9sSqm+uLQ38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 23:46:01 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 23:46:01 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
CC: Jiri Pirko <jiri@resnulli.us>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH net-next v5 2/9] dpll: spec: Add Netlink spec in YAML
Thread-Topic: [PATCH net-next v5 2/9] dpll: spec: Add Netlink spec in YAML
Thread-Index: AQHZ1UyObJCb8WHuyEqSNP91XS9AT6/3JmsAgAFmjnA=
Date: Wed, 23 Aug 2023 23:46:01 +0000
Message-ID: <DM6PR11MB465745087EE52C193BA3C0D59B1CA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230822230037.809114-1-vadim.fedorenko@linux.dev>
	<20230822230037.809114-3-vadim.fedorenko@linux.dev>
 <20230822192122.00f40f0b@kernel.org>
In-Reply-To: <20230822192122.00f40f0b@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|PH7PR11MB5941:EE_
x-ms-office365-filtering-correlation-id: b15c2b79-98bb-49af-c328-08dba4331b8d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t7LwjT8eWpSFMIhhGQ2zi29H58RLBO8Wih8p192fV3aiRekKdbFIXAYVSshOXaQ5GUxje7JAMRkrsQI8wv5Qbh3Fo6zoxQ/xp6KsjNt3KZBwbuHGWGRsnCo4yhGcU3QGArOoLTlIz1GNRPSSeJwLGKdvTM3AHUOv7q9hVHgeY/eXAql25wza+LwPYYbIwO/UAdPeE212I/9tvJFyTmnxLOuFO/2kfebE+nfv3sfFJdS2QB5wX7nOpGiTUz/1RDgpwqgGDd5pC3NUHALgVTMVWtdWbDlBwc+/lepsCREJivRQN+5wCY/UltgxlJw3dzCtxqRSRdqOXQpFsZswsksATglXDEDBEmYG6gWBltx/+2u0a71djY4Jz+KFJ0xNpoHdl1VlurUMAWy1b8dNmKtO8WoVNsTzgZ1oBE7lr61SCzGhDIVichgHFUAuaG+6XKOpxV5NAX2/FD0FCOnh5L/zRd+m+1Jg2yXHIII+YlJafQLP/DbLf6r42aviFweJY3DWOL386YdA+05HZYjVdwgtbO0gbD6K5O+TpTUBaTHEHCvgm09coFZXghq5PWdnzqZgcK18byQbce4SoGd1zfHi5ZlTWyQKYwpvs89xbA2wrssZsexs0R+LE0KlPgG9gyxq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199024)(1800799009)(186009)(2906002)(4744005)(7416002)(6506007)(7696005)(38100700002)(5660300002)(52536014)(26005)(33656002)(38070700005)(86362001)(8676002)(8936002)(82960400001)(4326008)(9686003)(316002)(66476007)(64756008)(54906003)(66446008)(66556008)(76116006)(66946007)(110136005)(478600001)(122000001)(55016003)(71200400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cs7ZEZU9XM9+jjERq2dXjg81A2G+l4Nr6MLVdyR6720nhDS8PpcC2f/7bxtK?=
 =?us-ascii?Q?nSs7/0K5PpkwDwPFNjfKtwSKt74nwT5x5dTBt5Cr/Lyk5HbuwJibqHQCIMrQ?=
 =?us-ascii?Q?ESMJKXK1nIT+Ia3OekeCO+vSIOEq+8KJO2O7KzPfaWpf0fVdGl2Q0fj6D4+J?=
 =?us-ascii?Q?ozsfF1wH9jQTJIpHT8SZ6VbmIdiwK2p5h8OIIghkXUzPXw8ys0LZ8vwGN8AY?=
 =?us-ascii?Q?ZhCooFJ8eVW2w7n8pJVWDsLdaRwj35XuzmdojvYO/f5VAhnd8jqMTnwM+Wed?=
 =?us-ascii?Q?52w9Fbq6LnaUtB7P1U/IZ18wBkE7/A/pcuVGb0mgMojpp0KISnVpdo4fwkgm?=
 =?us-ascii?Q?PJp2tFMWMzq9GAYT2Zvfh3tbhe7wlbpApbigUUntc+DtU+YScTkNIrVbA39c?=
 =?us-ascii?Q?iXAjP3GslAV+s+1jh1UtQApPzJN/PxptyJmykhRpZFzD3zsSUZQ0UFWLvHHn?=
 =?us-ascii?Q?RlzVHQayDI7OSv30kvrde+Wgv1LrdIei8x82fjtYQOEJspNnU7QvKvvaeJfe?=
 =?us-ascii?Q?3YcJXk8umOkvYDA4GLVfrYAxEPf7HuApXpazqk126RpUkMSltbZaNR0dDGUI?=
 =?us-ascii?Q?8J4whE41Wxj/bcziZ5fh9W87I4xo9QVhwNq/U8bB1zok2bnDkXyKT3zxo7uZ?=
 =?us-ascii?Q?vBzY5caigDVZahxmdyTcyax81d6rsdH83Sn04OjAjNguf9IGYVTTsPkBEqeF?=
 =?us-ascii?Q?fUm8k/6cNr5475VEoYqjZy6co0VzIPs/xtf6DvIGUWbrp3QJ2YGGtPgiifbm?=
 =?us-ascii?Q?ZjAXSuP8xQ2NKvssWUT0NK5wbIcFbo8IgkxhdimmTtwOHIq4aoYfg+/ARo2e?=
 =?us-ascii?Q?Nmk8ZT+kDY7EOMe/bx8+aRBWzV1E5EG37yJ+e3xK09s1Fonicd9aYZ/uxc4y?=
 =?us-ascii?Q?FkBXtJzpnuls7L5xif1SVKA+il7Cfh+ZvMD2sslFkAf8I//Js7X5WUTaGPqr?=
 =?us-ascii?Q?KcT1RuI+iuFyCwK1gG/T9vjlDQOB2Hd1M/KS9pMfpDMpkXVZ37Qw1Dt1XJ5u?=
 =?us-ascii?Q?Pc9rNgqYCaE5RymyGK0H9soV02fnZpAI2RXaCphaAmAtupFoFL7SSgAbiW1o?=
 =?us-ascii?Q?nT688hFXNbJDxslMgWURsBkZFpXTksHzKtAmBrsocKLepz6ln2Ac1TGa194A?=
 =?us-ascii?Q?6s5mjBNaDMp3d84EA/oSiTXLqS+UDWhNEufkrLaImRmh4/l9sOPzu1zbFbRt?=
 =?us-ascii?Q?Qn7iyY3dVuC4S2dpDMclqw0Dz+gvc+FSv2rThq+6LYEwQOueMnYK6L+/UXM5?=
 =?us-ascii?Q?z4YDI0t/wRs8C1sX5vofTMaLU89NWb9NT7IDLn2gEduaevBUV5B6RV4n78Rb?=
 =?us-ascii?Q?KglMEfrUNsWvwmI5dYAq6DNFl+kDXseddm92FSFUdpCikS9rqi1NMiy8KxIq?=
 =?us-ascii?Q?8w2jxLcR9eZ/g2XPws4+Fh16mdnN7oF7c8PeLW/ayuBe3H5royyXASmigwdw?=
 =?us-ascii?Q?bB6e2HLJTf5ZG9uLgjD0eMgyJP6GcLHuKMOHVn45iFJDNUehjOCAtkznw9n4?=
 =?us-ascii?Q?IlWXmoOqqtbB3ehN/zRsEFs/gQHtdO+hZSvmcBH/b74Aow8fl2jPrroLQYU1?=
 =?us-ascii?Q?treQjbM1TzoNj3a9Jud8tYf/+eP1gMxh8azC0U6ddVenGh51X2qfwgCAl2MK?=
 =?us-ascii?Q?qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15c2b79-98bb-49af-c328-08dba4331b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 23:46:01.5427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hERmLopmKb9Zf5M4a9yB8VkzFn/3C7WYK2Ku4z5vqt8VIBqr+s+qioN5qljeonkrz8O6BuZOk2BZuaYU4wLMuhqCGtr5hS4Q6g3EpuUcJSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5941
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Wednesday, August 23, 2023 4:21 AM
>
>On Wed, 23 Aug 2023 00:00:30 +0100 Vadim Fedorenko wrote:
>> +      -
>> +        name: dpll-caps
>> +        type: u32
>
>Why is this one called dpll-caps (it's in the pin space)?
>"doc:" could help clarify the rationale?
>
>Also enum: pin-caps ?

Yeah, this is not needed now, fixed in v6.

Thank you!
Arkadiusz

