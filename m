Return-Path: <netdev+bounces-46949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE9B7E7511
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 00:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3CBB20B5A
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 23:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C238DE9;
	Thu,  9 Nov 2023 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aH35LMvB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94733374E2
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 23:21:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C654231
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 15:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699572079; x=1731108079;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P3Vx1W3c0k7GiYCUbck0dW8PLOZdAgxTk5ipErBOz0w=;
  b=aH35LMvB0rgdvhZ3lLN8CTUhBLMpBs4KU4dKG70A3xYL3zE7P7RVscTb
   2sJl2a9VCFY8ECecgW8hG3yd4Mqz5MKuCw8/EzSyeeKLNnyNbvFII1eWY
   eVP1sFIE5X6oJ7c5yzwVfkaZCHKUMg44HWijziHs2Y5FnElm3glm+CMNJ
   GzoQgbEWFj7S3uwmQDcCLvo9hzUr89sqhmN1zh3f+FmAuQWNzghwFpFY3
   7ySZQOM6rLRTa1Raxz2nXjKRCFFj8JYx2pRZjbsFqL38+pHHnazWSLFva
   vtfaOed3BfFiuo6+Y9resep1oMBPg/P6h1YLHBQ0FhL2WJJAdTuNEDvqE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="456587349"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="456587349"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 15:21:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="767157704"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="767157704"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 15:21:19 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 15:21:18 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 15:21:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 15:21:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2i6lLEd5OlKkG+oHwuF5mMY4YBWuA5xwPerIbQSCQG9T/PQuPhzLOW4BkqLDsBE6ME8QnUgjLpg+PafCHkbPB1LKVRdnuH0yST2yIcYhPTACXjWh9uxmu+VqlQDYHzXfcKZkFAlVbymGPoOHoFCCPaW9K6KxyeTheI6uQhSMR2CGF+b1sJGabUCoXQMx0SkKFrTiXKwnm33F/qel4zLJp7TIEAC46sEX0FV9B4CIn1LE0B7oikR2q+k8gsSY1Bprsi0GYFWZ2/ku6t9UtT5TUq+Hxm3XO5MQiNWGnTRgG43thxvPO0ezFkNVwC+i+J8yMgXxGVheoZYBcoju/DioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fzs/1m5nn3ZUu6ke01FXE8kDR8jfZu1uX9LHn5+/Pa0=;
 b=Ku6Bc/NwIE17etyw8Dc4zDHGWozu9LmNiIUnu1OynbrpNnjtWcf5d8cq0d/ZlJY1+il3qdBoMXBxyRZ9pIl5L5CJU6BZO+EtiKlud0DCT7fvdAquMUXoEMHfPXF3qmdnEcdRLokzi3ZsGOvZL7lVkOKOmq4j08Igz19926GlopNHdwt4XUNEYx55EprL5Xr5Y2wGCBzcPcf0CnbFLIL1YiODk6thETG5DCxe0Xa4pebRhBbWBeAEyG4IJujyQCMRkR/ONis3s+vdthrVvVtPccsQHs8FeqDvYDstxhqWv5w0zNjANHwKCSlNjtE1U40wFKZlDn6jifkABN3+2vwjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CO1PR11MB5188.namprd11.prod.outlook.com (2603:10b6:303:95::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.19; Thu, 9 Nov 2023 23:21:11 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 23:21:11 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Michalik, Michal" <michal.michalik@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 3/3] dpll: fix register pin with unregistered parent
 pin
Thread-Topic: [PATCH net 3/3] dpll: fix register pin with unregistered parent
 pin
Thread-Index: AQHaEi9R20w3ZLh/s0yEUYAIdOH3G7BwhkSAgAE6GCCAABIKAIAAOifwgAA9V4CAAFdrsA==
Date: Thu, 9 Nov 2023 23:21:11 +0000
Message-ID: <DM6PR11MB465763E8D261CEC6B215358C9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-4-arkadiusz.kubalewski@intel.com>
 <ZUukPbTCww26jltC@nanopsycho>
 <DM6PR11MB46572BD8C43DACA0FF15C2CF9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <8b6e3211-3f03-4c17-b0cb-26175bf42213@linux.dev>
 <DM6PR11MB4657C6C1B094DD7B429A22469BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU0fFz+GTdqjA7RD@nanopsycho>
In-Reply-To: <ZU0fFz+GTdqjA7RD@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CO1PR11MB5188:EE_
x-ms-office365-filtering-correlation-id: 217c9845-0faa-4e6a-fbd6-08dbe17a8f9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OmyNObhEoPcOlnP+F2TYUDmJP5z/7VZUL8DZjtae8hxHOw6Rg5oiD2iY/UBSkN4uIWw6xBLmwDahO2RyPK2f2UVMtc0aEeUEHAZ9o2xzcqZZesyfi9JaRMSc/73qGYiJXJ9o8vsInQcxnIQ5Aci64m0Le77eGBoNhyPsFC8SBnagdBNuy+/Mbap0cWl2Jl89bcG8yZU6BgxNan0icoonWOVQ7bvZljZej0kbW9jyYwORBUhhigD4sG4ipmXm4JDE03xBjKVaxg1fFnIV3J6v1OtE/OKD48u/W2GmmLQ1LSiKuYoes0sduxczRZXlcg6Xplr1ENDiXFXWD2zFlpvBsArBFmW0GU4CMcswrBals/xcthF4x+32lRqgVHR6bXO1B7iCL98dsIshUL67uDhM88D3+OmGQPXb4M7iCBj6aVhZCmupM+myL15hcoG3LimYmIYatE//EL4JI97o5ILADv8LWg4liBaVWlMO+QTRNRunhMGZmgkPOkMTZZmaMgo89TbJcG95ro2n5jwFePncSRLd8FYLfCeX/9PuHbCaLFRwgl0pd24IdkEsqhkDHFloS4L3VlHBQDRLgyYKYA707cCPEQxxy8TZDlERq6Ffp3Z/pzJor+tMLJUAja9fgPgT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6506007)(7696005)(83380400001)(8936002)(8676002)(4326008)(9686003)(6916009)(55016003)(64756008)(316002)(52536014)(54906003)(76116006)(26005)(66446008)(478600001)(66476007)(66946007)(66556008)(71200400001)(5660300002)(38100700002)(41300700001)(122000001)(82960400001)(2906002)(33656002)(38070700009)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C0TsoaEtGb9Vrsj4Z63C7ln/9twjHIaOGjS9t18d8wwKiHA7jnBPv6jTaLr2?=
 =?us-ascii?Q?cuyg+nRWGpes79Is/h7TeA2sChaFoj6yxEG8rIwHaXySIApHvFar4nrmuNmm?=
 =?us-ascii?Q?Oc5sJvpzmvEMFBp22MWjNTx3Bp49EQ20MXw3wU5KvLW9ktjdUTwdoBGuGEH9?=
 =?us-ascii?Q?pUwpsoSWEaSQqV/F9oiYujEfx+79l85Guev1ZC+5/deAUG4M+7of8wSCMSLi?=
 =?us-ascii?Q?eKq7v7tqCTOESC/NyZe1Ld0I+lIq+Lwr6l2udtSAbaOrAwY+CckK/whBmWq+?=
 =?us-ascii?Q?m/xq85iyaLiearq5MYOGA/ObMExH7vTAowu9SljyQ3p80MlqJV9K8oSAQ5EA?=
 =?us-ascii?Q?B5em3rZP3fz36Nko+NLri/7EMwgvUnv2x8I9Z8nGMgxgSYnnrRoFFQNNpDsI?=
 =?us-ascii?Q?Mdv9iddasZOQguQ28Y4PhGoqmarDBmIi4El3M1Hsv103cGXhCWFhZxQKSVId?=
 =?us-ascii?Q?BvDt0+chPCtcKTS8aQ3nGCmdWuxTblR3KzWJIqYEtN0yEC96NsW4yQv2tzy7?=
 =?us-ascii?Q?W12EwFG+Mr2MgRT7vbYbhB69R0W0vupvttq4P7YKEuqUbHTvCxVNn+R90z9I?=
 =?us-ascii?Q?jEcsTyEQbB7FqeHUX9WTeL+BSi3DG2cxquecV4hbKEAIdLaXhO7t+DtIFvcS?=
 =?us-ascii?Q?bB6jJNbnd9bBfrjrPVZIo5vOhrYwTcUSgUKJNMEh3sUNKXwdF25pi1VJ+hi1?=
 =?us-ascii?Q?LgBa4HP/We7WRGLKW7cfDb73baIRlIUb3BJOkQyps5PDq55W2BjNKcWaCjkm?=
 =?us-ascii?Q?qBp9fgTOY/8SECoxd+fAvDp/jMciIVwHzsd4lT17kh412L/MJb7oXVEgzbql?=
 =?us-ascii?Q?ZCEp/x1i9bvpilavs8jgEImPXCBm4Vw3tNLqfXBajS/YQmuDpEjZKcwXbwfT?=
 =?us-ascii?Q?7qAAQmYAEHORIQlpN/Q9mk3hPkMGTF5rszPqWFIQWgJuibR1AevcCbvHORra?=
 =?us-ascii?Q?XO0+7TEg6FX6nFmZrQ2G9/5xeqcEJBiSLCF09kFSvMIRpBDmMXluFabX/Pd+?=
 =?us-ascii?Q?WogZFAH8xjgGxcH/CdP6E++kO1NSL5L55LW7FIKWNiIKT2QokVrny5l756PA?=
 =?us-ascii?Q?fBe0fnCY6oRJ2vC9lufhEuGSjy5WjCslgIDgkDNExqZpYN93MF9xyT1XIoVI?=
 =?us-ascii?Q?BzLgfShnwK93ca0sPSP4pCCFGf4eXDyVXsm3nrQaU5ynYL10s4wTHsK2cSg8?=
 =?us-ascii?Q?6aIMP+POHNnDQ78zCEqfONGjRsKJTv1LHL+B+VCXLOyphqEa2xOFv+SHVmJV?=
 =?us-ascii?Q?OTaYQhnoIM7QRyba7wRrHUfnlm5It0666bgyG7+qvG3kxfEi49ROfY0w4wNs?=
 =?us-ascii?Q?xLZMRIkREz8LeA96GCweND0F1nK/tPZeWvGhYphAX0w0z3UV3txFvU+5xaeg?=
 =?us-ascii?Q?2VKfYpKskstU6l1YyxbDYuzJxLsGADx7+NS/nXHjQn19naUtpNkoicbbY4/9?=
 =?us-ascii?Q?JxP8s1h61sHFb6lNYSvWAwj6ri3eI24vZO9xPflB5oCOqfyZsxRTlMDelnd1?=
 =?us-ascii?Q?+friFN05kLSjRI/GWlHPnaRSO9BCZMITlVRrJllKvV39MK51EM2X6MHCRzAW?=
 =?us-ascii?Q?5jS5J2CL695FTrA+uywRMoyd5tGKdrPm0Uc3Jjikd/WpQqqWewuYO0sGFI3v?=
 =?us-ascii?Q?Nw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 217c9845-0faa-4e6a-fbd6-08dbe17a8f9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 23:21:11.4648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 989quDHTVGTNtJ9TYWyk+8DXbML5NwJ+KWwCayaDYjK9Q6Gog8rsChAhhMefsPODzcdetM6gOr/9LWoPLzY3dFNQaS0F7XLuWjgUcyVPSRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5188
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, November 9, 2023 7:04 PM
>
>Thu, Nov 09, 2023 at 05:02:48PM CET, arkadiusz.kubalewski@intel.com wrote:
>>>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>Sent: Thursday, November 9, 2023 11:56 AM
>>>To: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Jiri Pirko
>>>
>>>On 09/11/2023 09:59, Kubalewski, Arkadiusz wrote:
>>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>>> Sent: Wednesday, November 8, 2023 4:08 PM
>>>>>
>>>>> Wed, Nov 08, 2023 at 11:32:26AM CET, arkadiusz.kubalewski@intel.com
>>>>> wrote:
>>>>>> In case of multiple kernel module instances using the same dpll
>>>>>>device:
>>>>>> if only one registers dpll device, then only that one can register
>>>>>
>>>>> They why you don't register in multiple instances? See mlx5 for a
>>>>> reference.
>>>>>
>>>>
>>>> Every registration requires ops, but for our case only PF0 is able to
>>>> control dpll pins and device, thus only this can provide ops.
>>>> Basically without PF0, dpll is not able to be controlled, as well
>>>> as directly connected pins.
>>>>
>>>But why do you need other pins then, if FP0 doesn't exist?
>>>
>>
>>In general we don't need them at that point, but this is a corner case,
>>where users for some reason decided to unbind PF 0, and I treat this stat=
e
>>as temporary, where dpll/pins controllability is temporarily broken.
>
>So resolve this broken situation internally in the driver, registering
>things only in case PF0 is present. Some simple notification infra would
>do. Don't drag this into the subsystem internals.
>

Thanks for your feedback, but this is already wrong advice.

Our HW/FW is designed in different way than yours, it doesn't mean it is wr=
ong.
As you might recall from our sync meetings, the dpll subsystem is to unify
approaches and reduce the code in the drivers, where your advice is exactly
opposite, suggested fix would require to implement extra synchronization of=
 the
dpll and pin registration state between driver instances, most probably wit=
h
use of additional modules like aux-bus or something similar, which was from=
 the
very beginning something we tried to avoid.
Only ice uses the infrastructure of muxed pins, and this is broken as it
doesn't allow unbind the driver which have registered dpll and pins without
crashing the kernel, so a fix is required in dpll subsystem, not in the dri=
ver.

Thank you!
Arkadiusz

>
>>
>>The dpll at that point is not registered, all the direct pins are also
>>not registered, thus not available to the users.
>>
>>When I do dump at that point there are still 3 pins present, one for each
>>PF, although they are all zombies - no parents as their parent pins are
>>not
>>registered (as the other patch [1/3] prevents dump of pin parent if the
>>parent is not registered). Maybe we can remove the REGISTERED mark for al=
l
>>the muxed pins, if all their parents have been unregistered, so they won'=
t
>>be visible to the user at all. Will try to POC that.
>>
>>>>>
>>>>>> directly connected pins with a dpll device. If unregistered parent
>>>>>> determines if the muxed pin can be register with it or not, it force=
s
>>>>>> serialized driver load order - first the driver instance which
>>>>>> registers the direct pins needs to be loaded, then the other
>>>>>> instances
>>>>>> could register muxed type pins.
>>>>>>
>>>>>> Allow registration of a pin with a parent even if the parent was not
>>>>>> yet registered, thus allow ability for unserialized driver instance
>>>>>
>>>>> Weird.
>>>>>
>>>>
>>>> Yeah, this is issue only for MUX/parent pin part, couldn't find better
>>>> way, but it doesn't seem to break things around..
>>>>
>>>
>>>I just wonder how do you see the registration procedure? How can parent
>>>pin exist if it's not registered? I believe you cannot get it through
>>>DPLL API, then the only possible way is to create it within the same
>>>driver code, which can be simply re-arranged. Am I wrong here?
>>>
>>
>>By "parent exist" I mean the parent pin exist in the dpll subsystem
>>(allocated on pins xa), but it doesn't mean it is available to the users,
>>as it might not be registered with a dpll device.
>>
>>We have this 2 step init approach:
>>1. dpll_pin_get(..) -> allocate new pin or increase reference if exist
>>2.1. dpll_pin_register(..) -> register with a dpll device
>>2.2. dpll_pin_on_pin_register -> register with a parent pin
>>
>>Basically:
>>- PF 0 does 1 & 2.1 for all the direct inputs, and steps: 1 & 2.2 for its
>>  recovery clock pin,
>>- other PF's only do step 1 for the direct input pins (as they must get
>>  reference to those in order to register recovery clock pin with them),
>>  and steps: 1 & 2.2 for their recovery clock pin.
>>
>>
>>Thank you!
>>Arkadiusz
>>
>>>> Thank you!
>>>> Arkadiusz
>>>>
>>>>>
>>>>>> load order.
>>>>>> Do not WARN_ON notification for unregistered pin, which can be
>>>>>> invoked
>>>>>> for described case, instead just return error.
>>>>>>
>>>>>> Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions"=
)
>>>>>> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base
>>>>>> functions")
>>>>>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>>> ---
>>>>>> drivers/dpll/dpll_core.c    | 4 ----
>>>>>> drivers/dpll/dpll_netlink.c | 2 +-
>>>>>> 2 files changed, 1 insertion(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>>>> index
>>>>>> 4077b562ba3b..ae884b92d68c 100644
>>>>>> --- a/drivers/dpll/dpll_core.c
>>>>>> +++ b/drivers/dpll/dpll_core.c
>>>>>> @@ -28,8 +28,6 @@ static u32 dpll_xa_id;
>>>>>> 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id,
>>>>>> DPLL_REGISTERED))
>>>>>> #define ASSERT_DPLL_NOT_REGISTERED(d)	\
>>>>>> 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id,
>>>>>> DPLL_REGISTERED))
>>>>>> -#define ASSERT_PIN_REGISTERED(p)	\
>>>>>> -	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id,
>>>>>> DPLL_REGISTERED))
>>>>>>
>>>>>> struct dpll_device_registration {
>>>>>> 	struct list_head list;
>>>>>> @@ -641,8 +639,6 @@ int dpll_pin_on_pin_register(struct dpll_pin
>>>>>> *parent,
>>>>>> struct dpll_pin *pin,
>>>>>> 	    WARN_ON(!ops->state_on_pin_get) ||
>>>>>> 	    WARN_ON(!ops->direction_get))
>>>>>> 		return -EINVAL;
>>>>>> -	if (ASSERT_PIN_REGISTERED(parent))
>>>>>> -		return -EINVAL;
>>>>>>
>>>>>> 	mutex_lock(&dpll_lock);
>>>>>> 	ret =3D dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops,
>>>>>> priv); diff
>>>>>> --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>>>>> index
>>>>>> 963bbbbe6660..ff430f43304f 100644
>>>>>> --- a/drivers/dpll/dpll_netlink.c
>>>>>> +++ b/drivers/dpll/dpll_netlink.c
>>>>>> @@ -558,7 +558,7 @@ dpll_pin_event_send(enum dpll_cmd event, struct
>>>>>> dpll_pin *pin)
>>>>>> 	int ret =3D -ENOMEM;
>>>>>> 	void *hdr;
>>>>>>
>>>>>> -	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id,
>>>>>> DPLL_REGISTERED)))
>>>>>> +	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>>>>>> 		return -ENODEV;
>>>>>>
>>>>>> 	msg =3D genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>>>>>> --
>>>>>> 2.38.1
>>>>>>
>>>
>>

