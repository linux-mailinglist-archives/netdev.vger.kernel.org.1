Return-Path: <netdev+bounces-48845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D0F7EFB21
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D61B20A9B
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 22:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FB8D2F1;
	Fri, 17 Nov 2023 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6tunp32"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01254D4B
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 14:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700258622; x=1731794622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eE4hJ7PkH5CZ0F3MC2qUnRpatHFJORPZPvwV+0DNM2k=;
  b=J6tunp32h0Qqnsd4Hne0f4FZlpW1htT5kGZeevdgxpCYF5/ncQDTD9T7
   LCMcKq4D57y+BhOwBzjMnc513GnGrIouPdA/B6JowOtrKEBmN6iAlPKjk
   XgX+AOoc6YGfocRUJki7wg88yX1rmwkfRDoQfBfwWEzDZHBLKiYA468i3
   waQfrhKZvdH24yCXru/1PfU/YVgDddwfBLt1oCrIyZSXIv7Hmm75f1vaF
   mP10hfklPUyPwv5wh0VXqYyxZuXlQcrb4rTLaUUMauNQJHLvWJYtWEhlB
   8Fb83Y0E6rMDK1FAvSly10UKg3pMtWUblgdUzEKGUpmoxTCwqs8CPmdIi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="376424730"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="376424730"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 14:03:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="856452435"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="856452435"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 14:03:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 14:03:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 14:03:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 14:03:22 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 14:03:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJPMHla9PeG8KYfDxJdqFACANdnfsX3Y8TTG3RD73yO1KWhgp4nJutjgAkHLM6n09DL5P6sD994END93sAnsWm0aEYeIf/QxM7I7lptyfpnDWip8i8cKWVTF7RO20ROq17Jo4popmUmlPGCRn9XWCJVsUYLdb+JKSfOtn+wxl6ukKVGU2PgFqumgLDVE6NY8Mr2qWHKiP9004ufb5qAdYE/a4+cLF7aBj3fQvCkLQ8XCGYJt8NVmmOtAWCwrRzINe09EVb1i48H74qarig5rbm/cGN1TxTGrLPdBDx3IKxxJ6fZaOgDsQaXdmLo3yKVdO8S+5v8pzHxbqwmr7sIyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMC7CMdETf9R9zSNocNrDTkrx+SnYSTrbApGWh81nS4=;
 b=Oo3Jymg2r2rBDxjAcgejHddxyxAY7fPoovNCxHsQZETLbba6NC1pNUopK06+EK6NV8kFwWmflQOxel2F2vte3r/NN9QKmOxsXNa8clbdvl1tqFGNlQvpvAoDAuPr+J06Boiamf/y7zhkZUrTwrQI4nrjBZBjxYuC/RR5Cop1SV2yNV2YWZ0mnmJyQPQrwrK4Nsl3vggsF8sOwjukuuYl3vFIYMkybSxjz7pv7A7ARZAXejsdSZOACHUXANEjRqx2K46J7CiW8OYtRRdpZ/yJkxQP9W4x87TTgbeyEWEJ7ulDNfzg8noaZ/SJ7DCwqi2fOvWEYsef1ZXZmjXWo9s80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18)
 by MN2PR11MB4758.namprd11.prod.outlook.com (2603:10b6:208:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 22:03:19 +0000
Received: from MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f6f9:943e:b38e:70de]) by MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f6f9:943e:b38e:70de%4]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 22:03:18 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Wyborny, Carolyn" <carolyn.wyborny@intel.com>,
	"daniel.machon@microchip.com" <daniel.machon@microchip.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Buvaneswaran, Sujai"
	<sujai.buvaneswaran@intel.com>
Subject: RE: [PATCH net] ice: Fix VF Reset paths when interface in a failed
 over aggregate
Thread-Topic: [PATCH net] ice: Fix VF Reset paths when interface in a failed
 over aggregate
Thread-Index: AQHaGAh+TuRVRlC/0k+ODV3JK/6fpLB9AIMAgAB1h7CAAVU9gIAABjdQgAA2mYCAAAmjEA==
Date: Fri, 17 Nov 2023 22:03:18 +0000
Message-ID: <MW5PR11MB581140F496EF3F70CCDFC31CDDB7A@MW5PR11MB5811.namprd11.prod.outlook.com>
References: <20231115211242.1747810-1-anthony.l.nguyen@intel.com>
 <ZVYllBDzdLIB97e2@boxer>
 <MW5PR11MB5811FEDAF2D1E3113C3ADCD9DDB0A@MW5PR11MB5811.namprd11.prod.outlook.com>
 <ZVema0m2Pw6+VYTF@boxer>
 <MW5PR11MB5811E4210635755D5D59FE34DDB7A@MW5PR11MB5811.namprd11.prod.outlook.com>
 <10021.1700256111@famine>
In-Reply-To: <10021.1700256111@famine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5811:EE_|MN2PR11MB4758:EE_
x-ms-office365-filtering-correlation-id: 50d9ed46-cff5-459a-c70e-08dbe7b901aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3HvKAkjbozWL95CFzB294faaIPJeg96Cyyp8IOBxXV36mDCvDT1McuuwAje0vmMxKEeiYHUBU2QtdMrLsInhkYUe/sJXNzbE9ZJ2zW/GRim8HIKEFELmNrZY5i5AToh34vvMBHKQ9jtv9SGiZ/zlEr8ae1H7cNUfld3Gy2hD7LsOGfZBFX/CoiMolOR7BiUZT/mpzn15/ozN893gUMYWHQHxWFLZYNQnv0FkiUK6noqqYK7dx3M02qMLxM/krlFglctdR/BoyakZyxNLixj0jiocfONTTukagEdVNfD59TBknyU1rRikjM6nK1iHBGO2lOpSdknKkrWzpt4xAzyrjjIH+KhbA1wV3n04ctoguhjxDHutmkYwaMHEhzUr2oBjg90OWPm+H29bevdNhJIFxnkqVsPGtvjOM/1xbQzN2rdd7Iv9kUbbEZWK2qcG8xPzmsox6YN4zak6QJiyhfrUwehiFRyWKKBuxmcWl2SN7CQqO+hjbSt0aAqqKJFqTjtg/fTeVNMP/P7Q7Eki3GlJNScFiXJwOssZY1Ki9kh8+XaTYOGdENOxHSMK8zeMYqVmgfS0U6739asjK5tkY3AvvLPJOGdPJ/VBqGrVnZ9S3i4whEkHhtReh04D7Pi21TT6CIDuIMsnZC9/FFF6UvO8OA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5811.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(966005)(478600001)(9686003)(76116006)(66446008)(64756008)(66476007)(6916009)(66556008)(41300700001)(86362001)(82960400001)(54906003)(122000001)(66946007)(316002)(26005)(33656002)(107886003)(5660300002)(8676002)(4326008)(8936002)(38100700002)(30864003)(2906002)(83380400001)(52536014)(38070700009)(53546011)(55016003)(6506007)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+ucVLoVvnoQ+T2ZMudxRORQOS4RKInzgkzFSEO/hLbICAou87JhR0IWq9uGH?=
 =?us-ascii?Q?MklQkD69jfrat3eGHl3ge1JoxO5g5MhIBo1psnn/FMIWA/6fklfo5FfrhrOV?=
 =?us-ascii?Q?QiSf/xfmyB9HNeEGXJiLMzlIbOTiY8rSU+BPcRlEHKH1+ogzzs7T73Eh00Be?=
 =?us-ascii?Q?RajXrzuzrBanxAANdhvmajhjO9xQGx7GmNFtcD6RtmtduZDvsYoiPWnfAePc?=
 =?us-ascii?Q?ULgBm1lBSUFp2t2frBf4Ygd6Av48+/GqxOWSct1t18KmS6pYYKeOwWaZf0ol?=
 =?us-ascii?Q?g8a9/G3RnDtfwLkRvePKqT70jOnfjny4MKZEZv+Bdj6v7xvngIWN8bo9imKh?=
 =?us-ascii?Q?PLPgut2l+MdfXu/iIFLgYu0Dz/JTp+oKKXXmfmEMLR6AFQ71y+UTqOsA2png?=
 =?us-ascii?Q?g0Yofj5vV1qiTcB419/qnFriFflMGl6OO2HHWeuQBstCMyLZsnQtdoRGPYhQ?=
 =?us-ascii?Q?L/pIxCAKeGEwTVYdPZK0/iHW+hvgXSd2Nzp2JsSCLccr368lqnpvMX6e8UvE?=
 =?us-ascii?Q?ZwWNKyIdXdu3uWDK5kASDH/gDR+ZW+ieFmAMpoJkjRIOujIOimGslCKJQ9JT?=
 =?us-ascii?Q?pV49IBhfnGsrnH+i/8J4wQOBNdM5px6jNs/kW13ECBFuXuk4dgI9Q0oyUCo/?=
 =?us-ascii?Q?rTfwY9oNvyRPvVD/zK6CRZuzyxDVPEDpRju1Jxy/YrrLkKwzewdDEFUYB1Ju?=
 =?us-ascii?Q?su9R1I2QTeaIcmObXm5oDciXyWimVR0eaC3FTXeKZQNtc0L+8kw1xom4CVkQ?=
 =?us-ascii?Q?x84J0K6Sa7MCInxacMjvuhEajoLCjSALMi9olARexEQ4HjYdw2+R6C7liql3?=
 =?us-ascii?Q?14PdkO/zyWS3cUgaRfr5AVwcQ8jVcpRplMHk6rQ5tAE14ZpaxsZ+9rsaUitx?=
 =?us-ascii?Q?ttxzbP6piBouUL91JLUXzbEjRqJli9aUAMnZQgKVXHA3wjwJ79ykWkOjGZp2?=
 =?us-ascii?Q?wfYyJn1j4humCNBol14KqABI3bOPXWS6hTHe8nsdHEfLQuzQkCmij13Q+dJc?=
 =?us-ascii?Q?Dh5dGIba9YUUu5dGRcn+7NOjgGLq0Afn9vl96UgfVJFdX+jQzeVH8m67U2RP?=
 =?us-ascii?Q?BhjYUf4WHiAQJWaoxHC9WPkQNWQUgmvWL2PVr1S4HwG2NVkMIpEpFGrBQNPb?=
 =?us-ascii?Q?2X9qXepCQZBKeoEqkjW352V8A90tCoB3U+xkMHmqfVnYoiOOCM00ES9mZKqz?=
 =?us-ascii?Q?YPkTUZsjEoBqXbKAM8KXX9bEmVZWKN0wLvRaoWStVGqO9xHR+1CG0yjafqIa?=
 =?us-ascii?Q?1Hy2IRsVvo0F86/d0oJCswCYfplTUj9VLJ0Q8dL6qK8125it2AvfTB2PRL/e?=
 =?us-ascii?Q?cml4l0Eqc+80qLsvTYWrYZypYzGBxpM1e1cEnvHhujc6QX5IbqxMigGI+ag5?=
 =?us-ascii?Q?yP4LK382M0yuFABxpH1ws7GuDeqzdoDFU6cbd8wwEI1ZBWWq/ABH0UWl3fZb?=
 =?us-ascii?Q?9BlbPEo9vqsZd9opDW3QUiLZc2CHfJHBrtJGg22sWhuxYpj3SbsnG+D+8XQ4?=
 =?us-ascii?Q?MghfPkUprbuKyg3zHlbeq/CtEPPp/G+VkAx4IIqWwoAEyIRuAAxYRDZRqzRw?=
 =?us-ascii?Q?vn76jKknZUTRvUQmZIIaBOeaWCzIA7YsiTTdlyxm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5811.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d9ed46-cff5-459a-c70e-08dbe7b901aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 22:03:18.5511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvwDQbsZ0sTa7RJd9lbht2/OXybD4w49DUhPHsEJPJ1hQB3GCHVq+xeRXhrQUjn5r0jsGYdYzlxkzoyMa5OR/RN7hFFDOs2Sbg9koNCSPdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4758
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jay Vosburgh <jay.vosburgh@canonical.com>
> Sent: Friday, November 17, 2023 1:22 PM
> To: Ertman, David M <david.m.ertman@intel.com>
> Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem@davemloft.net; kuba@kernel.org;
> pabeni@redhat.com; edumazet@google.com; netdev@vger.kernel.org;
> Wyborny, Carolyn <carolyn.wyborny@intel.com>;
> daniel.machon@microchip.com; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Buvaneswaran, Sujai
> <sujai.buvaneswaran@intel.com>
> Subject: Re: [PATCH net] ice: Fix VF Reset paths when interface in a fail=
ed
> over aggregate
>=20
> Ertman, David M <david.m.ertman@intel.com> wrote:
>=20
> >> -----Original Message-----
> >> From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> >> Sent: Friday, November 17, 2023 9:44 AM
> >> To: Ertman, David M <david.m.ertman@intel.com>
> >> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> >> davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> >> edumazet@google.com; netdev@vger.kernel.org; Wyborny, Carolyn
> >> <carolyn.wyborny@intel.com>; daniel.machon@microchip.com; Kitszel,
> >> Przemyslaw <przemyslaw.kitszel@intel.com>; Buvaneswaran, Sujai
> >> <sujai.buvaneswaran@intel.com>
> >> Subject: Re: [PATCH net] ice: Fix VF Reset paths when interface in a f=
ailed
> >> over aggregate
> >>
> >> On Thu, Nov 16, 2023 at 10:36:37PM +0100, Ertman, David M wrote:
> >> > > -----Original Message-----
> >> > > From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> >> > > Sent: Thursday, November 16, 2023 6:22 AM
> >> > > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> >> > > Cc: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> >> > > edumazet@google.com; netdev@vger.kernel.org; Ertman, David M
> >> > > <david.m.ertman@intel.com>; Wyborny, Carolyn
> >> > > <carolyn.wyborny@intel.com>; daniel.machon@microchip.com;
> Kitszel,
> >> > > Przemyslaw <przemyslaw.kitszel@intel.com>; Buvaneswaran, Sujai
> >> > > <sujai.buvaneswaran@intel.com>
> >> > > Subject: Re: [PATCH net] ice: Fix VF Reset paths when interface in=
 a
> failed
> >> > > over aggregate
> >> > >
> >> > > On Wed, Nov 15, 2023 at 01:12:41PM -0800, Tony Nguyen wrote:
> >> > > > From: Dave Ertman <david.m.ertman@intel.com>
> >> > > >
> >> > > > There is an error when an interface has the following conditions=
:
> >> > > > - PF is in an aggregate (bond)
> >> > > > - PF has VFs created on it
> >> > > > - bond is in a state where it is failed-over to the secondary in=
terface
> >> > > > - A VF reset is issued on one or more of those VFs
> >> > > >
> >> > > > The issue is generated by the originating PF trying to rebuild o=
r
> >> > > > reconfigure the VF resources.  Since the bond is failed over to =
the
> >> > > > secondary interface the queue contexts are in a modified state.
> >> > > >
> >> > > > To fix this issue, have the originating interface reclaim its re=
sources
> >> > > > prior to the tear-down and rebuild or reconfigure.  Then after t=
he
> >> process
> >> > > > is complete, move the resources back to the currently active
> interface.
> >> > > >
> >> > > > There are multiple paths that can be used depending on what
> triggered
> >> the
> >> > > > event, so create a helper function to move the queues and use
> paired
> >> calls
> >> > > > to the helper (back to origin, process, then move back to active
> >> interface)
> >> > > > under the same lag_mutex lock.
> >> > > >
> >> > > > Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support f=
or
> >> SRIOV
> >> > > on bonded interface")
> >> > > > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> >> > > > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> >> > > > Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> >> > > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> >> > > > ---
> >> > > > This is the net patch mentioned yesterday:
> >> > > > https://lore.kernel.org/netdev/71058999-50d9-cc17-d940-
> >> > > 3f043734e0ee@intel.com/
> >> > > >
> >> > > >  drivers/net/ethernet/intel/ice/ice_lag.c      | 42
> >> +++++++++++++++++++
> >> > > >  drivers/net/ethernet/intel/ice/ice_lag.h      |  1 +
> >> > > >  drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 20 +++++++++
> >> > > >  drivers/net/ethernet/intel/ice/ice_virtchnl.c | 25 +++++++++++
> >> > > >  4 files changed, 88 insertions(+)
> >> > > >
> >> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c
> >> > > b/drivers/net/ethernet/intel/ice/ice_lag.c
> >> > > > index cd065ec48c87..9eed93baa59b 100644
> >> > > > --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> >> > > > +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> >> > > > @@ -679,6 +679,48 @@ static void ice_lag_move_vf_nodes(struct
> >> ice_lag
> >> > > *lag, u8 oldport, u8 newport)
> >> > > >  			ice_lag_move_single_vf_nodes(lag, oldport,
> >> > > newport, i);
> >> > > >  }
> >> > > >
> >> > > > +/**
> >> > > > + * ice_lag_move_vf_nodes_cfg - move VF nodes outside LAG
> netdev
> >> > > event context
> >> > > > + * @lag: local lag struct
> >> > > > + * @src_prt: lport value for source port
> >> > > > + * @dst_prt: lport value for destination port
> >> > > > + *
> >> > > > + * This function is used to move nodes during an out-of-netdev-
> event
> >> > > situation,
> >> > > > + * primarily when the driver needs to reconfigure or recreate
> >> resources.
> >> > > > + *
> >> > > > + * Must be called while holding the lag_mutex to avoid lag even=
ts
> from
> >> > > > + * processing while out-of-sync moves are happening.  Also, pai=
red
> >> > > moves,
> >> > > > + * such as used in a reset flow, should both be called under th=
e
> same
> >> > > mutex
> >> > > > + * lock to avoid changes between start of reset and end of rese=
t.
> >> > > > + */
> >> > > > +void ice_lag_move_vf_nodes_cfg(struct ice_lag *lag, u8 src_prt,=
 u8
> >> > > dst_prt)
> >> > > > +{
> >> > > > +	struct ice_lag_netdev_list ndlist, *nl;
> >> > > > +	struct list_head *tmp, *n;
> >> > > > +	struct net_device *tmp_nd;
> >> > > > +
> >> > > > +	INIT_LIST_HEAD(&ndlist.node);
> >> > > > +	rcu_read_lock();
> >> > > > +	for_each_netdev_in_bond_rcu(lag->upper_netdev,
> tmp_nd) {
> >> > >
> >> > > Why do you need rcu section for that?
> >> > >
> >> > > under mutex? lacking context here.
> >> > >
> >> >
> >> > Mutex lock is to stop lag event thread from processing any other eve=
nt
> >> until
> >> > after the asynchronous reset is processed.  RCU lock is to stop uppe=
r
> kernel
> >> > bonding driver from changing elements while reset is building a list=
.
> >>
> >> Can you point me to relevant piece of code for upper kernel bonding
> >> driver? Is there synchronize_rcu() on updates?
> >
> >Here is the benning of the bonding struct from /include/net/bonding.h
> >
> >/*
> > * Here are the locking policies for the two bonding locks:
> > * Get rcu_read_lock when reading or RTNL when writing slave list.
> > */
> >struct bonding {
> >	struct   net_device *dev; /* first - useful for panic debug */
> >	struct   slave __rcu *curr_active_slave;
> >	struct   slave __rcu *current_arp_slave;
> >	struct   slave __rcu *primary_slave;
> >	struct   bond_up_slave __rcu *usable_slaves;
> >	struct   bond_up_slave __rcu *all_slaves;
> >
> >> >
> >> > > > +		nl =3D kzalloc(sizeof(*nl), GFP_ATOMIC);
> >> > >
> >> > > do these have to be new allocations or could you just use list_mov=
e?
> >> > >
> >> >
> >> > Building a list from scratch - nothing to move until it is created.
> >>
> >> Sorry got confused.
> >>
> >> Couldn't you keep the up-to-date list of netdevs instead? And avoid al=
l
> >> the building list and then deleting it after processing event?
> >>
> >
> >The bonding driver is generating netdev events for things changing in th=
e
> aggregate. The ice
> >driver's event handler which takes a snapshot of the members of the bond
> and creates a work
> >item which gets put on the event processing thread and then returns.  Th=
e
> events are processed
> >one at a time in sequence asynchronously to the event handler on the
> processing thread.  The
> >contents of the member list for the work item is only valid for that wor=
k
> item and cannot be used
> >for a reset event happening asynchronously to the processing queue.
>=20
> 	Why is ice keeping track of the bonding state?  I see there's
> also concurrently a patch [0] to block PF reinitialization if attached
> to a bond, as well as some upstream discussion regarding ice issues with
> bonding and SR-IOV [1], are these things related in some way?
>=20
> 	Whatever that reason is, should the logic apply to other drivers
> that do similar things?  For example, team and openvswitch both have
> functionality that is largely similar to what bonding does, so I'm
> curious as to what specifically is going on that requires special
> handling on the part of the device driver.
>=20
> 	-J
>=20

The original patches are implementing support for SRIOV VFs on an aggregate
interface (bonded PFs).  This results in a single VF being backed up by two=
 PFs.  The VF
and users of the VF are not even aware that an aggregate is involved. To ac=
complish this
in software, the ice driver has to manipulate resources (queues, scheduling=
 nodes, etc)
so that VFs can communicate through whichever interface is active.  It has =
to move
resources back and forth based on events generated by the bonding driver. A=
lso as interfaces
are added to an aggregate, setup has to be done to prepare to support SRIOV=
 VFs.

As far as other entities that act like the bonding driver - they will only =
have support for SRIOV
VFs if they also generate events like the bonding driver.

> [0]
> https://lore.kernel.org/netdev/20231117164427.912563-1-
> sachin.bahadur@intel.com/
>=20
> [1]
> https://lore.kernel.org/lkml/CC024511-980A-4508-8ABF-
> 659A04367C2B@gmail.com/T/#mde6cc7110fedf54771aa3c13044ae6c0936525f
> b
>=20
> >Thanks,
> >DaveE
> >
> >> >
> >> > > > +		if (!nl)
> >> > > > +			break;
> >> > > > +
> >> > > > +		nl->netdev =3D tmp_nd;
> >> > > > +		list_add(&nl->node, &ndlist.node);
> >> > >
> >> > > list_add_rcu ?
> >> > >
> >> >
> >> > I thought list_add_rcu was for internal list manipulation when prev =
and
> >> next
> >> > Are both known and defined?
> >>
> >> First time I hear this TBH but disregard the suggestion.
> >>
> >> >
> >> > > > +	}
> >> > > > +	rcu_read_unlock();
> >> > >
> >> > > you have the very same chunk of code in
> >> ice_lag_move_new_vf_nodes().
> >> > > pull
> >> > > this out to common function?
> >> > >
> >> > > ...and in ice_lag_rebuild().
> >> > >
> >> >
> >> > Nice catch - for v2, pulled out code into two helper function:
> >> > ice_lag_build_netdev_list()
> >> > Iie_lag_destroy_netdev_list()
> >> >
> >> >
> >> > > > +	lag->netdev_head =3D &ndlist.node;
> >> > > > +	ice_lag_move_vf_nodes(lag, src_prt, dst_prt);
> >> > > > +
> >> > > > +	list_for_each_safe(tmp, n, &ndlist.node) {
> >> > >
> >> > > use list_for_each_entry_safe()
> >> > >
> >> >
> >> > Changed in v2.
> >> >
> >> > > > +		nl =3D list_entry(tmp, struct ice_lag_netdev_list, node);
> >> > > > +		list_del(&nl->node);
> >> > > > +		kfree(nl);
> >> > > > +	}
> >> > > > +	lag->netdev_head =3D NULL;
> >> >
> >> > Thanks for the review!
> >> > DaveE
> >
>=20
> ---
> 	-Jay Vosburgh, jay.vosburgh@canonical.com

