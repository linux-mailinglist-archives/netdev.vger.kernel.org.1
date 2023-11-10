Return-Path: <netdev+bounces-47086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B217E7E7BC3
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 12:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7D51C203DF
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4606214AAE;
	Fri, 10 Nov 2023 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmGPCHlh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF9314F79
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 11:19:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61FC2E5F0
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 03:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699615188; x=1731151188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f6W4UL/C1lU/5TmfHH9kROHb/hIpimjJDaFImxLBEr0=;
  b=VmGPCHlhqRGpuGw0iVZq7lauNpCRw0OQCRqkWa6j0EpacbDiaCrORUSW
   rf4RCcoSwtujIaiUdAv6ap0n3ssaabIz5rS/f1f9hkg8lCXCyTqWa4D6l
   J1WwyvncHRrn6OiHrkmFPoMXf1TikKFQ5hQuBMKlLIuvAQyDaj7U0EoCB
   sVKGgJCzZw7xtGsyjLMPABY3ULaJpIqDPY6yOY1c6MJ7QSQELyRf+2PU/
   ebs5w7pETk9WMi8bRTMt50p9qKKNAom81d+F95aFOu4KaNrn5xsr8GbUK
   9JNIi9VhEdbacCFwUKFyttKTkVgSOA4ZiA53NeJbkQSdmXbqyteNzsk/Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="387333713"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="387333713"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 03:19:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="792839674"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="792839674"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2023 03:19:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 03:19:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 03:19:43 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 03:19:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQt+n8ATihe4/iMoV6cX4aK8MEEXKOFQ0ygW7kK5vLMQPizfwYp9q0htz5PFkiJw8afKEsvWyvVh0See9D34VtGWqI/V92sFkA859MBx0qmJeg0p4IqVzHIFjP4KYa1nBvB51jQuU38f+Rf0MDabY7J5+xU3L8gb4yAya1tlvjrGt0dipc5CctxgtlZegSSntxCpJ/KR/GD+IZdVxJOAyz4KHLA/wgrDH7PrQA42UO5SNZVAJNK7PA2+U5b52gyp04YcPCs4L8E+jkAuebNSKRj95/0qL4IaxhCqjehLRWF0C1fwdpMa7otDu1RHdh5yENS76E3KUwjBricg7NY6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVrVkCsaZqAKTlqUlqWFuV+ACw8N/2hexiZvndnoNUQ=;
 b=TjV5ul18aIMfE24ZFo4jMQ+9JNBkB7dumvW+MaDDCJbzWbBVcIZ4Q/CEYfFlDix5NPyjvjp2wuiIbwwwkwZji+TBzTlEgDeAV5iwkhog1BW1c8KE6+oUfA1aTs1ymvMPDwyEUnZypf5EHcMuV1beFcTq9SY7r3t7pxsvdERXbpscgVA10+tcpLShKq5SRH/MAqGLZDgRq3a1JoPE5f5wJG+Lf245eabfX3NDK51SWX4dWF5A73SprqZLlI7xe4TFOAiLXkNiaBOqZPeSfLHrDIzYc0FhVgUutceV+zCmVmqBUcr5exHddjXI8w4BlxT4YMHW/bMnHheuk6GvLJDTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DM4PR11MB6119.namprd11.prod.outlook.com (2603:10b6:8:b0::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.29; Fri, 10 Nov 2023 11:19:41 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 11:19:41 +0000
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
Thread-Index: AQHaEi9R20w3ZLh/s0yEUYAIdOH3G7BwhkSAgAE6GCCAABIKAIAAOifwgAA9V4CAAFdrsIAAfgiAgAAfzpCAABfZAIAAERgA
Date: Fri, 10 Nov 2023 11:19:41 +0000
Message-ID: <DM6PR11MB465732D702870D69F6B1F3EB9BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-4-arkadiusz.kubalewski@intel.com>
 <ZUukPbTCww26jltC@nanopsycho>
 <DM6PR11MB46572BD8C43DACA0FF15C2CF9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <8b6e3211-3f03-4c17-b0cb-26175bf42213@linux.dev>
 <DM6PR11MB4657C6C1B094DD7B429A22469BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU0fFz+GTdqjA7RD@nanopsycho>
 <DM6PR11MB465763E8D261CEC6B215358C9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU3SJdlOwoFOEavA@nanopsycho>
 <DM6PR11MB465767D550C3DF2CE24E70EA9BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU4A1FG0+JgVz3HF@nanopsycho>
In-Reply-To: <ZU4A1FG0+JgVz3HF@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DM4PR11MB6119:EE_
x-ms-office365-filtering-correlation-id: 0f664251-6b5d-46d1-12b3-08dbe1deef68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8hzzjjydcDPNrH9DDF3Ov5Rf917HY80nuWBjpumkGkd/odBEiVSymN9iaBhPWolNXTn6ciQ1LD1MJErMapCr+g1L7Ex6I6ftRGvl7bRY2yRH5e7jIGsJ97pUqceDae9fFF5+xkU8SdySJeNW6Uwv2CxRXunX228UkIZofhkV/xM1eSDmdYdXXfoRSmyxuRrnIK78zhBXOHOgFNjJ6Fq2xPIyWAcNRwnCvypmmd+P/eunKItvlLWvlrpI149l2MuDpOmq5uKyR311Ov5J4yKMyBD83ASSjySdIfa/mikzSti5QzvR8XS40fdPCWcIBIyFeOBLEC7vbN2a4qhWbbo7lHI+YIwecX8jyFVXdbsHETQyFz2q1kcfDBu0tCx2ps7iyjM2WNOOHsG5mEP7iV3K9Me0Sj2OliCrtiRQR0O2pmH6eXQyDjHic1KEnyjhhCysj6wpIjUhAaNp07P3yB5pY1OQH4lyav+d70G6xwPQRrNQAhyHD3zuNyXQGDwCu+tE2gOh64aAUJTA2gBEYk9wk4VwHfeLw+s6kulHo3t4H0SPeo5Hnsr2Jg7Hd/LgPHVxIShk1igoyxsMSQW6EebfR3Z6FZVR6ycABIV+7tQDatevQW/IYim6YJkfAgcdSC6z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(26005)(55016003)(9686003)(83380400001)(478600001)(6506007)(7696005)(316002)(4326008)(66446008)(66556008)(6916009)(2906002)(76116006)(66946007)(66476007)(64756008)(86362001)(54906003)(122000001)(41300700001)(71200400001)(8676002)(5660300002)(52536014)(38100700002)(38070700009)(8936002)(82960400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YnzjNgJWYiOXkcH4eY0wZ+t8vG8x+HCt8oh6xpC/lDfga7aoRDB3NosJz9Dd?=
 =?us-ascii?Q?abeDhSGcdmEWyaxqmtDNPV8GsWIVzFy8qcuExAYvMZrpcC4sVUWkhz382jIA?=
 =?us-ascii?Q?bilGMMe0VCXBzhz3q2cNju8plfa3cpdWVHNfEciOZht4yQa+h0pzKfn3vFoL?=
 =?us-ascii?Q?9617d0oeAwDOrPmE41UCULMh21bNK1QwCf0uzcuGRX3pJ5vfGQ9OLe02h12C?=
 =?us-ascii?Q?P4u3ZVXTs0Z4PnP7YF/gwfczqwDBhvzUnmk7Ku/XDp+R+B/VrDmQh7ZF1hjI?=
 =?us-ascii?Q?xmYEoInnXr1yk6ibKmFAxS54liRxH1TCo0Qeg7Tgn96B9VhNdpJJ9jczGbKs?=
 =?us-ascii?Q?3w0Bg1FEY4YxgPnCY8knGFEysfLEHxcDe05tzBlaSSMkRi6XpXn9beF63bSd?=
 =?us-ascii?Q?suRGmmeLRKktfW0W6e/SenYDho18f++6RmUJssPFdZU1wa4SjhLhE4YU8dz3?=
 =?us-ascii?Q?Fbi34CZjDxIalvLwgU/EpAZE084qHMHjaB9GDKw6vvXnjc1O5F3XuSJn4zmG?=
 =?us-ascii?Q?KlB+IHSjNACB2YP0ifKvLTisNnYmLJ+07wWaoh626ncppdn5/7W3LsRzvQqu?=
 =?us-ascii?Q?vpRUOUKuWJnKsW9+PWXGyOkmuT3QUD37BuPlfKIFBg3E3pZFwUjzXSiQrYKI?=
 =?us-ascii?Q?ruhb5jsAvJzsLDO5F12qyarwg5roOIT9NUtZ6AGbVAqZsf0+5fxxtQuYYmYz?=
 =?us-ascii?Q?jQe9b+vLI96d3PjYryDlhg3YM2n5aYLE9PbEWiI6J86MweRd4qhv6ETL316R?=
 =?us-ascii?Q?5ZTEs3sgZEHIyz1BPmaYBsD8NBUoOn5vs2/CYD21ASa2Q+2qaoxQCaAIM7aq?=
 =?us-ascii?Q?sdBzKa2KJc/7JnKKOMhB7zWeRywiwCdqvRiI1RLpe+ZhImHmGivnyQGUBpIn?=
 =?us-ascii?Q?ZXk6+3I1bdc8ZmqGXe5/JJln+D7/TfZ0RdoTluLknqfa98UuptKqrTTqbZJp?=
 =?us-ascii?Q?M01GgwePS7PTRA17AKjTUH6v84y5bIrPxFXJtY6ZV45kvXgCGxZ4sqk4f4NQ?=
 =?us-ascii?Q?xrW1oGuIjJQgFhi9EwOR9DjCEIYLrP+2I7i5HJWOYrH/BpDQtDMISi7Ts2oX?=
 =?us-ascii?Q?/33zp+/eFJelC6XdLwCyIB2znDOGUQzGziuIPDmqcqRN/JGU8cPp5ByLslyE?=
 =?us-ascii?Q?to0PFTsckviNCYUSE8AMdalA7BW3/qmVuFA+Fau16pwv6cwLtpLNYltMbB6c?=
 =?us-ascii?Q?pCrAjndswHuS3YI/sZB8EnEQRojdrnnX2Yqo4CaGkv8IrEoX1UoZxbvdKYBm?=
 =?us-ascii?Q?LwArwhoYA+FDSRFdJO1t1Q65mGGqk+yAyE3J2NUAKuhiR9GgAmvTyDOKf0/y?=
 =?us-ascii?Q?SI8Rr9iV+MdQjNGn3RJtQmHP/u2Fx+p1961Bs5TRGFmcdM9T2gzw8ES1cyCe?=
 =?us-ascii?Q?KgqOe0HfSkxxZp8lXBfZOi4APNU56eaZB3kzN8bv3xVYtv1xxPjeIBXKYUB1?=
 =?us-ascii?Q?K1fxA+9FC5ofxJtfCPnSZNEmc5Pu6xQ6SmcAsSDQWYz4zhNOXwsmMeUqPwN3?=
 =?us-ascii?Q?7aILHpdsyAQNrh8EDmAvHPo0+/YkEKI03ne0KYLH7hK70jDBMPCiUU3BFIpW?=
 =?us-ascii?Q?c2OJWmvmPLegFgjtWRT0sFuxbCTOWDa4vySNnop1o6oGJWvqzIyTLxPDM8la?=
 =?us-ascii?Q?cQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f664251-6b5d-46d1-12b3-08dbe1deef68
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 11:19:41.8555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YXzbuBi+F8LeOuN6w+lYlkwwUftZ5vWCGnllEzK5UduWAsM57USfh3tfy3DowDeG8V0HOYT6mXKzrGUfVlnHLt/14Wng4QMRvFP0fDsj/jE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6119
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, November 10, 2023 11:07 AM
>
>Fri, Nov 10, 2023 at 09:50:34AM CET, arkadiusz.kubalewski@intel.com wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Friday, November 10, 2023 7:48 AM
>>>
>>>Fri, Nov 10, 2023 at 12:21:11AM CET, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Thursday, November 9, 2023 7:04 PM
>>>>>
>>>>>Thu, Nov 09, 2023 at 05:02:48PM CET, arkadiusz.kubalewski@intel.com
>>>>>wrote:
>>>>>>>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>>>>>Sent: Thursday, November 9, 2023 11:56 AM
>>>>>>>To: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Jiri
>>>>>>>Pirko
>>>>>>>
>>>>>>>On 09/11/2023 09:59, Kubalewski, Arkadiusz wrote:
>>>>>>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>> Sent: Wednesday, November 8, 2023 4:08 PM
>>>>>>>>>
>>>>>>>>> Wed, Nov 08, 2023 at 11:32:26AM CET,
>>>>>>>>>arkadiusz.kubalewski@intel.com
>>>>>>>>> wrote:
>>>>>>>>>> In case of multiple kernel module instances using the same dpll
>>>>>>>>>>device:
>>>>>>>>>> if only one registers dpll device, then only that one can
>>>>>>>>>>register
>>>>>>>>>
>>>>>>>>> They why you don't register in multiple instances? See mlx5 for a
>>>>>>>>> reference.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Every registration requires ops, but for our case only PF0 is able
>>>>>>>> to
>>>>>>>> control dpll pins and device, thus only this can provide ops.
>>>>>>>> Basically without PF0, dpll is not able to be controlled, as well
>>>>>>>> as directly connected pins.
>>>>>>>>
>>>>>>>But why do you need other pins then, if FP0 doesn't exist?
>>>>>>>
>>>>>>
>>>>>>In general we don't need them at that point, but this is a corner
>>>>>>case,
>>>>>>where users for some reason decided to unbind PF 0, and I treat this
>>>>>>state
>>>>>>as temporary, where dpll/pins controllability is temporarily broken.
>>>>>
>>>>>So resolve this broken situation internally in the driver, registering
>>>>>things only in case PF0 is present. Some simple notification infra
>>>>>would
>>>>>do. Don't drag this into the subsystem internals.
>>>>>
>>>>
>>>>Thanks for your feedback, but this is already wrong advice.
>>>>
>>>>Our HW/FW is designed in different way than yours, it doesn't mean it i=
s
>>>>wrong.
>>>>As you might recall from our sync meetings, the dpll subsystem is to
>>>>unify
>>>>approaches and reduce the code in the drivers, where your advice is
>>>>exactly
>>>
>>>No. Your driver knows when what objects are valid or not. Of a pin of
>>>PF1 is not valid because the "master" PF0 is gone, it is responsibility
>>>of your driver to resolve that. Don't bring this internal dependencies
>>>to the dpll core please, does not make any sense to do so. Thanks!
>>>
>>
>>No, a driver doesn't know it, those are separated instances, and you
>>already
>>suggested to implement special notification bus in the driver.
>>This is not needed and prone for another errors. The dpll subsystem is
>>here to
>>make driver life easier.
>
>See the other thread for my reply.
>

Ok, will do.

Thank you!
Arkadiusz

>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>>opposite, suggested fix would require to implement extra synchronizatio=
n
>>>>of the
>>>>dpll and pin registration state between driver instances, most probably
>>>>with
>>>>use of additional modules like aux-bus or something similar, which was
>>>>from the
>>>>very beginning something we tried to avoid.
>>>>Only ice uses the infrastructure of muxed pins, and this is broken as i=
t
>>>>doesn't allow unbind the driver which have registered dpll and pins
>>>>without
>>>>crashing the kernel, so a fix is required in dpll subsystem, not in the
>>>>driver.
>>>>
>>>>Thank you!
>>>>Arkadiusz
>>>>
>>>>>
>>>>>>
>>>>>>The dpll at that point is not registered, all the direct pins are als=
o
>>>>>>not registered, thus not available to the users.
>>>>>>
>>>>>>When I do dump at that point there are still 3 pins present, one for
>>>>>>each
>>>>>>PF, although they are all zombies - no parents as their parent pins
>>>>>>are
>>>>>>not
>>>>>>registered (as the other patch [1/3] prevents dump of pin parent if
>>>>>>the
>>>>>>parent is not registered). Maybe we can remove the REGISTERED mark fo=
r
>>>>>>all
>>>>>>the muxed pins, if all their parents have been unregistered, so they
>>>>>>won't
>>>>>>be visible to the user at all. Will try to POC that.
>>>>>>
>>>>>>>>>
>>>>>>>>>> directly connected pins with a dpll device. If unregistered
>>>>>>>>>>parent
>>>>>>>>>> determines if the muxed pin can be register with it or not, it
>>>>>>>>>>forces
>>>>>>>>>> serialized driver load order - first the driver instance which
>>>>>>>>>> registers the direct pins needs to be loaded, then the other
>>>>>>>>>> instances
>>>>>>>>>> could register muxed type pins.
>>>>>>>>>>
>>>>>>>>>> Allow registration of a pin with a parent even if the parent was
>>>>>>>>>>not
>>>>>>>>>> yet registered, thus allow ability for unserialized driver
>>>>>>>>>>instance
>>>>>>>>>
>>>>>>>>> Weird.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Yeah, this is issue only for MUX/parent pin part, couldn't find
>>>>>>>>better
>>>>>>>> way, but it doesn't seem to break things around..
>>>>>>>>
>>>>>>>
>>>>>>>I just wonder how do you see the registration procedure? How can
>>>>>>>parent
>>>>>>>pin exist if it's not registered? I believe you cannot get it throug=
h
>>>>>>>DPLL API, then the only possible way is to create it within the same
>>>>>>>driver code, which can be simply re-arranged. Am I wrong here?
>>>>>>>
>>>>>>
>>>>>>By "parent exist" I mean the parent pin exist in the dpll subsystem
>>>>>>(allocated on pins xa), but it doesn't mean it is available to the
>>>>>>users,
>>>>>>as it might not be registered with a dpll device.
>>>>>>
>>>>>>We have this 2 step init approach:
>>>>>>1. dpll_pin_get(..) -> allocate new pin or increase reference if exis=
t
>>>>>>2.1. dpll_pin_register(..) -> register with a dpll device
>>>>>>2.2. dpll_pin_on_pin_register -> register with a parent pin
>>>>>>
>>>>>>Basically:
>>>>>>- PF 0 does 1 & 2.1 for all the direct inputs, and steps: 1 & 2.2 for
>>>>>>its
>>>>>>  recovery clock pin,
>>>>>>- other PF's only do step 1 for the direct input pins (as they must
>>>>>>get
>>>>>>  reference to those in order to register recovery clock pin with
>>>>>>them),
>>>>>>  and steps: 1 & 2.2 for their recovery clock pin.
>>>>>>
>>>>>>
>>>>>>Thank you!
>>>>>>Arkadiusz
>>>>>>
>>>>>>>> Thank you!
>>>>>>>> Arkadiusz
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> load order.
>>>>>>>>>> Do not WARN_ON notification for unregistered pin, which can be
>>>>>>>>>> invoked
>>>>>>>>>> for described case, instead just return error.
>>>>>>>>>>
>>>>>>>>>> Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base
>>>>>>>>>>functions")
>>>>>>>>>> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base
>>>>>>>>>> functions")
>>>>>>>>>> Signed-off-by: Arkadiusz Kubalewski
>>>>>>>>>><arkadiusz.kubalewski@intel.com>
>>>>>>>>>> ---
>>>>>>>>>> drivers/dpll/dpll_core.c    | 4 ----
>>>>>>>>>> drivers/dpll/dpll_netlink.c | 2 +-
>>>>>>>>>> 2 files changed, 1 insertion(+), 5 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>>>>>>>> index
>>>>>>>>>> 4077b562ba3b..ae884b92d68c 100644
>>>>>>>>>> --- a/drivers/dpll/dpll_core.c
>>>>>>>>>> +++ b/drivers/dpll/dpll_core.c
>>>>>>>>>> @@ -28,8 +28,6 @@ static u32 dpll_xa_id;
>>>>>>>>>> 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id,
>>>>>>>>>> DPLL_REGISTERED))
>>>>>>>>>> #define ASSERT_DPLL_NOT_REGISTERED(d)	\
>>>>>>>>>> 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id,
>>>>>>>>>> DPLL_REGISTERED))
>>>>>>>>>> -#define ASSERT_PIN_REGISTERED(p)	\
>>>>>>>>>> -	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id,
>>>>>>>>>> DPLL_REGISTERED))
>>>>>>>>>>
>>>>>>>>>> struct dpll_device_registration {
>>>>>>>>>> 	struct list_head list;
>>>>>>>>>> @@ -641,8 +639,6 @@ int dpll_pin_on_pin_register(struct dpll_pin
>>>>>>>>>> *parent,
>>>>>>>>>> struct dpll_pin *pin,
>>>>>>>>>> 	    WARN_ON(!ops->state_on_pin_get) ||
>>>>>>>>>> 	    WARN_ON(!ops->direction_get))
>>>>>>>>>> 		return -EINVAL;
>>>>>>>>>> -	if (ASSERT_PIN_REGISTERED(parent))
>>>>>>>>>> -		return -EINVAL;
>>>>>>>>>>
>>>>>>>>>> 	mutex_lock(&dpll_lock);
>>>>>>>>>> 	ret =3D dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops,
>>>>>>>>>> priv); diff
>>>>>>>>>> --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.=
c
>>>>>>>>>> index
>>>>>>>>>> 963bbbbe6660..ff430f43304f 100644
>>>>>>>>>> --- a/drivers/dpll/dpll_netlink.c
>>>>>>>>>> +++ b/drivers/dpll/dpll_netlink.c
>>>>>>>>>> @@ -558,7 +558,7 @@ dpll_pin_event_send(enum dpll_cmd event,
>>>>>>>>>>struct
>>>>>>>>>> dpll_pin *pin)
>>>>>>>>>> 	int ret =3D -ENOMEM;
>>>>>>>>>> 	void *hdr;
>>>>>>>>>>
>>>>>>>>>> -	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id,
>>>>>>>>>> DPLL_REGISTERED)))
>>>>>>>>>> +	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>>>>>>>>>> 		return -ENODEV;
>>>>>>>>>>
>>>>>>>>>> 	msg =3D genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>>>>>>>>>> --
>>>>>>>>>> 2.38.1
>>>>>>>>>>
>>>>>>>
>>>>>>


