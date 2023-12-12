Return-Path: <netdev+bounces-56264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D3580E4D2
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 08:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E907E2845C0
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 07:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A517168BF;
	Tue, 12 Dec 2023 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzTYf29c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E5CA6
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 23:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702366136; x=1733902136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=wZETlm15eC7yLCnabggOQKOXQG7KqXvf0bRef2ja9+I=;
  b=CzTYf29cNRfuFApSXddCokiujubkYVwoK8h+7xA11UbCBPeaM/QU/r6H
   Rb8hMLK50OMhnYeaKfU+es0OXdNqC9vEe30Wu7F3sWW12JgP5ejqsmzgW
   ZTOm6KHEFqS1rcqjJ0u93gCGs8tFRwm4iyXs1pGw6VJ80pImjdKxoeX2n
   174Fe2/h4PNRSNaNF/FfKVsVAdqV6KvVba3KK2amkkrqCO7zZHa9pcdWe
   rxvieZZiXrVfslo2fV3jF8bqVhW9UNaS8Tzh3sdOw8iAsT/xnKgU9D/Ij
   2iGNeMwT3KYBNE8KlnshBKulfzMMzoBTvl35b8hFkvBrQv47bHqQ+TBSl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="394515263"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="394515263"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 23:28:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="773426659"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="773426659"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 23:28:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 23:28:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 23:28:55 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 23:28:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YawYpuW1ygeGRV1shBZXOhOFCSjKroR0sLGmyWh958QDAONNUchWk/POyPMJq3Zp0ZYpdqI+y5mxeHPZgAx1v0DXVaCirKtkCBjnlaXUxdkkDOPCBGCDnbLgMjRilpUzCQ7UgsBqDUIGr9NR/r424ixU8GG9AUgq+gtDewulSYiHqt1rjrzoAs3M/JMiKCcTqAbQj5tkvMvkMeZO5Ag+INSAHJAJWSiQys0JF7ESQnQvd1ebV7s+4ATNs5CmV7ku+UQwlTwsWvrvFUlgQBm5NIw/edadKP+iKa7asHnWhuwNfBehXgijb/ixmaMD36N/jNjI60lFLTOGr9Pu8mmp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2t6zoWszRwdKSfRfEpVtWDba2VoSW8fnCaYWyZPl10=;
 b=nitpoJXWrk2Jdr11FETCQ7ZBs308p0GjstiZ5aMhpq2G64SZIBjK06W4nGAWRKx8jKSKeBJul34Crx/0ZJ1zoDruNDfkWXG0zCTzUhGnvrjRyWNsjC+WYWcTIDXcyHcXH8wwaow6VhwnXcWYqr4T6erNRT+tXItWTD3Z2SDpPnetmmNxoi4Q3XPWncFk2r/wiet+vm5nA7nbbtlCd5GXnuVJ7zi5itLgqA1yEbHQcC60E864QUpIaJIUPOoUY9UvMEmLWRWKjIZG/wj+NlOATgiqgltbxGkBTKRtI0VVb8CwKGSAl7DsFdnzWE1YKxAJb8G5asnSfXRDEIIdSDd7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5359.namprd11.prod.outlook.com (2603:10b6:5:396::21)
 by SA2PR11MB4876.namprd11.prod.outlook.com (2603:10b6:806:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 07:28:50 +0000
Received: from DM4PR11MB5359.namprd11.prod.outlook.com
 ([fe80::d3fa:b9a3:7150:2d6e]) by DM4PR11MB5359.namprd11.prod.outlook.com
 ([fe80::d3fa:b9a3:7150:2d6e%3]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 07:28:50 +0000
From: "Berg, Johannes" <johannes.berg@intel.com>
To: "Sang, Oliver" <oliver.sang@intel.com>
CC: "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, lkp <lkp@intel.com>,
	Linux Memory Management List <linux-mm@kvack.org>, Jakub Kicinski
	<kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [linux-next:master] [net]  b8dbbbc535:
 INFO:rcu_sched_detected_stalls_on_CPUs/tasks
Thread-Topic: [linux-next:master] [net]  b8dbbbc535:
 INFO:rcu_sched_detected_stalls_on_CPUs/tasks
Thread-Index: AQHaLLjFBUjoK8KTCkW9NVvUqMPfUbClQCFA
Date: Tue, 12 Dec 2023 07:28:50 +0000
Message-ID: <DM4PR11MB5359FE093CD28B61711F37A8E98EA@DM4PR11MB5359.namprd11.prod.outlook.com>
References: <202312121032.40bab6f5-oliver.sang@intel.com>
In-Reply-To: <202312121032.40bab6f5-oliver.sang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5359:EE_|SA2PR11MB4876:EE_
x-ms-office365-filtering-correlation-id: 283b4b18-c151-4b71-b395-08dbfae3fcc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S9nAoPC05tcVmjL7Vt4E7T90msIk3s7qWND+GJaW5/6fKKdAFVbxJaAK4TkpxQAp1tjz3gPw7fMYTNGPT6YxH7pDFYOYjFpKJg+/Rm38jJtxT63z0oNGydEm63+WOi4XabQrAXObfloavXHMMoEcUOKzjpOI5VBLMhDB35Wv/t8sN+InhokVQjs1kwLTpWxQADOkp84E/scSWFiCEplHbPmOOTLnp46Id8HvdvyvlGDilr6pGx9NRb0odw2Y0X00CoY4TyTlcJjKEr2mZKD8robHrbrQKkO5U70UOlaS3ccEu8Usdk9U1zuX5QLMhKyd23yLtG3QeHLuH228ui9gEtI8dRxxJyUB19idoURy2Eu1xpt9rqCZFRGhCaa8Fr2yy8POCNbj0abCojqsgi9xyFj4ZD7sThnP4j2FGUXS6QPjURfQDmqLt5J6D4DXjJk3akb23zg9GBrvQUxvPUUjIDHMLj6oDgIEnP+w0oA88DitQszlS51qb68W/IqNIUiE48zasNj1VHVHT0HRsnjXSyfLkiX6gCN4OFb3woDYKZ6dkZa4lqM+vlCqa7uAVycT4QiQE+MPuPTXZBEn8cluqlmn6aGHpPv5Xgfath9nOQ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5359.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(122000001)(38100700002)(82960400001)(8676002)(71200400001)(8936002)(86362001)(316002)(64756008)(66446008)(66556008)(33656002)(66476007)(6636002)(76116006)(66946007)(558084003)(54906003)(38070700009)(478600001)(966005)(2906002)(6862004)(7696005)(9686003)(55016003)(26005)(6506007)(5660300002)(52536014)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LOmHtVRNmSEhQsQOWPELgZBSjrLx6X8uMefSdUydiPcBESL78+iHh2tSCOB+?=
 =?us-ascii?Q?2gtbEOPy3AUOSrjSdGzBtki7fqXenKA0MruhoZaGxtPyRc289P1hRpoTHBC+?=
 =?us-ascii?Q?9DeZVMiP8eJooPtU7syQVt55TPHLUuhYTOFptnDlpGE1WN4h9xK4/3cBen5L?=
 =?us-ascii?Q?egQeJAr4mYc/3dc1tllfaRwTHb4EUlX4iISFbRkE57elZZmK9VoSXn4Iw08Q?=
 =?us-ascii?Q?tRRkz0RLk673Is6qvZ4t1zDlT3Yz4s26ND0w6F8XamZwkA3gvQAeSfgWt7uS?=
 =?us-ascii?Q?sW1rY0MnXytKfbhn9V826gmhS7ERZYM6N3eyN8yEb65YqDWxlQJiMFxaHftl?=
 =?us-ascii?Q?jIoszcAXZtYuWqGWlPvcEporEpBnrMs+UhAD5VEvxoM/ycOCiaKGT6C/iMYc?=
 =?us-ascii?Q?lhgeudgCkOSTWRkFeUqjIrKNRn9rUpQ49Xkxv1EeZRbhBL4lVz/iM731v+Xd?=
 =?us-ascii?Q?4SpTbZF+Z7tjnvg8lbQ8Y3TFnYxVLdRDsgZnOEEsvHFEkXMM0BsJzv6SQ5kJ?=
 =?us-ascii?Q?+aNsIH1vHl3IW5Ka/R9WlIKHmDfAqE43FiFzVX/tOGdhwlkLiU8q4XX5etL0?=
 =?us-ascii?Q?3PyvaN8/MVw9IiN8LAAhRdQzV19E2dQVCL5n3p4iHWRVLfQq+u/JZpONVzEm?=
 =?us-ascii?Q?lMc+masdo9kOsxwKIEtHMFzftEeYjqoy2jBLqh8uK+NInHmetRM6oOGp4rA7?=
 =?us-ascii?Q?dne5KUiBi6Uv2eGKQ5qjXhpzHRc5d7cXYXL9K8w7fQVO/6Sg0OVOyIXK/2cl?=
 =?us-ascii?Q?bAHzKigWnNq+xEd+LR90ZqzgWvfrDBwEuShk1MWMXHotcfQYyD2AhXW64GNx?=
 =?us-ascii?Q?umNQLycFF+FKCEC7LhlYVAbYitPfJ9fX61PEgR5/yctVYT4XV61M9Mb8lDMg?=
 =?us-ascii?Q?DjYEaiN1kEA3UunWuivfDo1I/yRxGWdtAbO16VFlGDZ2yUw34VbrtQ1SuU2z?=
 =?us-ascii?Q?FTWgLptdl7bvQwbSbUX3xXdFRgsy0FUam8Z/EnfZZe0+INpZrlfdOzxaSVA+?=
 =?us-ascii?Q?QhXtkFjaAw/l52GjWfebjQd6kIE1AJxOXxmVtqRvHjOeNl4VOS3PYc+8EE6+?=
 =?us-ascii?Q?QnUnr3D3EvP6DqfH9r/k4/kv1oVZgbMhDFI68Fov7x9ULBTyevPicvULkzgm?=
 =?us-ascii?Q?xBiCxgtYT2M4+ptxfY+YNRhgCS/T2zlNg7fEMOKg0rbJiVd4UuG8G1LZdSd/?=
 =?us-ascii?Q?Eyg5p2MHaNdaQ3RX5ykHFTOXGlSDgWW/kLvuIWqZsClV3MUzdflSrHZihnYU?=
 =?us-ascii?Q?UvTWJ/pqVRhgrn5A7uEXV4EwWvQVWUY2w4GUdEg6F81BvK+A8RxDvnsQQWqu?=
 =?us-ascii?Q?3NJnOj7yPQbSAqVTdTtyQTkXNRmJgj80Dg+e6/jFW459FJAizX2yuwY33Xdd?=
 =?us-ascii?Q?uYruDS+s678Wd63knK3zvAnpoFO1FPuS4PgrbRUzjkqwHX+O5U0i6s3+v2ib?=
 =?us-ascii?Q?jegM73/drjoUGoaALMxDsgGtMU3e61jrDw7Wn3qvZm/rIDc4lTaxVIwoTtym?=
 =?us-ascii?Q?8UtgWQtwUI/Sv9+xI/UV7IHkh8nVPAlPUkxy59UqTxqzlaK4YrbaKo3YZ1R5?=
 =?us-ascii?Q?YwUzr9NaXeZMpEnwwOF8wv37qebtonvI1HaLsoNH?=
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5359.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283b4b18-c151-4b71-b395-08dbfae3fcc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 07:28:50.8088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGZ+KqaVda0WE1zy+O/OxSisHelwkFjfK0TuSAKeuXPlFFHVPjrIzUGyIFsjFqWa5VVQbpmiIY/5lv6moR+qjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4876
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable

> =

> commit: b8dbbbc535a95acd66035cf75872cd7524c0b12f ("net: rtnetlink:
> remove local list in __linkwatch_run_queue()")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

We already reverted that, due to other reports (and the obvious brainfart i=
n it).

johannes
-- =


Intel Deutschland GmbH
Registered Address: Am Campeon 10, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de <http://www.intel.de>
Managing Directors: Christin Eisenschmid, Sharon Heck, Tiffany Doon Silva  =

Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


