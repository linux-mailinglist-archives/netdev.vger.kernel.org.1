Return-Path: <netdev+bounces-40319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007947C6AAF
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 12:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A814B2827B8
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 10:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA87B224FE;
	Thu, 12 Oct 2023 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4YuxWJ4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1947722336
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 10:13:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AC0BA
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 03:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697105605; x=1728641605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dXFDwfrKX1xj13g4jnwVkLmGf+zJ7yLPdDrCN6RcKps=;
  b=D4YuxWJ4IOVNhQeXsVWjx2al6yewGAVXOdUo8Fi03prclIjjuf7LSVYq
   tXHBOu6YTnefKw1j1sMIfzQBdRlGEHApzXaFz/M3Hm4kfpbt2aghAbeDY
   vMMV7DezWmEfAApESIH87q5GgasNce7/tbw071XUsrre9c5y7RiLeqgrY
   SHQnEBNGH5tAF1f4czIsyToQXgeSrBD1KnQUMxTpCE2yleVQ2k1hfft/c
   3AnStoddItI8jHPeNALZIlrymcWsm9WYLo4+QsuS5PS0vjeQByKQiAPBJ
   sd5OeTsqHfkKV7dUHT4y+fT5elzRWJ1XVsICPq4rWGvqHRBB9HqMYasqU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="365158883"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="365158883"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 03:13:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="898036501"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="898036501"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 03:11:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 03:13:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 03:13:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 03:13:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkihDJosW0wnKQ5dZMDwPD/FLuueYBt+OP7l1HrPVTqiOC10sbGXkuHvljOaKE1Zpn+Rg6YE+w3Z2izChu2on5NFHu5LWn299s9xI/IT1Rtimqrpo1l78vzTPtxtR4T5lDSxQSRUWlj0eVuHvBYofyHILLpE/vhmZ9d9JFJO2vZCOVs6CbOM/+Rle1tSV9S2OqaTN2XVnQxg1lBqglbGLo+wNyMH1lV4GY3db2Uwvb4nAQeFHyAGLQRua4uaHWtFYzsvtBt6N7+719VHDy/eU8Pn76TsAYe7t8uKFOKLYkHRNQ9JDWFxomVJIWXoHetBMzdTUrWfKTzz/PmSpfISiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSM3vdOIausRWKP4h3wW+HUHEcuFBMJUlkIRVAvMBdY=;
 b=guh6sBvozl6L3/b+6I6pVpcgAPfrWw5oGUOJcqyxjxNBJR+qdZSlPsdKQQmolE64P992Lh4757zcImHOFkx4bheWy8yuxN2uxTr3pG/NWBCzi2ENcssutf3By2avkaopRdoeF8126mb+kf8VdRwTDgogUDDL9F4HK8B6+k1hDDx4Kvvix8nN9xVrjxFuNErlS7YLzi3LtEGnlLRUOW7lgo6gIK6s1SdshflUmfqP5+TrUK+7oTlvZ7GvbAnsK/w8wuMoborFqlP5JVykgB2dsbnrAwnTbwD/vbs6u8KzKnukObvpmjBV9jP4aKOJESgLJns96yBMQx/Qu1Pf2cIPPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 10:13:08 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 10:13:08 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 2/2] intel: fix format
 warnings
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 2/2] intel: fix format
 warnings
Thread-Index: AQHZ9imWOmpOSesagUKJY+axTP6BBrBF+wZA
Date: Thu, 12 Oct 2023 10:13:08 +0000
Message-ID: <BL0PR11MB31222860B8222722D15AA251BDD3A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231003183603.3887546-1-jesse.brandeburg@intel.com>
 <20231003183603.3887546-3-jesse.brandeburg@intel.com>
In-Reply-To: <20231003183603.3887546-3-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|PH7PR11MB8251:EE_
x-ms-office365-filtering-correlation-id: bc1e00a7-341e-48f4-63df-08dbcb0bd50c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JoY3dN9EghjAxh4ZjAp8ZvP+n7v9ax8X5Wa4gYiFDZ9+ajy5AzygXNZS887FvIHEh0C3G8Vhuynf2yweUI2xQoXSw5Q9A/JT3GzUhS1tgNiyMglkZ4SCj7rmzSnBFzOM5sxOuC2wWbat+hOYljESXXhd5kuICqNw/0EyxJUe+jY8O3RhfqmKCT/7QfdOp7ym53SIq46Xh0jztswuAlRrNsRImBfAk9KN7xnfYgFhtHh/7RmdRnLTaCLR4EOM4UNyCGq/niqEL8o9wzE6U+PH4I2rR+7xXZyN8nZQeOpQ7M/msCMQRXrLTYFxpC3ZIo48WrU12Vo4WLEwqonhtpZ8UQE/YRFiaKKsHLmqan4nFrWLcqKcMIrqYNesKpL6tcktxbvITbRoyktdDZHq2N5PwqK2KLH7d5ySmr7ObUlTq+Y2TckejpWHawPmR743Y4ZzeXN8L19PK3LBweCMWScTb7EmjDNOwd/xqzdYhL7C1G+Lgnjm7HxofITSt1OydWa7o79GvePlcNHJbM9MAJXanKl/9vX69DdU7pLvPF5jJdJqEqBOemfORyrAmvIRUaup3Rnn0+isqWN0F0V2ViugsvNqhDGJwiJStq2Z+Hci6KpC11ag6F/9gm3DU4TP/ri7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(66446008)(107886003)(54906003)(55016003)(478600001)(71200400001)(53546011)(86362001)(7696005)(9686003)(38100700002)(33656002)(41300700001)(66946007)(5660300002)(122000001)(66476007)(66556008)(110136005)(64756008)(6506007)(316002)(38070700005)(82960400001)(8676002)(8936002)(2906002)(4326008)(52536014)(76116006)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?skxSahXyIxNOAfxZC+aqWa4avEPSdSys2/5G3Eog4wPRRtGg0PBfEwOJo3W1?=
 =?us-ascii?Q?uHemSxSVog18dHQuixFsJ2IatVE/AOQVDh0yrZX8lVXTURVQeCdQ7kGKKv/W?=
 =?us-ascii?Q?mgd9DeoQ3gMqF7ikjHeYteeOyOG/V8VKGNJSEH2LnE3gnY2hTvJjAdCR8Zyx?=
 =?us-ascii?Q?534EJq+G4/35pgJJHGsrmRnnFWMeyQPvb15sHoH7YIje1Ph5MJw7FK6bfW77?=
 =?us-ascii?Q?DkmjqdLBaKOH6CZgbF7c9oljgfdWrCWIxqGGGVUpjw8/74mP54POcX+WL3sW?=
 =?us-ascii?Q?q8MwVcId6Q67SXY2Xp/9Bf4FW3KYnSFJOJlcjZ6/hKoqKEHW6RAlGPWxcLeQ?=
 =?us-ascii?Q?9y0Ajxg6+H0jQjerpAiOtfIB7yW8DrIHuLhZgvU1mmFwBdNomseg8HuiI2LY?=
 =?us-ascii?Q?FayYMwEbjyp2OggXJMcHM2L870QpVNzADGOJFMvXQ3/f1Hqk9JsQhBU2Ypn3?=
 =?us-ascii?Q?w8lwi/Xt1gguqkzXFjD6KZ5JbwpIHoXjfSMAn3qrJ3jopiuPWeItnFzicVdL?=
 =?us-ascii?Q?An8VVHUSfWq9FKWBSiDPlj4EAq063xSg4QTFlktdKRFC4mFHYntBbdq9tjnj?=
 =?us-ascii?Q?6XLXgeVvq4GcX9q0bqBWBeAmntxum+69x6AChpFiumowCRSHGLPhjbYFzjlZ?=
 =?us-ascii?Q?VedKDaCUtYMPT83VAZ14Yk7kH3r7iYnAm4VEQS3oP/mjI2k1D8kIHtenUPFD?=
 =?us-ascii?Q?Z9+/kQ54NgZNeRvLcbFJIQaaeRiRImUC+nOjbpQfdG9qJweChF17rl+ax/TW?=
 =?us-ascii?Q?WX+ujmPLpU6o0NqI+dXiOuqz/UrPbNN2Febocrld2I4+dQ6WcnmfhC3uPM3+?=
 =?us-ascii?Q?X4u4MqK7rmDEjNqykpviqdXOjE0qczqrmxIfEJ5wRBji8E1rn0GJBntkvI6S?=
 =?us-ascii?Q?4pJN7PdP5NcvMKO3JXjZXXUL5ngHV0oBZkDuwCaYH85Ak9lSuuUB/iWZgyxh?=
 =?us-ascii?Q?baBnJ7iLC1Kzt1lDQ3TMUh1OHLOwo1b/I0VouGQtxJqaHGcjDmTe7i+mk9x3?=
 =?us-ascii?Q?kGlPq3FbMlcksdHyVYA1WNWQiSrHGK5bKN6I1PuRZBpDz4BO0N8T3F3BRHGY?=
 =?us-ascii?Q?wufO4Ugr9tqjmcDyrE1hsNoKtgE7Rc3P3kMMu3/Lq/t4bogmV6BtsmnpP5vP?=
 =?us-ascii?Q?NhcKnmEk52KYapqun/l3joFWFzVg2DOM3I0fExHkAWygdozACiGS1KsLkzJG?=
 =?us-ascii?Q?I7gtxlPNn+Iz0I/zThNfSn4S251cAwgNENqkKojbZJJ8p1D+AUB0+dYz9pzf?=
 =?us-ascii?Q?cQ+920a/D26dmhlWJZ5fQBSfzwVyNeSk3viHFc5+3Ur1CbBZq9kOggi94mxk?=
 =?us-ascii?Q?nN+fJRXR7bLtndqWFAloExbprJ1trWBFouWTqL/PCUhBPG7j9bMBn8PmtPg/?=
 =?us-ascii?Q?NNYYyC0C410dT+x++kQ9bT1hLAoSwnvCKXFtJQwDcdeZpg+k6j62XayGkFlk?=
 =?us-ascii?Q?78+V3p8ST25ZefCkiflsOEZDEfKL2wkv5GVL1H18uLZWvjvx+nQbzfr+Z2/v?=
 =?us-ascii?Q?TOe36wFls60XzXcZEpGaOjghpu+vU6MFRv/ysSsA0Ysv2x55GlTC2e3ouVnQ?=
 =?us-ascii?Q?WHg+uJSuuzoqb2WyZuh2TUG0W5Jx7MrRc6Q4WEIYAn7nleE9dnv2gGnfCWlM?=
 =?us-ascii?Q?rw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1e00a7-341e-48f4-63df-08dbcb0bd50c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 10:13:08.1984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44HNjzjjhoH1QsgCF99+RCyJ5kvJyRi9Q5Nhnm9EkPsUD0d1Vb5QNTNd1wmnMxIGSUgdBoFYEc4VD6DPddlA7GMUSO3XQkxSpnsTvgfm8UZNUx6FFOnBBQYbuwdOHmeW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8251
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
esse Brandeburg
> Sent: Wednesday, October 4, 2023 12:06 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Lobakin, Aleksander <aleksander.lobakin@intel=
.com>; Christophe JAILLET <christophe.jaillet@wanadoo.fr>; Brandeburg, Jess=
e <jesse.brandeburg@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@int=
el.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 2/2] intel: fix format warn=
ings
>
> Get ahead of the game and fix all the -Wformat=3D2 noted warnings in the
> intel drivers directory.
>
> There are one set of i40e and iavf warnings I couldn't figure out how to
> fix because the driver is already using vsnprintf without an explicit
> "const char *" format string.
>
> Tested with both gcc-12 and clang-15. I found gcc-12 runs clean after
> this series but clang-15 is a little worried about the vsnprintf lines.
>
> summary of warnings:
>=20
> drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c:148:34: warning: format =
string is not a string literal [-Wformat-nonliteral]
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1416:24: warning: format=
 string is not a string literal (potentially insecure) [-Wformat-security]
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1416:24: note: treat the=
 string as an argument to avoid this
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1421:6: warning: format =
string is not a string literal (potentially insecure) [-Wformat-security]
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1421:6: note: treat the =
string as an argument to avoid this
> drivers/net/ethernet/intel/igc/igc_ethtool.c:776:24: warning: format stri=
ng is not a string literal (potentially insecure) [-Wformat-security]
> drivers/net/ethernet/intel/igc/igc_ethtool.c:776:24: note: treat the stri=
ng as an argument to avoid this
> drivers/net/ethernet/intel/igc/igc_ethtool.c:779:6: warning: format strin=
g is not a string literal (potentially insecure) [-Wformat-security]
> drivers/net/ethernet/intel/igc/igc_ethtool.c:779:6: note: treat the strin=
g as an argument to avoid this
> drivers/net/ethernet/intel/iavf/iavf_ethtool.c:199:34: warning: format st=
ring is not a string literal [-Wformat-nonliteral]
> drivers/net/ethernet/intel/igb/igb_ethtool.c:2360:6: warning: format stri=
ng is not a string literal (potentially insecure) [-Wformat-security]
> drivers/net/ethernet/intel/igb/igb_ethtool.c:2360:6: note: treat the stri=
ng as an argument to avoid this
> drivers/net/ethernet/intel/igb/igb_ethtool.c:2363:6: warning: format stri=
ng is not a string literal (potentially insecure) [-Wformat-security]
> drivers/net/ethernet/intel/igb/igb_ethtool.c:2363:6: note: treat the stri=
ng as an argument to avoid this
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:208:34: warning: format st=
ring is not a string literal [-Wformat-nonliteral]
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2515:23: warning: format s=
tring is not a string literal (potentially insecure) [-Wformat-security]
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2515:23: note: treat the s=
tring as an argument to avoid this
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2519:23: warning: format s=
tring is not a string literal (potentially insecure) [-Wformat-security]
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2519:23: note: treat the s=
tring as an argument to avoid this
> drivers/net/ethernet/intel/ice/ice_ethtool.c:1064:6: warning: format stri=
ng is not a string literal (potentially insecure) [-Wformat-security]
> drivers/net/ethernet/intel/ice/ice_ethtool.c:1064:6: note: treat the stri=
ng as an argument to avoid this
> drivers/net/ethernet/intel/ice/ice_ethtool.c:1084:6: warning: format stri=
ng is not a string literal (potentially insecure) [-Wformat-security]
> drivers/net/ethernet/intel/ice/ice_ethtool.c:1084:6: note: treat the stri=
ng as an argument to avoid this
> drivers/net/ethernet/intel/ice/ice_ethtool.c:1100:24: warning: format str=
ing is not a string literal (potentially insecure) [-Wformat-security]
> drivers/net/ethernet/intel/ice/ice_ethtool.c:1100:24: note: treat the str=
ing as an argument to avoid this
>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> clang-15 warnings before the patch:
>
> drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c:148:34: warning: format =
string is not a string literal [-Wformat-nonliteral]
>                vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args)=
;
>                                               ^~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1416:24: warning: format=
 string is not a string literal (potentially insecure) [-Wformat-security]
>                         ethtool_sprintf(&p, ixgbe_gstrings_test[i]);
>                                             ^~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1416:24: note: treat the=
 string as an argument to avoid this
>                         ethtool_sprintf(&p, ixgbe_gstrings_test[i]);
>                                             ^
>                                            "%s",
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1421:6: warning: format =
string is not a string literal (potentially insecure) [-Wformat-security]
>                                         ixgbe_gstrings_stats[i].stat_stri=
ng);
>                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1421:6: note: treat the =
string as an argument to avoid this
>                                         ixgbe_gstrings_stats[i].stat_stri=
ng);
>                                         ^
>                                         "%s",
> drivers/net/ethernet/intel/igc/igc_ethtool.c:776:24: warning: format stri=
ng is not a string literal (potentially insecure) [-Wformat-security]
>                         ethtool_sprintf(&p, igc_gstrings_stats[i].stat_st=
ring);
>                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> drivers/net/ethernet/intel/igc/igc_ethtool.c:776:24: note: treat the stri=
ng as an argument to avoid this
>                         ethtool_sprintf(&p, igc_gstrings_stats[i].stat_st=
ring);
>                                            ^
>                                            "%s",
> drivers/net/ethernet/intel/igc/igc_ethtool.c:779:6: warning: format strin=
g is not a string literal (potentially insecure) [-Wformat-security]
>                                         igc_gstrings_net_stats[i].stat_st=
ring);
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> drivers/net/ethernet/intel/igc/igc_ethtool.c:779:6: note: treat the strin=
g as an argument to avoid this
>                                         igc_gstrings_net_stats[i].stat_st=
ring);
>                                       ^
>                                        "%s",
> drivers/net/ethernet/intel/iavf/iavf_ethtool.c:199:34: warning: format st=
ring is not a string literal [-Wformat-nonliteral]
>                vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args)=
;
>                                               ^~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/igb/igb_ethtool.c:2360:6: warning: format stri=
ng is not a string literal (potentially insecure) [-Wformat-security]
>                                         igb_gstrings_stats[i].stat_string=
);
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/igb/igb_ethtool.c:2360:6: note: treat the stri=
ng as an argument to avoid this
>                                         igb_gstrings_stats[i].stat_string=
);
>                                         ^
>                                         "%s",
> drivers/net/ethernet/intel/igb/igb_ethtool.c:2363:6: warning: format stri=
ng is not a string literal (potentially insecure) [-Wformat-security]
>                                         igb_gstrings_net_stats[i].stat_st=
ring);
>                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> drivers/net/ethernet/intel/igb/igb_ethtool.c:2363:6: note: treat the stri=
ng as an argument to avoid this
>                                         igb_gstrings_net_stats[i].stat_st=
ring);
>                                         ^
>                                         "%s",
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:208:34: warning: format st=
ring is not a string literal [-Wformat-nonliteral]
>                 vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args=
);
>                                                ^~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2515:23: warning: format s=
tring is not a string literal (potentially insecure) [-Wformat-security]
>                 ethtool_sprintf(&p, i40e_gstrings_priv_flags[i].flag_stri=
ng);
>                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2515:23: note: treat the s=
tring as an argument to avoid this
>                 ethtool_sprintf(&p, i40e_gstrings_priv_flags[i].flag_stri=
ng);
>                                   ^
>                                    "%s",
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2519:23: warning: format s=
tring is not a string literal (potentially insecure) [-Wformat-security]
>                 ethtool_sprintf(&p, i40e_gl_gstrings_priv_flags[i].flag_s=
tring);
>                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2519:23: note: treat the s=
tring as an argument to avoid this
>                 ethtool_sprintf(&p, i40e_gl_gstrings_priv_flags[i].flag_s=
tring);
>                                     ^
>                                     "%s",
> drivers/net/ethernet/intel/ice/ice_ethtool.c:1064:6: warning: format stri=
ng is not a string literal (potentially insecure) [-Wformat-security]
>                                         ice_gstrings_vsi_stats[i].stat_st=
ring);
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> drivers/net/ethernet/intel/ice/ice_ethtool.c:1064:6: note: treat the stri=
ng as an argument to avoid this
>                                         ice_gstrings_vsi_stats[i].stat_st=
ring);
>                                        ^
>                                        "%s",
> drivers/net/ethernet/intel/ice/ice_ethtool.c:1084:6: warning: format stri=
ng is not a string literal (potentially insecure) [-Wformat-security]
>                                         ice_gstrings_pf_stats[i].stat_str=
ing);
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> drivers/net/ethernet/intel/ice/ice_ethtool.c:1084:6: note: treat the stri=
ng as an argument to avoid this
>                                         ice_gstrings_pf_stats[i].stat_str=
ing);
>                                         ^
>                                        "%s",
> drivers/net/ethernet/intel/ice/ice_ethtool.c:1100:24: warning: format str=
ing is not a string literal (potentially insecure) [-Wformat-security]
>                         ethtool_sprintf(&p, ice_gstrings_priv_flags[i].na=
me);
>                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
> drivers/net/ethernet/intel/ice/ice_ethtool.c:1100:24: note: treat the str=
ing as an argument to avoid this
>                         ethtool_sprintf(&p, ice_gstrings_priv_flags[i].na=
me);
>                                           ^
>                                            "%s",
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c   | 6 ++++--
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c   | 8 +++-----
>  drivers/net/ethernet/intel/ice/ice_ethtool.c     | 7 ++++---
> drivers/net/ethernet/intel/igb/igb_ethtool.c     | 4 ++--
>  drivers/net/ethernet/intel/igc/igc_ethtool.c     | 5 +++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
>  6 files changed, 18 insertions(+), 16 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


