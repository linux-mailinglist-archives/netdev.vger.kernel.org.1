Return-Path: <netdev+bounces-48255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744B07EDCA7
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 09:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF7F2B20A9A
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42B4101EE;
	Thu, 16 Nov 2023 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N5Dl/DHF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C4E187
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 00:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700122324; x=1731658324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vy8kdq4+neLfeSPQ4Q2uAUnqgaU6SPaZLFrE2bnBT2c=;
  b=N5Dl/DHFvF18n9vZcQ7LokKeEm2GVDe3OxvJUWIaRgsN7PMkjftBFfjz
   I0ytTYGzhGYrmLEJX67SzODbNPjCTIv+1FDXnalc4iHnnp7mKStycQizi
   jjXKnD0lf+xcjb+itSUUH4+Bx9KjY+r8dnYrRFY+y5tkv8VzdMaXud0XF
   PBebAGQgquG0qG+vDIKqx+4mwSEbMZPEehWjitcMpwztoMeG1KKi43Fiq
   ZWjLolBMC6ELrywBDpf+4ezlYn/YSulV9NfWNveyY3QBBkDjIMW0garjw
   tRooNpPZVSg6/qZcZh9FCgWssUpBfaesO3SwDZuScraybD9EFp6QGgOWb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="422131763"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="422131763"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 00:12:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="13035848"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 00:12:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 00:12:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 00:12:03 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 00:12:03 -0800
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SA0PR11MB4589.namprd11.prod.outlook.com (2603:10b6:806:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 08:12:01 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::b9ce:466:8397:a2c2]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::b9ce:466:8397:a2c2%5]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 08:12:01 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 3/3] ice: restore timestamp
 configuration after device reset
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 3/3] ice: restore timestamp
 configuration after device reset
Thread-Index: AQHaDrAefVexuPjjS0G3qhRwXPmrRLB8p7Cw
Date: Thu, 16 Nov 2023 08:12:01 +0000
Message-ID: <BL0PR11MB31222091F258C9FFEE783CA1BDB0A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231103234658.511859-1-jacob.e.keller@intel.com>
 <20231103234658.511859-4-jacob.e.keller@intel.com>
In-Reply-To: <20231103234658.511859-4-jacob.e.keller@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SA0PR11MB4589:EE_
x-ms-office365-filtering-correlation-id: b07d687b-f2ea-4c06-2426-08dbe67bb5f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l2Xe6gZBJ+NZXmiofbflIDrYEqBGkJT4pTsvBYpdLIYOnUBG1D6YkqT2chxrvlMQZWF9Zqf9+NvkvoAcCL2IkwPmcOKulHzH8Wjl3xBAtcnagS3+CBJla/YxVKcQz4S1q96P/y2n+gvzwliZnwhG5BphsgEGRizVdNT+nH+inYUzSpUxBJe07APjWh5iitME01C5evDypUfN1aTO2nJMhD87vG3vBiJddzW30PgmFSXzdeaeQfCdSs6n2+1BWCro/hbXNjAUXBAOGVWahyrEv0d0EPPsR/sq6mgRsoeAn7lShF6UEjL4AoxlbeSVullNLcCSgLu5fEjg9JXkqpAg+Cyp88t0DoFy4TB25fLjFokYY1UtVat7m16JxJn611+sO70MxIdI61o9w4gMRHO9l/HDnOu6qiE6ijK7dksMuE0cryUmVrWuz1rGbdsR84CM494Wlk5b0Jo/sHDiOwabqAZbqPx/+kYhjNFXxo5fsXW4wINzuxosmhguYAMZ9YMZHSb6lwKShqprzsRprwUbsUxoq/5oEXs7y3PJv7oPKX/QQFyBw9S2+7KkWVss0iTOlVRjfyfEM8yX94yg1QG+Vl9jYwnKG6ZmvVqvNzpNrENmQvJ7q+kyNPWGISTMlvvb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(71200400001)(76116006)(52536014)(4326008)(110136005)(9686003)(54906003)(64756008)(6636002)(316002)(66946007)(6506007)(7696005)(53546011)(66476007)(66446008)(66556008)(8936002)(8676002)(478600001)(38070700009)(2906002)(55016003)(33656002)(38100700002)(41300700001)(26005)(122000001)(107886003)(83380400001)(86362001)(82960400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fcHYJEVohPARuutNEHcBmUVdF9j3QKLoE/7TrXzr6fukHSWcYJ3wpnu/ucCZ?=
 =?us-ascii?Q?m1ojJFwMphX7DJhuz3c/HbXtSRSXFIpUcM+GNn4ZGqtdQlcLHealupIthcgA?=
 =?us-ascii?Q?JmRyapu0BRhq6AVWO1rdmYQWpZLUFprDlB3jx27VjzqpE/kvnQlJt/Shl6Ee?=
 =?us-ascii?Q?PBveLiGmCgsoVLSgpi0iDuVIsp1qiISikXkQEa2J5V+JRr9rE92qP3UlKem7?=
 =?us-ascii?Q?hGjn9L+GIy39Aj8ndDP8O/aGgc0/BV07yPw2VNHjBc7C1/+BUybs0mHFE89i?=
 =?us-ascii?Q?WlAgJOfd0mb+RnnGlMZgnCnlORtijzGE14Fpvg+4laDIT7twom6zoSbi0ai3?=
 =?us-ascii?Q?H/VYlHQ55J9bGCuZbxUAD/IRGd3tcUnATloFhuWoX9yRhbnxAVzvKnP3MOXl?=
 =?us-ascii?Q?Nt+4cRpJTtB0v6LCizLK0RCr3ecdk8QsTUtDLk1dVU+9InUqcCWmmlA90HQm?=
 =?us-ascii?Q?ud3YjZGdLJKO1q2IJSrhLkshcBmvFCD2bAuAT0ffvhBLUBnq8hQu7Ai+Zn8y?=
 =?us-ascii?Q?5I2VFgaiyyMzFYZq/xgQ+vZF2rnbyeMprqnbGz03+1OAruniTJvaJTYdrmB9?=
 =?us-ascii?Q?gvhXiVU5Sk76WY1ZAX+2Fcw0j6tY7M6L2TfKB4CZtRZ46CPWEBT22/vSRHSf?=
 =?us-ascii?Q?HIqgcJ+V25w6m2mRfTRfLsB01i+/GHP9bT/+eQf+sP/FVs44f90q18TRtl4I?=
 =?us-ascii?Q?o35LEbxYqY5YBz5Lu7p3MvujkMglJojc7N2rD35o8Ss51/wZkYY5p3kSL5G8?=
 =?us-ascii?Q?gY4XlHX6rNTf9gGT462WQcKiw8omzBVFkvvzxZd19G3BftCFsy1IjRDaVSn2?=
 =?us-ascii?Q?VTHS+jMb9B+TiUJEaf3gWrbpZ6xEO0fbPXVLfw0z7jUK4L+wnFgHXhOvKFiN?=
 =?us-ascii?Q?b+gEUqerdaLr0ShbBdDGn7AqkY7Pc8kI1I6qw/fnahRfJMqjRSgZj+SpAIqd?=
 =?us-ascii?Q?vh0QOoNclA3B+4fHmMCCR5cHzgZe280LTAzaTRPzfcWDom6or0t+XgwGiDns?=
 =?us-ascii?Q?f/p+Hw3zgsZ/S4kGYnu0iNXwztDKwjjctDFjeJxo1HxwQ6M+95L1EmAEIYlQ?=
 =?us-ascii?Q?GidRrOK3XO0tHR++Uj0Qs6O7qx7IroCUwQvcsiRWTPF7HD0z+qx71bEQgqo7?=
 =?us-ascii?Q?QHpfr5zBoXsiTnfxie3qwNcXVcMyXzvFzo23XjdzTvZR+cliDQ18opw3TiZl?=
 =?us-ascii?Q?BHe5E5BpcEKGWGr6T+g2N1bdJFmFQTeiN0biq9weLPFms7m36ejwTYWkyY2K?=
 =?us-ascii?Q?Qik6oCDnSp8JzzmE0zKwqXh4cEIlVMQSOO6cpsA2DdBufivTSTd2NM8CYf0R?=
 =?us-ascii?Q?ATt3OS+/XGlDR50G6+pNV12XqvvSMLagiNfatRbp/D6kj76jfq3vSWVF3XKd?=
 =?us-ascii?Q?HeNpiJmQ2sRme1XDdOPfveGR+5MqO2TwGIiNK2CidXZkErNuC2DzgNh2VChB?=
 =?us-ascii?Q?QbsYhtPdoP5secHP+uJkmLoDW8CrU9sd8FUUnp5YSH2k+XiG37PxT1wd+ST0?=
 =?us-ascii?Q?eOyc+u8FDZ2CEt27QzveL+q6mSZkhxRYtrbKwA3Bb5n8B2sHaSh3Ys1fh76X?=
 =?us-ascii?Q?mHyF9UglvA9ONavte+Pt+Pn92IXqiLq51hHyVR+0XaJpnfe3CbycaI7c5WZ1?=
 =?us-ascii?Q?Yg=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtAo0NRMGVK585t75n0H/m59HJCNWzBUBcp6wzlJSO5V3qBNiQwp5TOBDiIzzmqDoTTDvlWtmbKqNQ3lshG+d2kOJaEpGRtoZsRQrB9rA9VhWY8zHralyeih7G58m70hTLsCJsQLaGlqGo/56n/RWm7NNwtH/Te7eSxPidfU1Ju3MWhTWYCwz09lYbpORo+CfbzxOrGZjLmlIpiKiPy5j/5wWWmkNUCqv8bwhyndQf0AMMgXClfvJldudMrqXBKFZzA2bR+/Sn3YRDOOK6i2JygimzrvYOH9Ihhxm+d0Dw4nyP/59F8mDiOslgQMnSZJCmDnBKYhEPZNDzROdOwzUw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVVWkVa4COlogZ0TPFE7k7r5e/D5cp/2grUIi4Dzw1I=;
 b=gNsrKni47+TYjZCjnHbOv80CfK0ZwmhGEBoUK8SCDKUy94Q+tZg1BolKCl9EdebUbEDPYKsKtMt9p5MV5k5d2jhkF9wodj8xIg3X4Rf78PvbYh1BTfHhDrhOzBth498vSOUuXDS+qTI0Abj8bRrZxzNTNQrtqXBbsEqSaNs+S05+ph3Z05RnHauxdAmNqUEiUgGKYVHVFCgvMkSrLflJj51sceMRwTWunlkBLcaTZBQewlWEFWhoYoYFYBRnagH3LCCPfon+COLg3CoSfclsSyM+BHWrv5Er24rgKkASNy68cJnhdt8IBUUS01BeegXQn/Hjka6K4UOBzcAhY13diw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BL0PR11MB3122.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: b07d687b-f2ea-4c06-2426-08dbe67bb5f5
x-ms-exchange-crosstenant-originalarrivaltime: 16 Nov 2023 08:12:01.0572 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: qfaPE58xk7+HLBHlhJeMBPlb4PrxfqUB6BgpnugXilOi6wDEBQ5Z0b7nrzG8sHyF/pExddJ4fTfD6mFqzDDBdkd+WSTQrKVtW6MJL9l7RhnosWa/wnA3DK5M/Is30oeQ
x-ms-exchange-transport-crosstenantheadersstamped: SA0PR11MB4589
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
acob Keller
> Sent: Saturday, November 4, 2023 5:17 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; netdev@vger.kernel.org; I=
ntel Wired LAN <intel-wired-lan@lists.osuosl.org>; Brandeburg, Jesse <jesse=
.brandeburg@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net 3/3] ice: restore timestamp con=
figuration after device reset
>
> The driver calls ice_ptp_cfg_timestamp() during ice_ptp_prepare_for_reset=
()
> to disable timestamping while the device is resetting. This operation
> destroys the user requested configuration. While the driver does call
> ice_ptp_cfg_timestamp in ice_rebuild() to restore some hardware settings
> after a reset, it unconditionally passes true or false, resulting in
> failure to restore previous user space configuration.
>
> This results in a device reset forcibly disabling timestamp configuration
> regardless of current user settings.
>
> This was not detected previously due to a quirk of the LinuxPTP ptp4l
> application. If ptp4l detects a missing timestamp, it enters a fault stat=
e
> and performs recovery logic which includes executing SIOCSHWTSTAMP again,
> restoring the now accidentally cleared configuration.
>
> Not every application does this, and for these applications, timestamps
> will mysteriously stop after a PF reset, without being restored until an
> application restart.
>
> Fix this by replacing ice_ptp_cfg_timestamp() with two new functions:
>
> 1) ice_ptp_disable_timestamp_mode() which unconditionally disables the
>    timestamping logic in ice_ptp_prepare_for_reset() and ice_ptp_release(=
)
>
> 2) ice_ptp_restore_timestamp_mode() which calls
>    ice_ptp_restore_tx_interrupt() to restore Tx timestamping configuratio=
n,
>    calls ice_set_rx_tstamp() to restore Rx timestamping configuration, an=
d
>    issues an immediate TSYN_TX interrupt to ensure that timestamps which
>    may have occurred during the device reset get processed.
>
> Modify the ice_ptp_set_timestamp_mode to directly save the user
> configuration and then call ice_ptp_restore_timestamp_mode. This way, res=
et
> no longer destroys the saved user configuration.
>
> This obsoletes the ice_set_tx_tstamp() function which can now be safely
> removed.
>
> With this change, all devices should now restore Tx and Rx timestamping
> functionality correctly after a PF reset without application intervention=
.
>
> Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
> Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>  ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 12 +---
>  drivers/net/ethernet/intel/ice/ice_ptp.c  | 76 ++++++++++++++---------
>  drivers/net/ethernet/intel/ice/ice_ptp.h  |  5 +-
>  3 files changed, 52 insertions(+), 41 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


