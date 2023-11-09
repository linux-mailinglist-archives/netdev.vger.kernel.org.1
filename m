Return-Path: <netdev+bounces-46878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D01B57E6E58
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C611C209E7
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA75221375;
	Thu,  9 Nov 2023 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTJ/p4Ip"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE4621113
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 16:14:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B29324A
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 08:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699546442; x=1731082442;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SLWUeJY5ZS499B5152SA4GPydgW9chTY8qlmN1UBHBc=;
  b=cTJ/p4IpDbtaX7Mhpb/Z6vcWIF50xxzWl3zOYbkJq2fTb4fQA0ADJkCG
   hhue3FqbNS5n1ua6MWBtvU2Tl+s6gQVplBcSR8ZloCt6wGf0XTDhUPs42
   h9FiWDvE3QIHL0atYJUqF7vbWfWg0Mufy//x7uJz3WPinyO0ykrgIgSHE
   R3uQN4bRLS/+YAwxG9gMnH8bQutnaAIWedSO76XdtTt+cKZfsC0HpHaB7
   Fyh22SqrtP0UR6K6DCZrjXzrjB3KyV+4LXAYLh8msgvWPXwIVnnsJX5Ne
   OPFotlnhreBEYQwrcPKzrwhP7ipDLpRGrJaPy32Nf5nNz6kxgEXS6mz4w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="392885207"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="392885207"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 08:14:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="739883793"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="739883793"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 08:13:59 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 08:13:59 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 08:13:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 08:13:59 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 08:13:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmyV/81w8xz2mxApdr+F20MLheWKzrxVjDW4krdYtAobMkyZnQdN6xRn/yKa1WyQR7jKt1WZgqCJLgRhOHBTe3s/TpTe9TAEIPCTREp7CGkvbD6ZqirRVtRBGUzf6YkqfIFDi+h9FrEqTtYQaP1WtYnK+5kwN0vWS6gwstvdXM5jYwuQdjDryXevjl/PjB3N8aMlk5RU40qOq57e0SmsBPyR+JyV20hsUEZuVV8V9UP6XtGyrjaaaHeRQGnXZzF93RfMPKWzE5yssAYK9K6O3K+sCLFHRMYxPGFi/rKml+7Hrh7co9IJ4KPP7uPIE09q+MWLq06t8xcw6821ooan0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KU/ZaagsaN9ddyo4ZFMYArD+odmwSj0oMqribcb4yZs=;
 b=ZNiQhfu3OqemUsjROTWKLXDeQht8aJczN1VvDZZ+LcZjZd+zWoxqTZmANE+dEO3Ln2FIZHPuV1SKRHC8alQ074rYq3L0a50Z0IkvHjLzcxqk1+yKryQUwmwZtGQDT10KK/qBoXujCpzbviV2eN/2ODma0COSj7WeyfHnNhEOO+mTBI+skamH1mybJeZTWmPiT+o27cAW03WnL2a6LxzGNAi2TKnYUe045TswZAA+JOD53vJZiPN0oj8JnnmU+8+f52Dvhh1vfZMSJiM2XFvF1x+tHEx5e1eqX4tELTD/DZmfPgm5QSTXa8uBQSVFWA4FZzrc3FjAynQ8qWtKhIPibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 IA1PR11MB6346.namprd11.prod.outlook.com (2603:10b6:208:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 16:13:49 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 16:13:49 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Michalik, Michal"
	<michal.michalik@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 3/3] dpll: fix register pin with unregistered parent
 pin
Thread-Topic: [PATCH net 3/3] dpll: fix register pin with unregistered parent
 pin
Thread-Index: AQHaEi9R20w3ZLh/s0yEUYAIdOH3G7BwhkSAgAE6GCCAADo2gIAALYKA
Date: Thu, 9 Nov 2023 16:13:48 +0000
Message-ID: <DM6PR11MB4657C155DFD3A06BF0E0A9CF9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-4-arkadiusz.kubalewski@intel.com>
 <ZUukPbTCww26jltC@nanopsycho>
 <DM6PR11MB46572BD8C43DACA0FF15C2CF9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZUzcjUqoL6gcxW6f@nanopsycho>
In-Reply-To: <ZUzcjUqoL6gcxW6f@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|IA1PR11MB6346:EE_
x-ms-office365-filtering-correlation-id: 84f1b45b-271a-4f12-eaab-08dbe13edb6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: szknZzFCTrNbHlqpfXt59qvOIUnI4XUHLdMuBLEs6p24wkLhZRFq6zpvLWbPCHzSHKED6JUr4kgnaz+HUocAK0tzdU826K8dY0ThroP3Qgj83WYOGZ1utFA1BHkstZqtdtNGmi6XQ4BZztHJRrkmmqRBdFETYRLceBDDnaivjrWrAwlBNIdIqZnaXFMOzQTbVXwou9+Fbywh+R6X48OfZ+p/BpS4pBXGC+1ITbK6dq8rm/L73rZNtPdczyRtzzaOW0vRPxmG+DhVzraneezNVXjVBciLuExcP18rvm00HyEtdog9xhmzayUlV4nvysK1xZcwng4ZN4uwccUWniV4pyuTGKlQWbC/POIJ9zqWgSzB+Si+SqBN49IMO6/fCUKmljc7w1CW0Ox3iWYhD8Ei+C2zOT4XCkINxzmWHKw6ZcBkcUfM1/ocbJH21y3M1Ae9iHVyCFtUMbYTYdVzV5YJPs2RtCUUqE9Ek3/A/m0WU00c0NnA6hNKF8C8saYkxT5IIv5Vs1H7k+8V8yKYDafJ1ea1Lw+5FvXWc8docayMv0LXwiqzqRjWht1gmwfLF2EqjS9c9Qh30CYhDgJjaGpoczyqLHdmNihhNom538oOa0EzETVW4z4GPqgQbgmt0sXB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(8936002)(71200400001)(26005)(83380400001)(52536014)(38100700002)(5660300002)(6916009)(316002)(2906002)(41300700001)(8676002)(4326008)(54906003)(478600001)(9686003)(66556008)(64756008)(76116006)(7696005)(66446008)(6506007)(86362001)(66946007)(33656002)(66476007)(82960400001)(122000001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W/y/FCILIw/CW741ozk89jNfFjX9Mffbfy/NS//49UmZFBKr1abuuKrf01LI?=
 =?us-ascii?Q?a09WD3JPm+06I97duDSDQdZ0uY287y4G4QJLxQvrHiDVTmmVup9SMTyyr943?=
 =?us-ascii?Q?RmDaHefZ2HWx9KppAjImTKqxvWWbhNhriBCA9E6fsCjgeoY/1y0WdW5rEkBX?=
 =?us-ascii?Q?NfhZJuclqsEaDPzqZM6LzMjgayqq/9vKNrixXE0PbdOlyvlvhGZxeeLXgTey?=
 =?us-ascii?Q?x6+dmlm2as5BElGu94+bbcvtwQZ5d7z5btoReba9RKMVpDcMS3d6TAGZ0e5S?=
 =?us-ascii?Q?0h21lepLLAXTga2VkfIl3o42lmtDSkHjFxreRkstLimgYihk0bYURiYS0FTs?=
 =?us-ascii?Q?VNeWSLE+k44AKYuaqoWLhqF2II64+9daAU844nsu8+GAoTzV/XZCx+kzOdil?=
 =?us-ascii?Q?rEAJW/Aow4gf9LYtnq8zumtV9oxYLcUIDKJqRT4AhgzQp+18vCVwdjBa6Jq5?=
 =?us-ascii?Q?wmx3mfBStSENy2YyQkm39QZGa+Qnh+aB5lkC9KBlvwTyx15IJ9yZWy3dDz++?=
 =?us-ascii?Q?Cz6TOGkPXY1wBlNmf7pQWugfaPztZT9AyPei00K2FQSzUsij34049HFPGhlV?=
 =?us-ascii?Q?4DNHPzHE9OtTxsLoOZeCJgk29g/nnn+ka/8IcR97n7x9lpZHgSYvbbxmG5wC?=
 =?us-ascii?Q?2TVNCLeSr3c1NTrZbIlYsajfE/+olQ1YwdHTfZP1rYby7TKE3iOwPret+4bw?=
 =?us-ascii?Q?/lVrGRIbMIAa2KLXEnz2jBSQjaqK6LNoX9YvhheXuckKhePqgVEkYFmnThc+?=
 =?us-ascii?Q?Fyl8UfqbopjMOwTsEsvsE6rYIP4XzV9YLn5Yiy7Zk4/VP4Q98iKPu+fXlt71?=
 =?us-ascii?Q?57JoCCA0p2JfRb3qOZmfGv3T8oL6x9jB3xRdZ9xAnVpILiS6f37D233po0RZ?=
 =?us-ascii?Q?21V5octMPHKXJ31KfeFckaFw+93TxMgAxcw+TbbRsmCVJZTHcQCuGP0ZwRY9?=
 =?us-ascii?Q?8HF1PEoGEa3mJpO0U3xUxhIjswx77TwsVhTSTbiZHcSaS65JnxR04sPUqtZK?=
 =?us-ascii?Q?jalC3h1QlI0b8Qwh7BJrpb5yMBQaRi+RuNAsWfTfsnqinx1ntXhGZhsF2u4h?=
 =?us-ascii?Q?vqCTy6osTGxCVFgyLOfcQMSf3sPg0sd8OeJLeMsddV+7hbKgt5MYUvasOyBK?=
 =?us-ascii?Q?U0bCZSLbT85xjrAxsTaBfJUUuIKJ50TfW7gxMstpQAVP+Y0Rc5QcqdeeFYJO?=
 =?us-ascii?Q?3i4/GUUUoHueGQ3XJ9niDuQR62/bvp3A4/bi5hEZX6+lRFLtd0MgytY1xhjI?=
 =?us-ascii?Q?phOeq6kYW0Bm/eF+9Npfw/TWl/T3EduWl51CP2PAXsiMnW9pjDsyOkBzYUC1?=
 =?us-ascii?Q?w8K6OnENx+19jTAgjkFu2828etyP7wv8uU3BKJsYpD9qFACNz40mJzHa1RVS?=
 =?us-ascii?Q?d2uS5kGfNs5d0XdnatIEtAB/ZRUVMVr7R3443UgDp7OE2gs10ZDY8EqSxTpL?=
 =?us-ascii?Q?c6vxrMBrvaR4ZHc5cn4cuLP2vtRxnXm0oyPE+DBZxXi1+TSSVVFYWLbaD0u7?=
 =?us-ascii?Q?FYeH1gCh1TK/ZeATA2e/nnPLnsXIW/eT9hR70vUCLybeEXSelxoWuTRI3LE7?=
 =?us-ascii?Q?wdU8s6nHvYfLJgaX9SfPrATFfZhyBrYaMrdm9zH6HilRelY+xAjPh+q2OCPg?=
 =?us-ascii?Q?lw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f1b45b-271a-4f12-eaab-08dbe13edb6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 16:13:48.8402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A6+b26GBiOzpQJ0u9FEacHpUruhZoKTm4zFG7ZyBZJI537Z0rKJ5wEKJaYzsvW6i8N4kn1OZKVJaPphIVIXWJYJGJdPIO1mY0/RFrjpBP9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6346
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, November 9, 2023 2:20 PM
>
>Thu, Nov 09, 2023 at 10:59:04AM CET, arkadiusz.kubalewski@intel.com wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Wednesday, November 8, 2023 4:08 PM
>>>
>>>Wed, Nov 08, 2023 at 11:32:26AM CET, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>In case of multiple kernel module instances using the same dpll device:
>>>>if only one registers dpll device, then only that one can register
>>>
>>>They why you don't register in multiple instances? See mlx5 for a
>>>reference.
>>>
>>
>>Every registration requires ops, but for our case only PF0 is able to
>
>What makes PF0 so special? Smell like broken FW design... Care to fix
>it?
>

Well, from my perspective FW design it is.
AFAIR this single point of control is somehow related to HW design and
security requirements back when it was designed.. Don't think this would
be doable anytime soon (if doable at all).

Thank you!
Arkadiusz

>
>>control dpll pins and device, thus only this can provide ops.
>>Basically without PF0, dpll is not able to be controlled, as well
>>as directly connected pins.
>>
>>>
>>>>directly connected pins with a dpll device. If unregistered parent
>>>>determines if the muxed pin can be register with it or not, it forces
>>>>serialized driver load order - first the driver instance which
>>>>registers the direct pins needs to be loaded, then the other instances
>>>>could register muxed type pins.
>>>>
>>>>Allow registration of a pin with a parent even if the parent was not
>>>>yet registered, thus allow ability for unserialized driver instance
>>>
>>>Weird.
>>>
>>
>>Yeah, this is issue only for MUX/parent pin part, couldn't find better
>>way, but it doesn't seem to break things around..
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>>load order.
>>>>Do not WARN_ON notification for unregistered pin, which can be invoked
>>>>for described case, instead just return error.
>>>>
>>>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base
>>>>functions")
>>>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>---
>>>> drivers/dpll/dpll_core.c    | 4 ----
>>>> drivers/dpll/dpll_netlink.c | 2 +-
>>>> 2 files changed, 1 insertion(+), 5 deletions(-)
>>>>
>>>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c index
>>>>4077b562ba3b..ae884b92d68c 100644
>>>>--- a/drivers/dpll/dpll_core.c
>>>>+++ b/drivers/dpll/dpll_core.c
>>>>@@ -28,8 +28,6 @@ static u32 dpll_xa_id;
>>>> 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>>>> #define ASSERT_DPLL_NOT_REGISTERED(d)	\
>>>> 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>>>>-#define ASSERT_PIN_REGISTERED(p)	\
>>>>-	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))
>>>>
>>>> struct dpll_device_registration {
>>>> 	struct list_head list;
>>>>@@ -641,8 +639,6 @@ int dpll_pin_on_pin_register(struct dpll_pin
>>>>*parent,
>>>struct dpll_pin *pin,
>>>> 	    WARN_ON(!ops->state_on_pin_get) ||
>>>> 	    WARN_ON(!ops->direction_get))
>>>> 		return -EINVAL;
>>>>-	if (ASSERT_PIN_REGISTERED(parent))
>>>>-		return -EINVAL;
>>>>
>>>> 	mutex_lock(&dpll_lock);
>>>> 	ret =3D dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv); di=
ff
>>>>--git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c index
>>>>963bbbbe6660..ff430f43304f 100644
>>>>--- a/drivers/dpll/dpll_netlink.c
>>>>+++ b/drivers/dpll/dpll_netlink.c
>>>>@@ -558,7 +558,7 @@ dpll_pin_event_send(enum dpll_cmd event, struct
>>>>dpll_pin *pin)
>>>> 	int ret =3D -ENOMEM;
>>>> 	void *hdr;
>>>>
>>>>-	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED)))
>>>>+	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>>>> 		return -ENODEV;
>>>>
>>>> 	msg =3D genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>>>>--
>>>>2.38.1
>>>>

