Return-Path: <netdev+bounces-39845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A117C49C2
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0094F1C20A71
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 06:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EDC10956;
	Wed, 11 Oct 2023 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVCpB8so"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE1101CF
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:14:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37029B
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697004873; x=1728540873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qSYlffos6gN1M/T+1y5CIwomo7fCAwxf/0p8oRe2tA8=;
  b=DVCpB8soDPpkopMBkWygZCIwt5wKGgoybt18sXmYEIIDD5h1xAuJQSPU
   wGani4z7fRFGciEC5hNQX8ZBsp7WOdeCWWQGI2sDK39HagXLhCYXCyo8Z
   YBHe7+qWeWTbM1a8v+VjJSyKE9uZfPsYIhNUFlYozKRHwXB4m0SJUSNuL
   3UuXAvaZeQYBrC9TRtlyBDxoKkAndc60MwjCK5sbB/mNugWMDlujnKx2V
   wQfiOpF43YaaSrmWNYGT1Oi5Clh0tu/mE2QF6K9qpnsTWlwLuTYPy5CQ9
   IATOGV3PcjcTUs+rXUBUSBOh+vUj6OLT9LuqJn7oqBR0GlnUKFRxYC3rn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387431307"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387431307"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 23:14:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="844436289"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="844436289"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 23:13:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 23:13:57 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 23:13:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 23:13:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 23:13:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWSxMchSDHn8yLFxaPor5M+2ZFFW8m+MajS7n5EVY7jhvlYNQ14geUFtbDi4AY2gQqNRzmZcIjG7kt7xsqu0S9xj2njwomlvDzFu53Je7lv3FTyKksfjPmPmw9uRkJYkmzVDtUeL6NdN8Vj3JzerukX5ay0zNJ7yHnAKPuJmyJ15MZ7tMg94AbrQcmpvSPGo79vvXDSDeE7UJ1s4hOBUH7EFdbMP31Dr1Wcl4vLN5MOirVJwr4Sw5Zv9tzAcc6HaNHZIfBjmV9HA0ZYlPZivWWVAJGOhu9vHbFoAL4hMjgy7r9zW/9GVGXe148Z3hx/00UuzTFRQlT05I2VDYkyIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+/kqGITcWM1iA2/Tety9uDhsi+4J9Le7wHKx6bXprs=;
 b=m/pvjVO5xVNjpTT1FKIIX6q6Aghlao6VaWWa6xZxIkYtBlIn2P170xspW+a4pcC1uRGX5LWdjLooBXb0grg8RavqXyFTwmB7O4FUKNaG6frFQluJYw4lPHEk5DqnCRky7FPT5JCmc3My4T1ogjQhvLsPrg7gIQBvMgOPj91u53WqEQzGdJJ4Hp737mgAqw0KUI5e7xTIGLNrHWuNoIZB2l2tXUnkXJtnDsX8VitskmCk6H6xaKp+uVHK4MC2WgwcnTg0yF7xuKQZY0iImEKP4JkAboVXQsKj153Vz86Yr5roHM6zRAkABW6DAflMFfAeo+OC2uJLRX+rU8/213O/Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by CYYPR11MB8385.namprd11.prod.outlook.com (2603:10b6:930:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 06:13:54 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8%7]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 06:13:54 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: mschmidt <mschmidt@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: RE: [Intel-wired-lan] [PATCH net] i40e: prevent crash on probe if hw
 registers have invalid values
Thread-Topic: [Intel-wired-lan] [PATCH net] i40e: prevent crash on probe if hw
 registers have invalid values
Thread-Index: AQHZ+EYgMhqHjmSenE+DeU8LNJioj7BEIxHQ
Date: Wed, 11 Oct 2023 06:13:53 +0000
Message-ID: <BL0PR11MB31226FBCF4DC31E9DB149701BDCCA@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231006111139.1560132-1-mschmidt@redhat.com>
In-Reply-To: <20231006111139.1560132-1-mschmidt@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|CYYPR11MB8385:EE_
x-ms-office365-filtering-correlation-id: 61ff29c0-e172-46ed-923b-08dbca213e9c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Row5qaY8d5EIkknJvq3rz0gLS+QV7HkiXcrv91tBmB+xD88d8XQgeMLqTIxV/BOD0MjcV27VeCF2G1g4n7ZNSm6tRa8iSK+sbAwxwkJZMEgkfvEQRpfTx80yItzQOf4jOv9yRwvok/O/F41ZmanIoBPDn4uuQy135U3ISdkSu8yO/O8C8uaHRw1F9s9uwEJfke2oNZhO4h/qiCqnLbFH6wRKXvd1yjj7g63PSjNllQeGsyJI+BytXo/XrIIlTK0mVkzWsvZN/S7xOmny8giSUGvWNcWvqbvilKpTYUSzBCZZaZft/3HshamC1Ie8sgV87T/ruNYjRIaf6Q7gRktFQJi6oUeTBwgJf/NMdOtrMjpVhGw7J9wvzwa4WSt7f++r9SHdG0yrQxRPUVRnQxYE/d/YPCw+QEsItc73ug/Egq0tRlF2XRxORMgjO52ASfZ1BnwSY5xTdeleVwCk0GTscxNcNVzzq/Eip8WSxlmMLvffEUuk7R4MXWkBvVPsZImPZGfi/odgEExFSTB9Zebx/hnGsdpOSGeO6LoizIeZ5ROzhNjPYi4cRF/tHQA7J0wyoa76LrwvXFCNigdRI53kVqzcHA35LVh2UquNzE7X+zI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(71200400001)(53546011)(55236004)(26005)(38070700005)(7696005)(8676002)(5660300002)(8936002)(66446008)(2906002)(4326008)(478600001)(66476007)(66946007)(64756008)(316002)(52536014)(54906003)(6506007)(110136005)(41300700001)(66556008)(55016003)(122000001)(38100700002)(82960400001)(76116006)(86362001)(33656002)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YsO/i+yJqt5z0lXNUPyeQtrSrbpr783GJwStbKIKHmVQRfhLmoETfze7LfrH?=
 =?us-ascii?Q?CxcqfnUa3FrDyR2Q5+43X7NR13z/1wyTknRrytcr4+tP4/InasAXwUsttwI5?=
 =?us-ascii?Q?9L08fOL0JTQ8J5g7z2jeprGgKHmy5aw+GQ87fplz4qzafDa4ZNsS5g19+Clc?=
 =?us-ascii?Q?hLSwXlmfLlpAGxQZ9t0dVk81rk9reQQWpAcRaXPwuz4CNcj2bimmDC1jBBk5?=
 =?us-ascii?Q?nQMpDczk9cbnU4pNkOdA9SsEjNnocgefIO9Z/ejb3n88a5eYiDCMBcDPXTpB?=
 =?us-ascii?Q?BY9eQKNZodDGFXmZtpffxnugS1JZOHmi0ZMF8n9uEaZlmp+uEz2qPyQ2nBVb?=
 =?us-ascii?Q?sFrLk8y7FUuYO4MVeTsqroklENbA9yu1ypgnZUSqzCxddt8B6yMaVvyGJr/q?=
 =?us-ascii?Q?1iIA3uZwROddpj0ASOKFNi15sfQHzGi2lanX3OVAgJgsOFPK5nfc5RLk1P/I?=
 =?us-ascii?Q?AXEEeoYzlg2Usng63CatjjGLvqzn0X0mA1rBNixuI4vFX/1F7714eYNxYDeH?=
 =?us-ascii?Q?yDil57ZSUOFEqG0si23EDJUzd49geIwGcoPSH2/L0HQEaYaAm2PMl6j3YVDf?=
 =?us-ascii?Q?Eif+DrgFphzwJJrc2I5kuIh1aLppDLOrvzH6nRaWMPT2czDwKYG2b+G4a79k?=
 =?us-ascii?Q?q9Bfb3J0fLU0coD+l7puJNZcy31q4p7EcAQREXMwW11sZVRSA68MeugUAi+t?=
 =?us-ascii?Q?Zex5x76Tyh592JXVM5er9CDDabM1+g9xHj2x6Nhz2KUf1D1iAesXj2ImUhTL?=
 =?us-ascii?Q?tg9Y2dlqltiCt7uTsNMvauZBTTMHn/zItYcliFYs80Lxs/fBqF7QLZKxqQFT?=
 =?us-ascii?Q?D5qrRLbr0CjR/++2NnjliyesWmqA8u98SCbNLjDbKSw2ERTzwn2P1rVyrz1t?=
 =?us-ascii?Q?4YcPxTQeYetMtA0vV2b+ITSMwRvdd5MXTvz/Ch6tmfmzrdljpPV2vpa1pxuO?=
 =?us-ascii?Q?TosO5m44C05iMsI5Sp+9ASWgs392vBK5rBxxuKeAQUoeDGiMbwpLnmBXL/hR?=
 =?us-ascii?Q?qkYb1EWAY2G5sSmGUNI0nwGCX6FxLbhWD4XGNDS6bTiEc3UCq9vAlJ/R1w9u?=
 =?us-ascii?Q?8y/rGywDtnNEAvt0guHhraQESH9Ig4iBAfPBSqN7NUckIbGHfwQYaZWi0Q63?=
 =?us-ascii?Q?HzLFzvNo4+CcgyYBJxFFqxmz24v9rKUiFR2DPRGpiRQouP9dvUxiw1nAyxeV?=
 =?us-ascii?Q?Dn67YdO4AuBNQIg0otD3Eqc82gWDJLeTBr4HrAcJRf5ztd5gZjKbaqMRyK3p?=
 =?us-ascii?Q?ts5S8VMr5dNfA68W83OLnDXDuJrK+cet9CYW7X/XTbhUhI43OioFmpPzc5Zh?=
 =?us-ascii?Q?VwCJ8V3/k88fV5OeeqBiYONU4CjW+sTjrAGSIFIegudBwn/0/jtsebterkwq?=
 =?us-ascii?Q?gVRDd6EVV3gbuvE+Vy4wLvEfVLnl1lCO92f0IJ0BWzxDS5NVNmR/Be4YM1io?=
 =?us-ascii?Q?gb4O8cTR+tKTi8rr1YYiDOOdUoyn4VJUM9bAy4mFAt++Ay1jAy3YH/xRrSaq?=
 =?us-ascii?Q?xVehcHyZPeSRPntC+BvL38ea42mbYmkmS7Pw039ti9YdQ3VMHzDicr8Oh7lZ?=
 =?us-ascii?Q?KRZzLJPAZ0sZ9EB92KyPKFPVXvGJwedCMMHq2awLW0v+tUrdZqOQ6JEOO7oD?=
 =?us-ascii?Q?ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ff29c0-e172-46ed-923b-08dbca213e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 06:13:53.5975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XKyaGHWljqGyTuevk3iQSp3152RjQVAPzfPEt5j/1bAIw5QSYk2fRZkJKMB/kxOY/Y1JrNohHJbWZ0Mwq3rz89/+io4ckaXhYr7A7lLkNx9h1VxE6LUO/nO7OP0LY++
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8385
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Schmidt
> Sent: Friday, October 6, 2023 4:42 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Brandeburg, Jesse <jesse.brandeburg@intel.com>; netdev@vger.kernel.or=
g; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Jeff Kirsher <jeffrey.t.=
kirsher@intel.com>; Shannon Nelson <shannon.nelson@amd.com>
> Subject: [Intel-wired-lan] [PATCH net] i40e: prevent crash on probe if hw=
 registers have invalid values
>
> The hardware provides the indexes of the first and the last available
> queue and VF. From the indexes, the driver calculates the numbers of
> queues and VFs. In theory, a faulty device might say the last index is
> smaller than the first index. In that case, the driver's calculation
> would underflow, it would attempt to write to non-existent registers
> outside of the ioremapped range and crash.
>
> I ran into this not by having a faulty device, but by an operator error.
> I accidentally ran a QE test meant for i40e devices on an ice device.
> The test used 'echo i40e > /sys/...ice PCI device.../driver_override',
> bound the driver to the device and crashed in one of the wr32 calls in
> i40e_clear_hw.
>
> Add checks to prevent underflows in the calculations of num_queues and
> num_vfs. With this fix, the wrong device probing reports errors and
> returns a failure without crashing.
>
> Fixes: 838d41d92a90 ("i40e: clear all queues and interrupts")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


