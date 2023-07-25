Return-Path: <netdev+bounces-20802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2261476107E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF802817AB
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225521D2FA;
	Tue, 25 Jul 2023 10:20:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112681ED32
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:20:53 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9904410DC
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690280452; x=1721816452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MpeqNBHgf6R/3c3RM9wUv0CJOhzvxLfXmOPvMBXYgrQ=;
  b=SQj5bPh/CBoG/S/L0DlGF/WJQHFVIFHs8aksIyQe8jVrZalaWvlGxMmz
   NjnyTDRYb8xSoghDnKxmZpl/ZYZP1BQLJ/oVZaQfsiAV2hvMKnezFYfbn
   rKCJXiJCIppR5a46sOTX9IxxJoxb37+4T84NAfC9wolRYzqyQuO26AMtK
   aHaOrdtqVVsbLF7auvCw4jX4mVuKVKGcY+bAvYhnq4IUMMFozh2XrVM7d
   rH/gTAMps0kh963cTNJBh/ytHXuaZnvEYgGmCM6thOU7Hb/1vvITW1D4t
   eqc98iPq/+rIyhK3kvzE3F/zbZb7RVjIhRlD/60YHBdYOeJk9dVGtxcII
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347287211"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="347287211"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 03:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="729301091"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="729301091"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jul 2023 03:20:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 03:20:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 03:20:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 03:20:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T49KkviPg9DssB39onc0orQjdi/qq5R+54l4f5+AAw88qlUiSF24YTcRgu02hgVGu6d8a7yoRkguOFPJhT0MhaMz/QEiH9hKBN/0xp4fjIVv5Rnl/XD7WqqMpdCWMS7HdYgZsNoXOyJePoidISdcvcGnnIJZ2yC/uhqzkrjknl1Y6LIkrnPQDEbWq0mOiJRPhjevEInZyo9dZepjAjeX2HTzH30nKpBpGgibiJDteys2W2ce4ohaMk3EfLCM4vkzsq4SDtNpBd3RxoIpWD3RZKROgc5ST2SRFmoaBAuptKgv4lfUuZ30az8pBiICF2XMetfl54SIEeZ0+Agh4bMB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpeqNBHgf6R/3c3RM9wUv0CJOhzvxLfXmOPvMBXYgrQ=;
 b=AYUox5S4ebFCO4l+1p6o3PjPr2xnlcqy644rsDunJyqYzfWDxKnO+SYdeGcCsHHuDfBljxtubRbeHdguAYBw81Sql7+bhlnsZ0FZnxEaO8QPhVHftb/4kRRSg7a7PFPswKoT7iYKPAgzIVNSGYRkJsKOUipCFHpz7/RIul+W5oZiYUaX5Y+rNu5cPetJ9MHTBnXVs0j4i8V+2+MuGN5rUZx3ely9p6nPR2J6C6qpdw/camoO8tSvaeGQ9U/1VtmrH0LZj5ofFvohAMBoAymuUwUtD77/lNCudKXdl13ZAQa20tCsTxeUeaQP8cM5X/d1zS8PoHJfkc75SZRuHinh3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Tue, 25 Jul 2023 10:20:44 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 10:20:44 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Simon Horman <simon.horman@corigine.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH net-next v3 1/2] tools: ynl-gen: fix enum index in
 _decode_enum(..)
Thread-Topic: [PATCH net-next v3 1/2] tools: ynl-gen: fix enum index in
 _decode_enum(..)
Thread-Index: AQHZuZRcbwObcTNgM0ytXyhb7VyubK/D7sMAgAZhPjA=
Date: Tue, 25 Jul 2023 10:20:44 +0000
Message-ID: <DM6PR11MB465725073BAD2F37A500525C9B03A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230718162225.231775-1-arkadiusz.kubalewski@intel.com>
 <20230718162225.231775-2-arkadiusz.kubalewski@intel.com>
 <ZLpHxiQT+1IAogMK@corigine.com>
In-Reply-To: <ZLpHxiQT+1IAogMK@corigine.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|MN6PR11MB8241:EE_
x-ms-office365-filtering-correlation-id: a21a9ab0-17cd-4566-af81-08db8cf8ce5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TaR2731pF+tPruCMRkg8tZ9MmQToDKqx/RHCh5ouHgsB8GzOQszSzhOVE5QqHa2oZ1nHbWkYPoMA67LSaDldfG7IIQd4vUuIw8GpqbOR9C2eZTi0tb8kXjTuOwo1QLNWiK8Tkf7CarHkgPgCN0IvjeXX4GKg+8wAtbWvc+BprSn1gSbUKJp3cjSpkeZpaDnzueONDitB2OVBWiN9o7f4j4niT4hHsvPK50y38j729ZM9jybg/MJm3uasD4mK1Xe80MSVTCEMfim0c1sQBBzAk9IJRwd/NyZItefv+jUmWwdeYL8r4smwxIDQYPaqMixlqECqvS0v7o5ybNRBtSy9KdzG/gvuPT7lpBQJKvgmhnmbUitU9OwcmnQgNV9SLh+p/yc9Fd+mnJOM5B4YWfpsXKjLyciWXBJC5bQSDu2YD+3+CTuSPiAOvQzWl9I0h4YgUpWyVrdpqYopmHK/JFi3KuLTRO0GNO30/WINYH+ostT8XGqWobeDYfxsJ8sRjzSZfQH60Vf0qrzURuwPNDZwHoeAwp0Ugw3x473iq+HMnQSsnCwgex+u1KuHXxzHcWFMDe3DoMFazmo93kmo/FKDxzPg4XYV8MHD605T3eDkMF+k/d5SDweFoluuFVbpo03n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(4326008)(2906002)(64756008)(66946007)(76116006)(66476007)(66556008)(66446008)(71200400001)(6916009)(478600001)(7696005)(558084003)(54906003)(9686003)(86362001)(33656002)(186003)(122000001)(82960400001)(6506007)(38100700002)(38070700005)(55016003)(41300700001)(8676002)(8936002)(52536014)(5660300002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dW3PcWNS8L9QjaasTC403vU3iNq3XIPS6ASw+FgIdzQEaibCrZ2f7W5VBv6l?=
 =?us-ascii?Q?Z+/8QX+JM+UKvh8b7htObt68LQsp5WrPdzuXrgFjXC7q7mA8aq7vh/U59UDs?=
 =?us-ascii?Q?cDQU8VB+VvjzIFxXroG2gp+AAS/ljWhlrMyVbGY1ZOeNT/s1LDMUBIOk+ivf?=
 =?us-ascii?Q?fsvDqieo6718sbFWu6+NlhKFlXZVmMX9vJRtS6rC9LqgeKqhFcF2ZbPWobd6?=
 =?us-ascii?Q?wPHKX72wUZea0t7ZlvDNW78V9FHMNLVksUMAXFt9Cj53Ds9k+v+f829ZIHoN?=
 =?us-ascii?Q?BaRuAroCymIH0FEyzqi7nr5f9IxfTYTJPj0RMI5rcp7/SiAHZ/wXJ9x+Gpmt?=
 =?us-ascii?Q?j3w0aFrlNZpj/0FyWnPubqGkhoyWKaEQBiIOmPAeXjGlo+KwfAmL8+yTjZs5?=
 =?us-ascii?Q?JX1o7LPXxXQzM6WXSbihw9VleeiYQPERnXL+PchM5xhmdBZPFsEZ6pDaHeu5?=
 =?us-ascii?Q?WQBGz/lWIAu5HLwVZWkCCawpsJVknIxRGVAbKCi6lAXKMODBV0ApiLM4Db0t?=
 =?us-ascii?Q?Q2VNLpYtTsDWSTlPzPlbE97xXKp+SpAg4H7Yk+gMs6LR1MsNC1aIzKFfhH6y?=
 =?us-ascii?Q?ZJYZfWtH2VskbTKUMlt7bEtRPzkf8k7PtEWaY8QErB+V8gwUK7+Lf2t3DHw1?=
 =?us-ascii?Q?uZj2Q5A+HE6ZdnqNQPr/BiXqMrHIFjG9xNkhamjqoYGprVGzOuuXyjucxiRR?=
 =?us-ascii?Q?X3jSLJVpUDM7TfRAIyyuf3dQlo99h86pFmYHYtshu4wwe6wP0J8NmHBpG1wx?=
 =?us-ascii?Q?62GCdImXjT093kAwkiSIgecK8SHyVpx+x/auAwUBfvaZXOZtZLjc/SujOj8H?=
 =?us-ascii?Q?Lm82gY44uDVlSwXvE49qRzZ81lKXKwE5PIFP7dV37RpIZ0l4GRjGGvADO1tm?=
 =?us-ascii?Q?hDElwCBFyFV9SJk8K9FO8IHCp4oSZRnPyFWwkGAsYBXQxSXxiFzS0lwVDFSB?=
 =?us-ascii?Q?uHO3BdD7NMazAKh/dExcjGGqHe3/nCj3YYayJwGl/Xd1+VwJiAsEf35QAoxl?=
 =?us-ascii?Q?ifC1O/Rr/ROa254EM+imuQryiaSQDsfp4Vr0B+PJ6mZrSa0Xwj54L54HLQXG?=
 =?us-ascii?Q?7xgqCXQtXvwyyCcVua12zGIfT83t2zAgQgvaxX6pq1SCz6Z6x9gACIE+UPEa?=
 =?us-ascii?Q?FV3nNlj6wSIq7uV5XnGBJICb3V+cupE5WoGrRACvLMK88IJsbMqC4n9QPbwD?=
 =?us-ascii?Q?inN2Gq0s130Hl7q0J+Ix1TUsRwPEhFJN66RA1dfYP48suxFYwIUmKd+C1SBb?=
 =?us-ascii?Q?KC2hEL4NPSxIDACFVB/hCwFET9rI7FuSknOiGlHfx2ZonwUqHlc+0cQMpdgs?=
 =?us-ascii?Q?N9dkZ92j4+l+qr97fbgkP3F6a6lKwV8g27Hvy7pQoG8MFZ3W5PWstgU1dxR4?=
 =?us-ascii?Q?gr4XvZZk7UkYcW6xYaRQf8TwN7rp4YEJB2fYR0X0xNqCGpXabvvsoH0wd8XF?=
 =?us-ascii?Q?FM/myBJnDsadwHD+taQkzwwoVkFiPPrcvFaoHB9naqucl6PAMAL7PdUVamFH?=
 =?us-ascii?Q?SCPpgOdt3pOuaDxzsvKwztoF8MgzlR0kMWB+sUFcS2NYlesjkXKkiZwKVcTw?=
 =?us-ascii?Q?992n6OoVMc2pcJy3shyN01iV+D78OEcdw6Z0pScgI9cZkYqWQ7XM41gqY4M6?=
 =?us-ascii?Q?ekBKLmqsEUeKgGjj8EQu7+3s1RDYCYMSNTHJpo2If8ufDZnGg4n6j9QmNMYu?=
 =?us-ascii?Q?+r3qyg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a21a9ab0-17cd-4566-af81-08db8cf8ce5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 10:20:44.4855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ecXibLlT6CHKU7K7wnoqmDaDaA92b+NRgI9p9fEiV2z1IV1xyXLqZfg2pGdN4di2HBpG9o4o5DaT3DhOcp/lXneBDtzs43hn3PepyjYJtxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8241
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Simon Horman <simon.horman@corigine.com>
>Sent: Friday, July 21, 2023 10:55 AM
>
>On Tue, Jul 18, 2023 at 06:22:24PM +0200, Arkadiusz Kubalewski wrote:
>> Remove wrong index adjustement, which is leftover from adding
>
>nit: adjustement -> adjustment
>

Yes, fixed.

Thank you!
Arkadiusz

>...

