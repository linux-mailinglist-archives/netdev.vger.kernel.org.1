Return-Path: <netdev+bounces-282805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBMDC0k+82kGywEAu9opvQ
	(envelope-from <netdev+bounces-282805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:34:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 963414A2358
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 808A0300668D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A8C376492;
	Thu, 30 Apr 2026 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBeXTSPG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50CF25A2A4;
	Thu, 30 Apr 2026 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777548837; cv=fail; b=q2dTIfyTM+q/hHcXhypRq85+u7saHjtel24n89ATpPqQ49Sj9qInkA825jbqG+FyoDWtUl4GIUzV+wNoAW0sIf/LdkmwhCpoijI65fisTvzBGe90A86hpwHDeqnSQ5bcndd3bxxBOLr3S67aD91ueN6f8l/ZL/gvjxuxC9iThJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777548837; c=relaxed/simple;
	bh=GFiNv0GNeOVzy6SVXcKHBNMuNBXPx1Zh57bYeLgw7Ag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kIPEw+tFQgzluBNG02FczjDR482eenXnolFtghOnPaDXT0Fp6dEk0WCOu8vSH4q/ohYrcT090ZjVNHI5EFwr9gYIgb+e4mN0QlB5BgoX1z6S1JkaIJQJwcN10tZ8xVEUt5NjihE19qOy/1js41hVaAbuKYCtGO2FUui7ziSRSO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBeXTSPG; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777548835; x=1809084835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GFiNv0GNeOVzy6SVXcKHBNMuNBXPx1Zh57bYeLgw7Ag=;
  b=gBeXTSPGSPoflq18FavdBvYjj00uQYf/hJPk2UsER+gfGJafWyCbLgWW
   imGaPKTKT4Rt49Etg2rGKp2ZmBHe/Hi4FbJqiETNvhBoFkZ5/ddT1vcSP
   6DW1gisiBiJKReJXwu/3TvgPcUviGNiSgmzItfgvxYw2K++b4WGKtq9v7
   HGVMn8UOXWjLAMkU6bS2DUM0znaUl6X23/2hYA3Ox56n4n6ZyfmOB4N/G
   nvNv8PwyMq8Mx89OqbFARSBBhysjsrpkmH0B5KjEuaghTm+SBiqE2Zas9
   r+c78wMCeJh6Au08PEnrI4cnl6FA9krpgVdfED81w+eKJO75PAPkW5Cha
   w==;
X-CSE-ConnectionGUID: ++Pm43ZwTGay8V9WJPTp0Q==
X-CSE-MsgGUID: SiSiinfERy2+k4SxOoH+Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82361177"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="82361177"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 04:33:54 -0700
X-CSE-ConnectionGUID: AhDTr+8NSc2UrI6yK9aFxA==
X-CSE-MsgGUID: mX00sy7tTdOZA4UDEvEgbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="258134981"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 04:33:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 04:33:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 04:33:53 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 04:33:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jjp68EDX9LS5+BRmjjMtHJPW8Xo4E2Po7yR2Y/pzZVZHZx0XdBytasdMZIQn1kBXT7GphZvwLKKPx8pwG+7qiOoHplAd24G1eEIW1T848A4BDbFDdHDben1WsWmOAw14WLhDNEuSGrAa4b3o2zrwfYmUqZN5XwgqqmHC6wvCw0Mxzy0aYfX5Di3koP1QQSa3m2SAoncK9rmbsoqUAH3c6Jh1YPVk2Cj9yoZFv0+0d2v/jscc3HcRT5YEmcb91DGPoUWmf8MxMXv+Fof5BGd0UuOOvf+w6P0qFkDZF1T3kjJdhkLtdMKsDGftJt9f5tQiKNYPwdYdWPTztjUcOF8FEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWaBI/aeWOOQRrqVrG4CraeMhK1Ypvnp5Wb3Rf91cNQ=;
 b=L8hhJo2FJEzftfZZj5VOY/Km2CEZTjjaPtsryoMAc0DA7Qp0kzSKspH8kgNQ6Hvt8gS2B40N5eInBifeA9qoIIRXxXp3ZsQFd5HClW8LxrOf6d/pihhsR8KfHJVO+FtfW6Mf4ga/1hFQWqugE/dao4bcGm9hK7KASNjyodq3GFLTz2mo3cfAxiVda1Kmpb5VqHTpxmn5dLgvYZKpNvUVtlTWszABkIQkfA3naKofTxqC7uoW6Uld39uQi2jCMNdCKFJacBMuRsdRvBQq8CnAHt89w6apBX6k94zcumZIUYr3pTUyle3lUzgu78U3zZ4KPAdrmMBM0UXYLp7w/HLr6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB8009.namprd11.prod.outlook.com (2603:10b6:510:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:33:48 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 11:33:48 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "kuba@kernel.org" <kuba@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "edumazet@google.com"
	<edumazet@google.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "horms@kernel.org" <horms@kernel.org>,
	"Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v7 net-next 8/8] ice: implement E825 TX
 ref clock control and TXC hardware sync status
Thread-Topic: [Intel-wired-lan] [PATCH v7 net-next 8/8] ice: implement E825 TX
 ref clock control and TXC hardware sync status
Thread-Index: AQHc2IZvbYDkxcc490Gf74IrxYpNULX3eNFA
Date: Thu, 30 Apr 2026 11:33:48 +0000
Message-ID: <IA3PR11MB8986091E5036AAD76172909EE5352@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260430094238.987976-1-grzegorz.nitka@intel.com>
 <20260430094238.987976-9-grzegorz.nitka@intel.com>
In-Reply-To: <20260430094238.987976-9-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB8009:EE_
x-ms-office365-filtering-correlation-id: 89dde237-9fde-4cb2-926a-08dea6ac586a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: WsqhKr4umQkJnPg0K77kRTNAPiE0f8P72GoadBaaXmqGXRRaXxrm0HYv4HrXyHYoCjPiKXWNKK9K3SjEPiaFuQrfXChEifrtbxiqYzjWaAFyjwUuTcCgyfWuc9iTQwzvqQAzRTnNjZoDhwxhtNhgsK0NjL6/2Fd/0TyfEq83V0KI5uf5QzlGXucwrIVgKYIX1o23Kw5Gyw+5EfWNpxZ5KEFvuXWMkJtHiLxF33o6n+ZbWfZSzEOHNh9X/WiJPUDA4sWiET2Y7wurQ0oa9GvH7Tau/eqTKy9zNlMtbI5J9CIoENOAGZgy4xWnTqBa6HeO5lf14dOJTwxqyasANdm9K/WcmttB/ZGv/2X/X0O2iTSDc7QAQoQfAwyS4SmiKSDawGWgQEfj++nevDrz8ZcS2B5SUaDZHGHKr+HmCvn/CMpDxl/DYG3Qc66vxLKXQ8KiJ3FZ0XHSwWw6CCqjveFesAuFd7p97TCB8vTQtEU0Vwpl/APf9IkmvnQD9gFZD8dhFDtkY86aLtWRY/4TUFZ5cTles3PbyH6w8xEZk0wfXASP4PMJTtMnUilFbemV6r6dRR+vYsSyFeMyIBjJbCYIMYPLLSO1yYefhNCkmmywN96Vf3aj2K3SsKwn3/G4y/LIiydWGj11k8ZSmBWIwx4xt0z7Yw/aKrH0Mnq4PM1vejemXm1TbzbDmsCIrCl21UyD+HYAXmhIOca1wlOhyBnsX41iQ5Qdb8kXQpz/kCw1f6mjqu/qj+MlyYIKnJwzanahWRMniEb1z9dNonU7JUOptNlnhNoswCbzoxNhuDu+pZg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gb4uCdmAheMbhs5dAbBBHC0dwtpVgS5Vef4SoMtcX0k0xPON6hu9KER7FiDE?=
 =?us-ascii?Q?N6BQyuO+hHsfYRkaW73oDQFKx2sQvJ/Egh9bolTKs/sMyM1OzXjqUtm8yeVF?=
 =?us-ascii?Q?+q826ZeJkILq0sz4uH/r/k8hbj++zd9qTFQ4HFC7cvFLtfFynterRu2fSlXM?=
 =?us-ascii?Q?ix6Iv9AB/JWIP3UiIpFo0aOfqU2sXd4OSLgOtq9sVTiXwhsdLvEvZXAyE4Sa?=
 =?us-ascii?Q?IKSsqRBePsMK2Z9+6VJdcJfP8CuyHU2NqpFdSr55mjhWd4OTPtPXgAZaZWWe?=
 =?us-ascii?Q?oB19tALHGI4G7A1KDi20IEd9djP4wrlOyIGHHQvATx/FcKFv8mVd9que1FKW?=
 =?us-ascii?Q?NOT9kziIxZMrjXZhA/rzNXDD7WIcKCELB3mDajVXa+lq7vEjOKtnhNA0D2ws?=
 =?us-ascii?Q?FvdRxbLDOBIU1pcRqANiKsB/JJ6IrkEYHl/KsAylKi2fKJTL5VsjQvRFZCdN?=
 =?us-ascii?Q?Sfb8ekrHzUoqJPNAim7ZCkq/cTe8qhH6S/US7UMD/kusKaF6y8TPQWPsnM6t?=
 =?us-ascii?Q?ujInZTyuhA+mJy3TfoSirywF/sNriBfeQn/qM2Zi+44WqFz6RGb+TC8wbwrO?=
 =?us-ascii?Q?SajfJbZxZYMoi4dl5xy925DArLvOdHcYU2dahxvIOuOmTUz8lA0p5VR7GsdK?=
 =?us-ascii?Q?WVoZK4nO0WAVV3rvZJ/+GbHOufwe/ABq2rb4ay1RLfNC+zf8KTMSai448ja5?=
 =?us-ascii?Q?Dn37VHae5tlMX6CxgT8AeuUe0GRF01AGkF6lxz4vcDsB1fEXpfWxaw2VEHir?=
 =?us-ascii?Q?rAVQqSPX7X2GoeOdbnbAPFSkaZ7bXR/UuLxwXD/+Y8v92A8eO+vAkdM5qRwp?=
 =?us-ascii?Q?dWVnQR5eLHSrSfZ7zJGiFBI2gJJ1vgw2XHBAlrQcTlO/Oox6fhVBkg2n7B0c?=
 =?us-ascii?Q?DICVKiBcLS4OEhsGmdVWSnlLaJSL5zXPehF0LsqnWJ4uAh8QMYVUJhKrHPBd?=
 =?us-ascii?Q?cwAlJfSOaWFqFvoKHJnLs3imb8QvUrTeuqiMMtoL5dcyStllMZTrgCIEetbQ?=
 =?us-ascii?Q?gofZOi3BJQbe3PbgePXObR2yXadFT9Hu5YigHBRGDRMqFoH68CK3PdSEbKZp?=
 =?us-ascii?Q?GTp2pOMwcbgwU2LsqToXi2GuL01XwjkLrte5WgDNXuhwoL6Y7iIEKFpnbiQ/?=
 =?us-ascii?Q?8z/o1BPctTwxSxHAWjlPSs9GI6gYxkA2wW4p3FrzQ1JmID9SFzH7JDYBwU8f?=
 =?us-ascii?Q?rLsF98HOBUtf/bQVMoEF46/vZtoNWdy0PrN2Ni1NhpyHB1v9IGObIlqRuKRP?=
 =?us-ascii?Q?zFmAZq7u1Ga2pfnz3tybN5n1QZsxw/YkYGHMZUzYAAeQfMoYtEGDIwnslbHE?=
 =?us-ascii?Q?mKz0PDVAzlBQh59/crrAZ7Scul70Zm+9nISW7P6eJ5+broJ+5xZqPCLueF9j?=
 =?us-ascii?Q?g84kGc9dN8tSJnGyEzxnAXlol4jy2egZlhJDglwWBL9lBWF/ZP1hhndjpMRv?=
 =?us-ascii?Q?SS30zzX3RUSEnZ7vLA6s3AJVUpyUI1tu8dH7+dzieGD46eZVUeO2kPQesQFo?=
 =?us-ascii?Q?xxr4vDAjs9YupZ1Kvqip00tMf0PUJ2tELL+YD2EvB7Z9JfLVTJReNAYwRNZw?=
 =?us-ascii?Q?jEwyxYgfI7HOCAi07d2jFOoYjJybUUr1dERnUO3Qb7l0vXFWomqlEFHnIbHL?=
 =?us-ascii?Q?eMgVBX9t4PO3XSTE4KSvKPt9ibxINUv9cLwP284tdzOI4XJkblFXtEfJxApL?=
 =?us-ascii?Q?U82qSO4HM7t/QyiHSDeQYBh5eDcBIcG20nr4xgkNp/oDlrpJMZVwKOXnStva?=
 =?us-ascii?Q?lQuyPagNl90HeaZ+wDJkysv4sdQTz0E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k3Ef7vsrSpu4QX2SCCn6hP6yOFz79BPqDY3UbYpLEDlcGvDq4uXe3dtyJerrtXbF+tcyLo/g2SDWBXPlqDx2bh22l0ym9RKJSV+Y6k2seddQDVar8PKl4PabuzgHd+gE9PJQP+I07BBdQLh3QwHr09dQbMh+0dtEigj35zM5/LhQrva+ajNp16SOgtKkunhu9WrBaa5/96w2kuUeJbI/BLb6Qnlw3MxzAzo90UmBxfXvEuUI/W64rMSEbEDoywrtq/A6sVeU9ApyC5vabWnUIQ/pGbWI9IHayT2RYxf1fG1+Z4GnOJOUEeKhlAO7eDBn6n0MZ+AesQ2cGLqQSP2swg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dde237-9fde-4cb2-926a-08dea6ac586a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 11:33:48.0717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8r9+b/0M1yGKvNcSuGZf1V5Jk7BsHHMYmOy899Wkx67KO6ciFojcWYJ9VbT+Y7b7iJ4Qo6YRNYQa4uuDLD1YJ4vTnYTs6QWUdku2lELnvP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8009
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 963414A2358
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282805-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,kernel.org,resnulli.us,google.com,intel.com,gmail.com,vger.kernel.org,lunn.ch,lists.osuosl.org,microchip.com,davemloft.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Grzegorz Nitka
> Sent: Thursday, April 30, 2026 11:43 AM
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; vadim.fedorenko@linux.dev;
> kuba@kernel.org; jiri@resnulli.us; edumazet@google.com; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gmail.com;
> donald.hunter@gmail.com; linux-kernel@vger.kernel.org; Kubalewski,
> Arkadiusz <arkadiusz.kubalewski@intel.com>; andrew+netdev@lunn.ch;
> intel-wired-lan@lists.osuosl.org; horms@kernel.org;
> Prathosh.Satish@microchip.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH v7 net-next 8/8] ice: implement E825
> TX ref clock control and TXC hardware sync status
>=20
> Build on the previously introduced TXC DPLL framework and implement
> full TX reference clock control and hardware-backed synchronization
> status reporting for E825 devices.
>=20
> E825 firmware may accept or override TX reference clock requests based
> on device-wide routing constraints and link conditions. For this
> reason, TX reference selection and synchronization status must be
> observed from hardware rather than inferred from user intent.
>=20
> This change implements TX reference switching using a deferred worker,
> triggered by DPLL TXCLK pin operations. Pin set callbacks express
> selection intent and schedule the operation asynchronously; firmware
> commands and autonegotiation restarts are executed outside of DPLL
> context.
>=20
> After link-up, the effective TX reference clock is read back from
> hardware and software state is reconciled accordingly. TXCLK pin state
> reflects only the selected reference clock topology:
> - External references (SYNCE, EREF0) are represented as TXCLK pins
> - The internal ENET/TXCO clock has no pin representation; when
> selected,
>   all TXCLK pins are reported DISCONNECTED
>=20
> Actual hardware synchronization result is reported exclusively via the
> TXC DPLL lock status:
> - LOCKED when an external TX reference is in use
> - UNLOCKED when falling back to ENET/TXCO
>=20
> This separation allows userspace to distinguish between TX reference
> selection and successful synchronization, matching the DPLL subsystem
> model where pin state describes topology and device lock status
> describes signal quality.
>=20
> With this change, TX reference clocks on E825 devices can be reliably
> selected, verified against hardware state, and monitored for effective
> synchronization via standard DPLL interfaces.
>=20
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile     |   2 +-
>  drivers/net/ethernet/intel/ice/ice.h        |  12 +
>  drivers/net/ethernet/intel/ice/ice_dpll.c   | 110 ++++++++-
>  drivers/net/ethernet/intel/ice/ice_dpll.h   |   4 +
>  drivers/net/ethernet/intel/ice/ice_ptp.c    |  26 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.h    |   7 +
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  37 +++
> drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  27 +++
> drivers/net/ethernet/intel/ice/ice_txclk.c  | 255 ++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_txclk.h  |  38 +++
>  10 files changed, 499 insertions(+), 19 deletions(-)  create mode
> 100644 drivers/net/ethernet/intel/ice/ice_txclk.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.h
>=20
> diff --git a/drivers/net/ethernet/intel/ice/Makefile
> b/drivers/net/ethernet/intel/ice/Makefile
> index 38db476ab2ec..95fd0c49800f 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile
> @@ -54,7 +54,7 @@ ice-$(CONFIG_PCI_IOV) +=3D	\
>  	ice_vf_mbx.o		\
>  	ice_vf_vsi_vlan_ops.o	\
>  	ice_vf_lib.o
> -ice-$(CONFIG_PTP_1588_CLOCK) +=3D ice_ptp.o ice_ptp_hw.o ice_dpll.o
> ice_tspll.o ice_cpi.o
> +ice-$(CONFIG_PTP_1588_CLOCK) +=3D ice_ptp.o ice_ptp_hw.o ice_dpll.o
> +ice_tspll.o ice_cpi.o ice_txclk.o
>  ice-$(CONFIG_DCB) +=3D ice_dcb.o ice_dcb_nl.o ice_dcb_lib.o
>  ice-$(CONFIG_RFS_ACCEL) +=3D ice_arfs.o
>  ice-$(CONFIG_XDP_SOCKETS) +=3D ice_xsk.o
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index 725b130dd3a2..f72bb1aa4067 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -1155,4 +1155,16 @@ static inline struct ice_hw
> *ice_get_primary_hw(struct ice_pf *pf)
>  	else
>  		return &pf->adapter->ctrl_pf->hw;
>  }

...

>   * * negative - failure
>   */
>  static int
> @@ -2547,11 +2586,29 @@ ice_dpll_txclk_state_on_dpll_set(const struct
> dpll_pin *pin, void *pin_priv,
>  				 void *dpll_priv, enum dpll_pin_state
> state,
>  				 struct netlink_ext_ack *extack)
>  {
> -	/*
> -	 * TODO: set HW accordingly to selected TX reference clock.
> -	 * To be added in the follow up patches.
> -	 */
> -	return -EOPNOTSUPP;
> +	struct ice_dpll_pin *p =3D pin_priv;
> +	struct ice_pf *pf =3D p->pf;
> +	enum ice_e825c_ref_clk new_clk;
> +
> +	if (ice_dpll_is_reset(pf, extack))
> +		return -EBUSY;
> +
> +	mutex_lock(&pf->dplls.lock);
> +	new_clk =3D (state =3D=3D DPLL_PIN_STATE_DISCONNECTED) ?
> ICE_REF_CLK_ENET :
> +			p->tx_ref_src;
> +	if (new_clk =3D=3D pf->ptp.port.tx_clk_req) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "pin:%u state:%u on parent device
> already set",
> +				   p->idx, state);
> +		goto unlock;
extack message attached, but ...

> +	}
> +
> +	pf->ptp.port.tx_clk_req =3D new_clk;
> +	pf->dplls.txclk_switch_requested =3D true;
> +	queue_work(pf->dplls.wq, &pf->dplls.txclk_work);
> +unlock:
> +	mutex_unlock(&pf->dplls.lock);
> +	return 0;
... function returns success.
IMHO either drop the message or return -EALREADY/-EBUSY.
Or I missed something?

>  }
>=20
>  /**
> @@ -2563,10 +2620,21 @@ ice_dpll_txclk_state_on_dpll_set(const struct
> dpll_pin *pin, void *pin_priv,
>   * @state: on success holds pin state on parent pin
>   * @extack: error reporting
>   *

...

> --
> 2.39.3


