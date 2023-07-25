Return-Path: <netdev+bounces-20804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23E176108E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96B51C20D14
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBCC1EA72;
	Tue, 25 Jul 2023 10:22:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE715AEF
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:22:50 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE0F10CB
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690280569; x=1721816569;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6dCXpZ7ULsY4tRW8anXSXYzxTiiGSCUcqwWKjv2L9Kw=;
  b=UxjA4WYVm4oNT6EY20E8tm6qOBVbcXIID8X+Fs+AN7kJbKkRJq1I4hL4
   jrMpSo/Zo2MNJlmXX2MDfXs6uSZwHinjPCXVFfSRFAVH+Pf/czUZZ6jAN
   8LMuwWc0v58x6ehA0MhZ2Lo2Sw1uNXDeVBUbVLd4oplEk9mikJKLIPy+8
   v42in6GnTkhvV1b1oaNLPRWZSeZWRLzkadtRp4cPn6XEYwGjTp4MYT+hZ
   gb2IUAC4Ok9OfFaCej2wIZUpPcdvb0lhCGAxfB/xnHG7CUv9UiULLt3yW
   8e87OxJU0cPVhlhrlt3GF9SoK+ebmBLWxY74416HS5RF4kS7NFM3cutoI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="433929398"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="433929398"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 03:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="726059404"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="726059404"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 25 Jul 2023 03:22:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 03:22:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 03:22:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 03:22:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 03:22:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAA2F8qlTAPuTw+fEM2DZIQ1s9v8ZnctzZad06dZWTCF3+1PByscVBlJii0Aiz+nGIOG2aHCAaKwCP9SV60JWZdE5Ef5XSdJVOMZBoCeV2qTbnbQT5f45xLGG6y+2gve9Ld3yzGoG7X8Pmc+UsY7D3UTlCV/BCaqjhxsyVrpg+C+3YbHqravb5kF4iXifFS3uibqEr0Hb+WJTNr80etjuk2gZ7qkJVy6Z76NKes0gjlUtETelX+13qt9AiHw8UAW2Mn1Nvr3RsN+hdWIxHKqF9HKrrqJ8+c93eP1F7q/bBLd+Z2imw1iaj55U6MKJ0HXSXGLIhY2RUqv79neJSA3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mj4rP6s4M3lYKq9iKhoy0bd4RNQ3tWyjqqAAuaFv6qE=;
 b=fG6ND4gjXYYX7A7y0a7gVQwtHu2RGKlSVNMkaSXJYnZ2LxaaOip6ksOhe9657h2rAUZZmoseHBI8V51FX2IrTZLdDxUXntOMiTmUKmOUTEp99T1mRgVpPtTxF2gUt47Y2Bz3Ama6UcHVVsL4TBdO0FRD+dv5HkntRpOryNU4Cb8yP0NZQswTIN8Zu6j68xhfmJrcxQPEjzVs7VAjRxEoQloUzs7W4MSY3ZwNBgpL6f8o2M+N93WPm5tiCMiji53GApMJ7xFQc2YkGwTY+JX9xwXVPtD/IHUmErsGJxB7TB64Euwrbv5wTEL8ZuikiQwqlfQGP7rRdHj2+ThdJ5AnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Tue, 25 Jul 2023 10:22:25 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 10:22:25 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>
Subject: RE: [PATCH net-next v4 2/2] tools: ynl-gen: fix parse multi-attr enum
 attribute
Thread-Topic: [PATCH net-next v4 2/2] tools: ynl-gen: fix parse multi-attr
 enum attribute
Thread-Index: AQHZvhl9JcPXX8wVNUCBCseNPwlONa/JfbQAgADJxgA=
Date: Tue, 25 Jul 2023 10:22:25 +0000
Message-ID: <DM6PR11MB46578125CC04E6FAC8A548619B03A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230724102521.259545-1-arkadiusz.kubalewski@intel.com>
	<20230724102521.259545-3-arkadiusz.kubalewski@intel.com>
 <20230724151946.04deb72f@kernel.org>
In-Reply-To: <20230724151946.04deb72f@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|MN6PR11MB8241:EE_
x-ms-office365-filtering-correlation-id: 16c20983-e87e-43f0-5f11-08db8cf90ac1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nRgHxXjb0RnKgzZAJP3RlqnELjxuRWOA7s8l9falIK9sIn+PcJWNtBMc17IPu0osTG7j8aA7SDWv0loULmtmSs/VH3dIUhorEh2yUnurF1j7ThhzmF8Mz6i1t3ZyhIVJot+GTYlR25IH1tSWJFQN53k02F8vhIAq3/I7na34ckUl2YjbYwVQpSSviYxJdQOfb74q3TcnDTDh8/e4gAKTMSw6ZFnbY5n+dSiXyemND1S4R0i8zexHGG0GanXtPQDZYFsC+1bOmLRTHVv7u3czbG0Jbww2XPPezOH8CgGn5U4mltJ389MPbZcDGTwcpA+P5hDLYA3b+5nKcY+43TREIfJX+8gNG+oH9gvuNR2D2EZaaTKBxhHDBfsvEiTJioXElFl2UxXi2QO0czmTGDZ/0xN2XDIFsVGnhKnWEVU1o6nAyJTumVR9TnNNA0nZEsCrbzhzrJR3VFeTYvrBvRjgPbHNP9p75qWMNEW3m6ZGQi3K+3UkTtBZcLO9PScrgcQNWWbvn8Un2Vu8weQySqvNAyfYISZfJw2vM8CoegwvWqBHjmIXtKmUJsoFwVGn6f78geDQU/9b4LgHspQnPUWb/0Jc4zESuHjDtsVaDIe+eOrP7TKFWn4TLBQxhx3hyDhy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(4326008)(2906002)(64756008)(66946007)(76116006)(66476007)(66556008)(66446008)(71200400001)(6916009)(478600001)(7696005)(54906003)(9686003)(86362001)(33656002)(186003)(122000001)(82960400001)(6506007)(38100700002)(38070700005)(55016003)(4744005)(41300700001)(8676002)(8936002)(52536014)(5660300002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kf2bzvYrxToCIxKhk+6zWIipp99blwx8zZVej8/xEIPy9YHvgZlyWk4jlRfI?=
 =?us-ascii?Q?+56PCPw+wtSCI7yvKOsLCKhtNzkyxXSNQiBEsBgMFbDUBKvcZKxTGbHz4Ly0?=
 =?us-ascii?Q?aXY4dyzgQlqyfedUSdlrdoKUAEildbzHuOL4eGjAXMDWK2azzMIhHrFSKD4C?=
 =?us-ascii?Q?ntM4UU+gE1hhe3B2tkzWG91dHIKlUF1H8AJ6YkkriB96ixvU1hHTFkhxRvmD?=
 =?us-ascii?Q?u4qOsbOgAmPraTTSQIWLZgMj3dF52Kw8UssYPK7BplGzU7J4DpQ18oPLMqWk?=
 =?us-ascii?Q?bMWsR7PeR1HjCvB88v1tgRwsuyWzbYXBE77P/91E4MAYPrljQ8y+3++fXBz9?=
 =?us-ascii?Q?2lqWvrRYHoiWIqteVhe1tuiocEGzPAL9l2lAuKx9hUi9O8kTh7erTK7ho5n1?=
 =?us-ascii?Q?Xq2kWJJwS//G9N1R4xmEPlAfEc4jP2qHC1UWpPTU9Hu+1X3jFrG8TL2U8BUI?=
 =?us-ascii?Q?ZS0tdHxQa3d2zLugSX+6Wkx6BEFch1y6ZSu/BV4o6tT+XxL/gAXu2sVOYead?=
 =?us-ascii?Q?It3WQxFsuTWpdFuq0TM0wLkwh8cu6gCbBg0Y/LW6g7pTvJFNLVx9/oMykEU7?=
 =?us-ascii?Q?C5Sfm1zhg+wDRnCCOHD3r/UJyuoAEvXwJUiOswlpoyct4NWOPikjPqv6bp7t?=
 =?us-ascii?Q?YXEni5+prpW/fGcfYleVNvw22YcayHWqZib6CZsKJssFhhks3GdFpSRvOV6F?=
 =?us-ascii?Q?HItlrVDFom8w6H4VQHO3wI4m+NdYbVj25AQPs31evV+aLrUIzO+BY6+eddgq?=
 =?us-ascii?Q?uf/zkdRCmkpEj5OKwCY/l69DjMLdZEGyXU4MEMPhen2v9MebztKmwBVjRTdj?=
 =?us-ascii?Q?w8SKzS45kH5/IIUoHq0C9o07vaapXIIkFy4t+cVciHOG+PhuCY2ymlOsOVh0?=
 =?us-ascii?Q?31vZ1vKmMWav8OxSgQMm/MWR4icRsoXRNAVQSvyxtnvwOVXUNfxYX7aRFqXk?=
 =?us-ascii?Q?l8cFKSjJtG1rbBMmyC7ADX23OoycvHGXgQPPOhp991LoYmMjhe8hSZM3LUY7?=
 =?us-ascii?Q?BQWeGei3K6H68O9uZkZoxMAPWwg/p+LP5i+YjBJFYF7uCPZEYD9TEAiBIA0k?=
 =?us-ascii?Q?Qaf4QZyKJt0q0HljxlquEeEHEe0xr3Afss7dKjScywhPxJytRIdhjLd0Prc0?=
 =?us-ascii?Q?PDBNVXP5G9h2eR/vttU5bmr4qJWABabJzYcgyGDi2Dr8NVBwWJHALwlhUgpE?=
 =?us-ascii?Q?qmPA0lxSfSuaOU1RWllRibd27c+nkVhTE2UQc0nunkrmTm8GXAE9vbzz6KKI?=
 =?us-ascii?Q?k8kWQK91wGMSHfeJqqxg059CfJdIMPsNYLYAv5dVBGLlV5P9tyS4kcKe7eNw?=
 =?us-ascii?Q?2m8IZTO9bkHW09ojp763ffLa+LT74MdJm5QVmvZUjW56eDC2UlXwidMlMUYM?=
 =?us-ascii?Q?yLwo+USDJFwc7vA0ql0MNgmW30cQB2/Vld1If6xAeIJrrQJkKdX06Fuof/dc?=
 =?us-ascii?Q?EpSDJ3Wubbin+toK2YFmGJFGTlvfCaF8umi89DH9jlclhrv1Uu32YQ+dZp59?=
 =?us-ascii?Q?Ak/p3SOZeEPb+ew0SYF0/ZfnKcThvCJdKFEWH04l54r3MiBK25oS0zbGbJw9?=
 =?us-ascii?Q?HB1n3jqKvJCGTKWEwgxnHJyi5j37aLBPawjCwh8YUN2P062D15SXkiaTN6s8?=
 =?us-ascii?Q?AuwdRcUjGI3ahrKpKYV9iRZNRMW3IUwlu+PbnNs03apJaedcREG0MFx+N8+L?=
 =?us-ascii?Q?wMnSBg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c20983-e87e-43f0-5f11-08db8cf90ac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 10:22:25.7919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYaoZDv0S2YQAo/IcfEeFVL2qMn3LAZ+BA53nos87KV/izE/IUA2I+katzBCxLyAIK26drM+6qL8tV+qPDrO3jc6VFE3JfwHL12DyuNNG9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8241
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Tuesday, July 25, 2023 12:20 AM
>
>On Mon, 24 Jul 2023 12:25:21 +0200 Arkadiusz Kubalewski wrote:
>> @@ -438,7 +438,7 @@ class YnlFamily(SpecFamily):
>>              decoded =3D attr.as_struct(members)
>>              for m in members:
>>                  if m.enum:
>> -                    self._decode_enum(decoded, m)
>> +                     decoded[m.name] =3D
>self._decode_enum(decoded[m.name], m)
>
>The indentation looks messed up here, otherwise LGTM.

Yes, fixed in v5.

Thank you!
Arkadiusz

>--
>pw-bot: cr

