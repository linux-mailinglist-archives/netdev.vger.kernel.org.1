Return-Path: <netdev+bounces-46846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92F27E6A72
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 13:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6159BB20BE6
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 12:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281A61DA2C;
	Thu,  9 Nov 2023 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etXlJUvZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F381944C
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 12:20:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B473E2736
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 04:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699532452; x=1731068452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0kQ88nzECcyQFTS1op5NJ9DzX8Y3nGpCb/Jq1bAUcYw=;
  b=etXlJUvZEuPwo7d5nJmxqnSW3YU0fL9dWUJqYTPeuQ4xpR1w/uIPTaW2
   Km+XTqxdhiEFToo4ULCvyMIL6pDKGYOMHJsaCm3fpFQvPxmiANWYvswJc
   D3YBvqrU1dKSewBqVPiMIuHgGBnlYslfWOmrJt5/HRD8JxOCCafxJ8r7M
   a6wB/NOfHUboQREkLnGwFiKQi9qdM5lvjB6p0iVd2kwHsXFl9rJrW0BND
   9mxozyXptShDpN6qiiiw8yYCd9QIEHNG+cfiH5CURjsN3hVXWFUhQG/sK
   VdM1GYeIxI3UOM+HwFWoXgc/7WRBn/1x8mEClMP5pyKqA3QOmO5QBHflu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="370174734"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="370174734"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 04:20:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="886976499"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="886976499"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 04:20:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 04:20:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 04:20:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 04:20:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6uRyQrKO5xZBJbE5rwGbASA1P/fX5X6bdn8jh1ow6WjXDJNI4NhoVn89Tr1Xv5DjO/TD/TyNxu16ovxGXm/R45cRIgBHA7w+BX+pO30ya89Oxcig8qZXNa3gGIT/MqOBjb+uF6Q77jYtMah6TS7I7AYsY9mrUknCdexLEimk0WleGdBoUa4tJ+nXeP+F5EPLYDmRUqRPjCsbX+8djWP6luiilgtakLeBW4dUzcSL/ftMv9SrNbyiNyTKHia1bDJwG3VXtOglLjkHuUzlnDjUipBqoKX5tZxJ0+IH2v4711rJjdwm8FPXfwPLd+fREZFmKiEoMM2+KN7gpN4UIUV+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9on6crR2CctTOcI1vrVLNXOjp9eRR3htR6dBryddcWo=;
 b=oGL2OnYROudsgVNhojtAz6momiuVreclumhFtz6dh3BtQciW2himfjc2TJqHdU2uNM2TJG57gMgLU8i9RMf+DccUO8sfhzusM/Qj+c0kakliWOzM+ukhg5MioiGi5lCSy/zsaWxtav/PRsXwTkptmjwbj0upJbXapmFWqW4jNE83OuhdPAt7nSwqeWioPNxS59GYPT+pKPJW8v0VEZZNFtc7+vRgjSAs8C0gD3rmAO7jF/Fqu1aH3vMdEBm5dwh8eZL9j1gChmKlClLP1G6CmY+276F5rkAdhJRn/ZC+ARv0/KMZCK4Sr/hke+UOQLXKLztqgd+bq0ZqRgxmAJT5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SN7PR11MB7437.namprd11.prod.outlook.com (2603:10b6:806:348::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 12:20:49 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 12:20:48 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Michalik, Michal"
	<michal.michalik@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 2/3] dpll: fix pin dump crash for rebound module
Thread-Topic: [PATCH net 2/3] dpll: fix pin dump crash for rebound module
Thread-Index: AQHaEi9PNvCIepF1tEu7KRNf+M25RbBwe78AgAFGpmA=
Date: Thu, 9 Nov 2023 12:20:48 +0000
Message-ID: <DM6PR11MB465752FE337EB962B147EB579BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-3-arkadiusz.kubalewski@intel.com>
 <ZUubagu6B+vbfBqm@nanopsycho>
In-Reply-To: <ZUubagu6B+vbfBqm@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SN7PR11MB7437:EE_
x-ms-office365-filtering-correlation-id: d76a30b4-bd5b-49af-de06-08dbe11e4e7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gdgu8GTkxWRWXil8zJDf5OLQp3kea+ChOIHMPQu7EVKIL4XPtbxLpxAnCqjH3oS7J8Ahu7cter7wj1+rNzueZGLQjiNtePca9lusdrkiWB25acuG6qthHB/H7ZB9izQ8Z1Dqjq0wkt8p6aXO69ojSEQVkC1Lf6wM/d7PqJ8WmpFYOhyu5PgE1NBoA61yvPsr6aXKnf5LGLbyiF/22NRqxWYUNqKMYPOHUGx7tijRtlFtas5GCPagWeigvK/JfScmqaoJDXAGMmH/OwmF+M5kxc4nyRfCqmG1W98yy+RcG+mf6E+/lF/DhXzLPnhdwtEk4uMuXSFchFKsOk0yl3NVS0WHQz+a7T7bp4vhrAe71OO/ZwMq/gzQyMWAnJFL/uDVOZ9ADIrwLNndzp8Mi7BpbdjjbcxQGu1ZdkBtpuOpq7GR8mesS0bLY7F6jBX/cJtDpjVKxOhuzEXLnvL+UZN5DUO7Q7xbiuB2D0NXTl7WD+OseAdYCLMelH8R85nreMWxqlZf/K0MU9yeJVU/ADmYpV6jkdaSn08f5s1vo98DZyuoin5+a+8WQi/mIcsvqj/CPL0feuv+u6itKYaJkdwleHE0m3pC8cXGGa0KbUrccTM1QFX4zq15L1+gl0gOILWq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(66899024)(71200400001)(26005)(83380400001)(8936002)(52536014)(38100700002)(5660300002)(2906002)(316002)(6916009)(8676002)(41300700001)(4326008)(54906003)(7696005)(478600001)(9686003)(66556008)(76116006)(64756008)(66446008)(6506007)(86362001)(33656002)(66946007)(66476007)(82960400001)(122000001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PEps0d4VkL5vYQ8JusAI3z/O4NyuEk0IBp7H/AWskUJHt+x+hNVM4yxRMwpc?=
 =?us-ascii?Q?PDBMAAePD192ZVCEa1KHfgK1vKm3E/7dRUep40a/TPL8G+JDfRVBZlPDqkNk?=
 =?us-ascii?Q?whWRs3EKI5seQlvCN8pBpVag7E/UaQu3yp21cx+SU2W5Ky9NC0UQ0oouUPWT?=
 =?us-ascii?Q?G/6mvbza+A00cWXNLmZCmuDeD1kzm8chr/greeH+vZll+RRrrHIsdiZYl/BJ?=
 =?us-ascii?Q?oEnAkAkKMT0h9nv49k4LO7gCGDa2X27VvH18g7G9vDv8yEjXkjmZfse6oKG0?=
 =?us-ascii?Q?TUNi48sVI6EJ1GedxahQBSGFr61dKnObVphkjAxA30zFPccZ6xv1Bt7ALxF/?=
 =?us-ascii?Q?JPjxlfi4Rq4yuDCHxoQs72ADngSgotuEyQTjBrRPGghCkkC0LWM1QXnCeyS4?=
 =?us-ascii?Q?kkpscZPp6f7JYwa7zoZ8VZ/rxyd4JW96lELkrVr4ZhjVlSAN3Mq68NImv8BP?=
 =?us-ascii?Q?nNqIgv0BECm+hFOm04gCQer+72pwCx1JxgyLqYUu+71Kfav0txAg/I8YnlTS?=
 =?us-ascii?Q?wiix9mjCbS0wO0+RIadZ2vd9Mxy93ZhTtU7I/PFLJhZVLRSmcS9MDlyMHI15?=
 =?us-ascii?Q?Lgz4O0cfDi8f/a3bd7Nm8hzV3hZ68ciqrtoLaqMZP116+a016JyMOuLHcxeI?=
 =?us-ascii?Q?cyxncZ8V5daJ73GmGNl7wWQB8M69UYx4Pmsl645Acxf9+2XU1RBW+UI9RYwV?=
 =?us-ascii?Q?/7VFTSqeHvxon6Nr+soxZkN5d+SMMlkJVJAGUtaX8yQdFSp5SFj887GoxG6Z?=
 =?us-ascii?Q?YvNNkYxonuRpz/jFjhntTGU0Gz7Tyhv4c/M1GiS76MQMIJgMRbFyw8EkP8MY?=
 =?us-ascii?Q?+ws0P25psGBLrN8Uh3Isyr4cZOpTE+JEgGFBmD+dqQS+/kmCsNGEm/ksz1Ik?=
 =?us-ascii?Q?ikTWxgJsmCZetjWA1rSPn55koVqTX2P+iNhJiYTT8qFQ7OHOx9RAxJ8OBU7S?=
 =?us-ascii?Q?jutAbmRj5xxlDWglVlQcwcQkp9ZWaj0olb0rh9F1VvYA6SHmwbLJ1VhyqqJS?=
 =?us-ascii?Q?fVIQTPZWqvxpCia04PxqPKW03BFBUqGEB+pPRKB098h/rhf3WAbUFKgzsGyH?=
 =?us-ascii?Q?FXG1RENhDTvm0HCZNpzLvewCSPJWKD+pLXjSZEj3J929t69uPjtqI6VNPmVv?=
 =?us-ascii?Q?mX4aH9S9/qX7mb6O23VXNwj/Gr4+8wcYCGuMiw9WUJf97RfSje9iPv2ioSOS?=
 =?us-ascii?Q?OSg0HBsHSXHujblGT0J4DVq7MFEC+OaZ7SwGDvCrl5FNbM25pJHIREjra4Ax?=
 =?us-ascii?Q?WzY2ZGR1FdFWPmLa5Z+Mget3SdiIb5KfzHw1yvflHkHkKsKnHc1lbuzvb0jV?=
 =?us-ascii?Q?+RL7U9pwmmgU+Lgi1kCh4gx55HnFm9upSH+ROvEpJcUEUyiK5xTSDtR0Cwef?=
 =?us-ascii?Q?JUUABHl+E6N66wCiYQfwb45VP15vho6Os5xKvk23jlBasLiD2DHAELg9VKMI?=
 =?us-ascii?Q?M4aTWJ50N3mY634/mEgFwODA0W/42op1IZVobzckrTwL6355XePOeAeGI2D/?=
 =?us-ascii?Q?+sjDezExYyQMf8oXTcuyJy3H+0bSS1zAxfJbRdP3DPFrnq4w1K5eoyVx5YWy?=
 =?us-ascii?Q?rRGOP8Zjz6t6ff25+U6ZQdQ7VK21G7OzVzaWhYHVn78afDvHSFIh220eQlSQ?=
 =?us-ascii?Q?dQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d76a30b4-bd5b-49af-de06-08dbe11e4e7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 12:20:48.4926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmx+0pDMqcpUjfoykl/XUm0VVGThZzXhQCosvLs3F7H+peiZXL4W7V+8czSR2nWsaFebEglctCco10oNaqkp4WRkn4xrBwCXSQxbCIY1ic4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7437
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, November 8, 2023 3:30 PM
>
>Wed, Nov 08, 2023 at 11:32:25AM CET, arkadiusz.kubalewski@intel.com wrote:
>>When a kernel module is unbound but the pin resources were not entirely
>>freed (other kernel module instance have had kept the reference to that
>>pin), and kernel module is again bound, the pin properties would not be
>>updated (the properties are only assigned when memory for the pin is
>>allocated), prop pointer still points to the kernel module memory of
>>the kernel module which was deallocated on the unbind.
>>
>>If the pin dump is invoked in this state, the result is a kernel crash.
>>Prevent the crash by storing persistent pin properties in dpll subsystem,
>>copy the content from the kernel module when pin is allocated, instead of
>>using memory of the kernel module.
>>
>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>---
>> drivers/dpll/dpll_core.c    |  4 ++--
>> drivers/dpll/dpll_core.h    |  4 ++--
>> drivers/dpll/dpll_netlink.c | 28 ++++++++++++++--------------
>> 3 files changed, 18 insertions(+), 18 deletions(-)
>>
>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>index 3568149b9562..4077b562ba3b 100644
>>--- a/drivers/dpll/dpll_core.c
>>+++ b/drivers/dpll/dpll_core.c
>>@@ -442,7 +442,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>>module *module,
>> 		ret =3D -EINVAL;
>> 		goto err;
>> 	}
>>-	pin->prop =3D prop;
>>+	memcpy(&pin->prop, prop, sizeof(pin->prop));
>
>Odd, you don't care about the pointer within this structure?
>

Well, true. Need a fix.
Wondering if copying idea is better than just assigning prop pointer on
each call to dpll_pin_get(..) function (when pin already exists)?

Thank you!
Arkadiusz

>
>> 	refcount_set(&pin->refcount, 1);
>> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
>> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>>@@ -634,7 +634,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent,
>>struct dpll_pin *pin,
>> 	unsigned long i, stop;
>> 	int ret;
>>
>>-	if (WARN_ON(parent->prop->type !=3D DPLL_PIN_TYPE_MUX))
>>+	if (WARN_ON(parent->prop.type !=3D DPLL_PIN_TYPE_MUX))
>> 		return -EINVAL;
>>
>> 	if (WARN_ON(!ops) ||
>>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>>index 5585873c5c1b..717f715015c7 100644
>>--- a/drivers/dpll/dpll_core.h
>>+++ b/drivers/dpll/dpll_core.h
>>@@ -44,7 +44,7 @@ struct dpll_device {
>>  * @module:		module of creator
>>  * @dpll_refs:		hold referencees to dplls pin was registered with
>>  * @parent_refs:	hold references to parent pins pin was registered
>>with
>>- * @prop:		pointer to pin properties given by registerer
>>+ * @prop:		pin properties copied from the registerer
>>  * @rclk_dev_name:	holds name of device when pin can recover clock
>>from it
>>  * @refcount:		refcount
>>  **/
>>@@ -55,7 +55,7 @@ struct dpll_pin {
>> 	struct module *module;
>> 	struct xarray dpll_refs;
>> 	struct xarray parent_refs;
>>-	const struct dpll_pin_properties *prop;
>>+	struct dpll_pin_properties prop;
>> 	refcount_t refcount;
>> };
>>
>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>index 93fc6c4b8a78..963bbbbe6660 100644
>>--- a/drivers/dpll/dpll_netlink.c
>>+++ b/drivers/dpll/dpll_netlink.c
>>@@ -278,17 +278,17 @@ dpll_msg_add_pin_freq(struct sk_buff *msg, struct
>>dpll_pin *pin,
>> 	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY, sizeof(freq), &freq,
>> 			  DPLL_A_PIN_PAD))
>> 		return -EMSGSIZE;
>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++) {
>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++) {
>> 		nest =3D nla_nest_start(msg, DPLL_A_PIN_FREQUENCY_SUPPORTED);
>> 		if (!nest)
>> 			return -EMSGSIZE;
>>-		freq =3D pin->prop->freq_supported[fs].min;
>>+		freq =3D pin->prop.freq_supported[fs].min;
>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN, sizeof(freq),
>> 				  &freq, DPLL_A_PIN_PAD)) {
>> 			nla_nest_cancel(msg, nest);
>> 			return -EMSGSIZE;
>> 		}
>>-		freq =3D pin->prop->freq_supported[fs].max;
>>+		freq =3D pin->prop.freq_supported[fs].max;
>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX, sizeof(freq),
>> 				  &freq, DPLL_A_PIN_PAD)) {
>> 			nla_nest_cancel(msg, nest);
>>@@ -304,9 +304,9 @@ static bool dpll_pin_is_freq_supported(struct dpll_pi=
n
>>*pin, u32 freq)
>> {
>> 	int fs;
>>
>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++)
>>-		if (freq >=3D pin->prop->freq_supported[fs].min &&
>>-		    freq <=3D pin->prop->freq_supported[fs].max)
>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++)
>>+		if (freq >=3D pin->prop.freq_supported[fs].min &&
>>+		    freq <=3D pin->prop.freq_supported[fs].max)
>> 			return true;
>> 	return false;
>> }
>>@@ -403,7 +403,7 @@ static int
>> dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
>> 		     struct netlink_ext_ack *extack)
>> {
>>-	const struct dpll_pin_properties *prop =3D pin->prop;
>>+	const struct dpll_pin_properties *prop =3D &pin->prop;
>> 	struct dpll_pin_ref *ref;
>> 	int ret;
>>
>>@@ -696,7 +696,7 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32
>>parent_idx,
>> 	int ret;
>>
>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>-	      pin->prop->capabilities)) {
>>+	      pin->prop.capabilities)) {
>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>> 		return -EOPNOTSUPP;
>> 	}
>>@@ -732,7 +732,7 @@ dpll_pin_state_set(struct dpll_device *dpll, struct
>>dpll_pin *pin,
>> 	int ret;
>>
>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>-	      pin->prop->capabilities)) {
>>+	      pin->prop.capabilities)) {
>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>> 		return -EOPNOTSUPP;
>> 	}
>>@@ -759,7 +759,7 @@ dpll_pin_prio_set(struct dpll_device *dpll, struct
>>dpll_pin *pin,
>> 	int ret;
>>
>> 	if (!(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE &
>>-	      pin->prop->capabilities)) {
>>+	      pin->prop.capabilities)) {
>> 		NL_SET_ERR_MSG(extack, "prio changing is not allowed");
>> 		return -EOPNOTSUPP;
>> 	}
>>@@ -787,7 +787,7 @@ dpll_pin_direction_set(struct dpll_pin *pin, struct
>>dpll_device *dpll,
>> 	int ret;
>>
>> 	if (!(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE &
>>-	      pin->prop->capabilities)) {
>>+	      pin->prop.capabilities)) {
>> 		NL_SET_ERR_MSG(extack, "direction changing is not allowed");
>> 		return -EOPNOTSUPP;
>> 	}
>>@@ -817,8 +817,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct
>>nlattr *phase_adj_attr,
>> 	int ret;
>>
>> 	phase_adj =3D nla_get_s32(phase_adj_attr);
>>-	if (phase_adj > pin->prop->phase_range.max ||
>>-	    phase_adj < pin->prop->phase_range.min) {
>>+	if (phase_adj > pin->prop.phase_range.max ||
>>+	    phase_adj < pin->prop.phase_range.min) {
>> 		NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
>> 				    "phase adjust value not supported");
>> 		return -EINVAL;
>>@@ -999,7 +999,7 @@ dpll_pin_find(u64 clock_id, struct nlattr
>>*mod_name_attr,
>> 	unsigned long i;
>>
>> 	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED) {
>>-		prop =3D pin->prop;
>>+		prop =3D &pin->prop;
>> 		cid_match =3D clock_id ? pin->clock_id =3D=3D clock_id : true;
>> 		mod_match =3D mod_name_attr && module_name(pin->module) ?
>> 			!nla_strcmp(mod_name_attr,
>>--
>>2.38.1
>>


