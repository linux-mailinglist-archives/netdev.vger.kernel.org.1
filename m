Return-Path: <netdev+bounces-288293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J4NIgUVB2rgrQIAu9opvQ
	(envelope-from <netdev+bounces-288293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:43:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4D354FCF9
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC9A8308FC3A
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C7647DFBB;
	Fri, 15 May 2026 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/XpuVVN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B87D3AA507;
	Fri, 15 May 2026 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846114; cv=fail; b=FCVicolxI8kF1Ey/jVuuJujGwPh+slWrU2wArF24yUYDEWsXuZeMRDCF+sH8S5tCOJVoLipRE/MRUFKxWd8dOifZFid1c1FdPNQlvifHH9Tt4e80Gw2CbatULk2pMQFK80MNCNDx9O60LUL4O2xnO49DU7/HLij/CCuGwxLKe48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846114; c=relaxed/simple;
	bh=aY2EtuhXuiK3sWnq56OlvCTTeYRSEp2hkgbZOvAfm3A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=awxg4ZuKx677Q+XzjBcyebrwPyDuvlhYcmRVe333xcUmnHMxKUBnNMaI8xc+nq/rpFUIRrK4Lt1514I1XL/RU4L6mJ5bX+AeDx+LhI+eyF4bW1IHwMqtvSsywpbenUUVCjj+gYm4gjbbsSMZujIrO3KdwuYqPhgaYJrINfyQr5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/XpuVVN; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778846113; x=1810382113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aY2EtuhXuiK3sWnq56OlvCTTeYRSEp2hkgbZOvAfm3A=;
  b=m/XpuVVNANajxv0R9vrMle4iMPyfQd2xopQinUO2ABCpd5+G7wDG2/U/
   CJotbONYeLOfNDq4QKjFD1foOB6oId/Px+1SfZ00bA7ezBlrmY6gaUOuA
   37G1hWZkxfOaPFeLDkP5cYYP1DuNMAskKVHHSR6lvJ3EAlVDgwksDlA+j
   jyIdHqQ6BYU6HHOfIcuP3G0N21Sjraw+IWJXxuY540TqfmA+6GuvBZE9N
   PTEA/b9SSmlkGLTFZ04WV3xSrrciyGmBGE3PiRJZjBcgZC/FfvYnh6riL
   lvpDXiVI4TgrswALavndMDp86miJjfb9rySGpv4riDEoot7msJC99wdMX
   A==;
X-CSE-ConnectionGUID: 17wx6JLQRQa7jFu5e/M1zg==
X-CSE-MsgGUID: YsTRs/6ISEWCaIzANVw0Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79693668"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79693668"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 04:55:12 -0700
X-CSE-ConnectionGUID: E4Tvo4iGTvqTvGWFBvkvQg==
X-CSE-MsgGUID: jwqLXDrFR+y1ZPiJbYScvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="269024005"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 04:55:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 04:55:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 15 May 2026 04:55:11 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 04:55:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AU7SsvTvyg7JKIZYVbgvAk5eDQCqvmsLA9Z/z6yAubJZyLUBGfNW/+kRitcq5dZv9RPUJCOnxljy1HCb2iY0cMbizSGk1wD54ZHG3k979SnATi/upI2vflaRpdUKfVolnS2I9A5EYsDGf0eYpbGiSRGBMgFZdk2no+DhFjDBjjgBNxkOapyUEReboNiqtIKyqMzT6eJ/hExp/F7NDubkSJg+rZ/wO0QyGldfwPxP29f6F+Dp+ldcxTpbo05GY9VeQ4RmxleROgB77k6P6tV42wbSiJ8Ijkj3YJXWVh8coCtP+ZSVneXxE1MnxEKBeLa511BCj3HGUbnQxl/oT/VtPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMSL4ZvvGUbDsn9hDjStoMRzaUzyiFApom9hrY/m084=;
 b=XeJON2/kQOwDfBY9EdWRUJgpQVPAy1RwBtbQ6oPvMuN9JDgiDxFWcKojArEDGBugB6L30ZxbF1CK7rEEqFW1LbqZcU8krAIEgS1aunwrHU6F6hw9F05P/qDZuybP/JXVUPuqPSW0+gWdJFxCIiq7cO6O7SwpNEiZJCJVlgmv7cgNt2V7hPQ+i+t7kgPqI4X53d4XmhpSH2dSGjeEBoTuBNWrBM95ySalu5tcK9mX9Iam6BaVUIbN+LcAAD8f3Cqf8/sHZlH5RTPoTDkbgWjc9IMphneMWOg9GEs72LLH8ZUK+GfAPE+De3TGeePMk99msIrEBUGILaApCyuREjWEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CHXPR11MB9652.namprd11.prod.outlook.com (2603:10b6:610:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 11:55:03 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9913.012; Fri, 15 May 2026
 11:55:03 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH v9 net-next 1/8] dpll: add generic DPLL
 type
Thread-Topic: [Intel-wired-lan] [PATCH v9 net-next 1/8] dpll: add generic DPLL
 type
Thread-Index: AQHc4/YPiT9hePMErEm0Y5We4c1Eu7YO+1DA
Date: Fri, 15 May 2026 11:55:03 +0000
Message-ID: <IA3PR11MB8986D0C908B4621D0BC84504E5042@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260514225946.2885623-1-grzegorz.nitka@intel.com>
 <20260514225946.2885623-2-grzegorz.nitka@intel.com>
In-Reply-To: <20260514225946.2885623-2-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CHXPR11MB9652:EE_
x-ms-office365-filtering-correlation-id: 58a484ce-6eed-4a50-a177-08deb278ccaa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|4143699003|22082099003|38070700021|56012099003|11063799003|18002099003;
x-microsoft-antispam-message-info: /RIit4/3yJ4qqjSm8neB1o9jh2Rh3+UUa/Pox9G3PrzHSNPkNMqYHCj+3jO1XYcYK/DvbuPwDy97zMb+AkzmhzODQ7oBbjOd4khRDtcSuRm3YPPZ2GlBlfkg4g7Nmtk2EvtVD8HnxhEahCFR/yAa9TSk355+cqHClTtTUakBgxuw1u5q+wSlejC8mGa0qSaXknFe6cKSdglOltwVbkjl4UlXtV7+2s2GM1BhkkOmVTWGZBRWe0OPLK57m/tWKkvonodb9XGeAwnR2ahVhbnJMKJU0CE8HhMjwYvQx766QnaZnXJhwoFLo8sudF6wjX13LyNE+UusGa2qg5le7Gedxmt07BgmuoQ/oFzuOxBcB37GD5Si4M+t8AIX2PxIWoxWnauqtHqgb/VR+LRFJQasBh+UYcHtCrA+9MMo5awHxH0sK0fZzknowp+EQuHCmGkM6hDnwKtE9HZ3U6twERFVi5orbR6p5TvIBQPQ1CWcasF9lzW/IoM76c3AXrp0T/bOpe9gdWTlV/VKHTukZoMmFawgLNQCIYCzHRFWtzvC3gSOyFh3YrZ97XBDMuxeCQgluqryiUdsTkpzFSCBnS5XpLHFY8p5AtMLVatEHImM+Yu5vCrMHGmz4lpV3o76j/yPazdYIZB+BRXsTYzgA10rH94hk0VrdX4Yt38Zch52zREDlE0YC6vW6MDJXYm69t0xmzCAdNwBiuLTP9QmZzc38dX5O4Dt4QgpgW9xICpXZsBmsfVhx2xAaTk9HnL4D7uC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(4143699003)(22082099003)(38070700021)(56012099003)(11063799003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EMKJ1yz4jQ1/WJ75W88Sovce+/8J04vVfnoE6k85lnq1yJRn5aRr1PGCuDfM?=
 =?us-ascii?Q?UG0WZ1fDK8X/pxfq6ueknaWkbvZgxQgWw1OTZW2+Nz5X69Emw11MJryDAmiM?=
 =?us-ascii?Q?Ew4MWAGXM0U2XI8HfE7Smf5BB8lE8kclxfuhUPuGEd4Wv9QxECjpYTxteRZo?=
 =?us-ascii?Q?9oqCcxBKYDGaX6hNjVKhb3OGkQdMoa+L9HI7yjCO2INgks7A4MgiQ/rjuuMK?=
 =?us-ascii?Q?jOtMbHzM0dxorFrLofN7Ovh3IJrjDzZlNWCVbkbUdwIc+jT+896uMaFZZpSD?=
 =?us-ascii?Q?lOdOZMw95/tt2jfse25lvBtDu6Z4RvbVgysCg5AMtgIDgxRCwVhRAQZDl9ej?=
 =?us-ascii?Q?8XkE75JRDVlqXEtdThXY0mZWIFPYR7tZE1vddBD8oGpqsnkEBT3SKhGUCmmS?=
 =?us-ascii?Q?ELcafx8ekDpOkawmFbCq7FPYt7OXfenLppA7cmF7j6KtK51vhxc/uLotw9Bx?=
 =?us-ascii?Q?AgivTaiaBb4cx/HUUPdZgMNPgFCaJo72EYH8ps6/e2eVX7AXBW75+LD+w0sm?=
 =?us-ascii?Q?XH2kgpK5/6/1v70z0esOHYR5DNJTgE2OWcppZpzGDzqmO8yl5b36DPsKRX6s?=
 =?us-ascii?Q?VxXjqPLQ2+XsVLfGE9H56T2Y8iE1fDBL3E4f+lwS8XStpxoA9x74R0h+XC4E?=
 =?us-ascii?Q?n0Jd5/yYTwH3K8dnGE25Fl2dYMzbYhZDF+y4KkYFTOXIwjtgz/pxF3ah1a5E?=
 =?us-ascii?Q?4VU2Ht2CiNeR1EalNGUDnaj6wuvOcrjwCMA0gPGQ4iPVWV4eau7mFE0oNBor?=
 =?us-ascii?Q?i6G2VMyN2dsRdBdtt3r91w4BeqUhj2Jqiu+UzWiO9iM1wZqU7iqKwEdwRR+j?=
 =?us-ascii?Q?/AP5w39UrRLu+v+Ut+xMUmWY6FPKW+FslZmwIZAt2etVJmnUcQRWnQ34+q5B?=
 =?us-ascii?Q?40kUM78ZZToPFWVhwAbYrVbL6BtNmDnQgpv506YH0oYBHG5EDLz1NMYk0OUC?=
 =?us-ascii?Q?OFfJ7SJ10eEUXAVipRO6JBfqDXsXwaM6DgiYRIgmkT5ZjcI/IWQ+cQupslR0?=
 =?us-ascii?Q?/cJLh9k1QnsT4EnE4lFBZ8M5j3PmUTvnBWP8LVi9C+J8y+QXLXqxMTJKTjVr?=
 =?us-ascii?Q?3/7hYFrgEZnytlulq8+MhIAalCHTfW8RXGG83RyID21lU40mBGjrmLftmE0M?=
 =?us-ascii?Q?WNy/1yZLicUiWNs7rVSs1PTYDeK12Qci8crmViveAAzmxUN6en3KVcJhqHfp?=
 =?us-ascii?Q?BpAoQ/PUTzTydSxkpudzckwWhhSWVbvkeuRBPAYEM69UZgytZA9TW+5HITkd?=
 =?us-ascii?Q?FkoGq90RwXfgnLIR7b+BXP3laBQF4HKkJHEdDcRGTCGxfTqoF7/Z0Vly2wit?=
 =?us-ascii?Q?Zsn44pS9wmvgij8fIu0wp5PvTk5PGChhUaIk6rj19n6qqcSKNIBZoJX4NeqO?=
 =?us-ascii?Q?unLfGq38bbGrvEuzFyG5uAuneHvHjbDYuqL3zn4IKfRcEiyl315gu+tVLEgx?=
 =?us-ascii?Q?p2Ay0CwF/P4mg+EGDd5peC3dfPFIgpPNkeHmosbWqZldPu9oPefQemk4ZeZ8?=
 =?us-ascii?Q?TFfTTAHn88++z+LZhoR4nvv8orC1Opa5Jx1bPslSTh99oR8brMU4ROTU24z6?=
 =?us-ascii?Q?MrA/zMn2UslmqPtUz4tVQDq5T6JKpjtfLTkztHWv0JxY8WxnImVqdLpJBD+j?=
 =?us-ascii?Q?y3MZiU3UEFjN710VeEHXSvr7OnD9Z6+BJYDaEmTANzAXQ/WDnlVDWx0l55qc?=
 =?us-ascii?Q?LRFIGDaMEB/rEJ5sspHKXBMHz0GP2mzbiZzLNdDTPoRD2F0tEkvr/LaX+iL4?=
 =?us-ascii?Q?dwgEWcLPfvibt0ybewiVf0RNgomL97k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Xw7xvExHGbkz1QF/Flqip+hypXcrYntjPwuIQL0xfyL96ZfiSMIa3PdQJjhQQk89+Lw3uWBjYyBy2wyTKxJ4TGVNNX4Ikc+XfyZtuOm+bzYkVeJG+TIdQrOJvLUTYPlP9OhXtWkFV4eRcM6Z+gA6uZTSuTcXPDUUcykP4FnwNxvrSw3VXp4dUVWs07fibRw0MWoiSD8z1AYl9CjVATY7nlrDQsU1heb5gNddRq0cPs2dJ+u+VOkw/hFViJNipbzDH7MXb86dBl1Om01WZ57NDLz6Obg6uWLGQavYiUU7Z689fIwdOiypvZhNGtonXZdsilzTW+Prp4KzXeISgdua6Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a484ce-6eed-4a50-a177-08deb278ccaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 11:55:03.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nQV9ypXWvT8CkOsbeGytWnhLPUk1b5bXhu4Rlns4i+QOlmOrTlHyOlt5JQAcywqBcgN8ixM0zvPeH8zlWh95th6XZNwV/Pw0F5dTddMHY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR11MB9652
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 8F4D354FCF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-288293-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,kernel.org,resnulli.us,google.com,intel.com,gmail.com,vger.kernel.org,lunn.ch,lists.osuosl.org,microchip.com,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Grzegorz Nitka
> Sent: Friday, May 15, 2026 1:00 AM
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; vadim.fedorenko@linux.dev;
> kuba@kernel.org; jiri@resnulli.us; edumazet@google.com; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gmail.com;
> donald.hunter@gmail.com; linux-kernel@vger.kernel.org; Kubalewski,
> Arkadiusz <arkadiusz.kubalewski@intel.com>; andrew+netdev@lunn.ch;
> intel-wired-lan@lists.osuosl.org; horms@kernel.org;
> Prathosh.Satish@microchip.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH v9 net-next 1/8] dpll: add generic
> DPLL type
>=20
> Add DPLL_TYPE_GENERIC to represent DPLL devices which do not fit the
> existing PPS or EEC classes.
>=20
> The UAPI type is intentionally generic. During netdev discussion,
> maintainers pointed out that introducing identifiers tied to a
> specific placement or single design does not scale across ASICs and
> vendors.
> The role of a DPLL is already inferable from the spawning driver, bus
> device, and pin topology, without encoding additional purpose-specific
> taxonomy in the type name.
>=20
> Using a generic type keeps the UAPI extensible and avoids premature
> naming that may become incorrect as new hardware topologies are
> exposed through the DPLL subsystem.
>=20
> Expose the new type through UAPI and netlink specification as
> "generic".
>=20
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  Documentation/netlink/specs/dpll.yaml | 3 +++
>  drivers/dpll/dpll_nl.c                | 2 +-
>  include/uapi/linux/dpll.h             | 2 ++
>  3 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/netlink/specs/dpll.yaml
> b/Documentation/netlink/specs/dpll.yaml
> index 91a172617b3a..2bf83f6732ab 100644
> --- a/Documentation/netlink/specs/dpll.yaml
> +++ b/Documentation/netlink/specs/dpll.yaml
> @@ -138,6 +138,9 @@ definitions:
>        -
>          name: eec
>          doc: dpll drives the Ethernet Equipment Clock
> +      -
> +        name: generic
> +        doc: generic dpll type for devices outside PPS/EEC classes
>      render-max: true
>    -
>      type: enum
> diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c index
> b1d9182c7802..ed3bbe9841ea 100644
> --- a/drivers/dpll/dpll_nl.c
> +++ b/drivers/dpll/dpll_nl.c
> @@ -37,7 +37,7 @@ const struct nla_policy
> dpll_reference_sync_nl_policy[DPLL_A_PIN_STATE + 1] =3D {  static const
> struct nla_policy dpll_device_id_get_nl_policy[DPLL_A_TYPE + 1] =3D {
>  	[DPLL_A_MODULE_NAME] =3D { .type =3D NLA_NUL_STRING, },
>  	[DPLL_A_CLOCK_ID] =3D { .type =3D NLA_U64, },
> -	[DPLL_A_TYPE] =3D NLA_POLICY_RANGE(NLA_U32, 1, 2),
> +	[DPLL_A_TYPE] =3D NLA_POLICY_RANGE(NLA_U32, 1, 3),
>  };
>=20
>  /* DPLL_CMD_DEVICE_GET - do */
> diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
> index cb363cccf2e2..55eaa82f5f98 100644
> --- a/include/uapi/linux/dpll.h
> +++ b/include/uapi/linux/dpll.h
> @@ -109,10 +109,12 @@ enum dpll_clock_quality_level {
>   * enum dpll_type - type of dpll, valid values for DPLL_A_TYPE
> attribute
>   * @DPLL_TYPE_PPS: dpll produces Pulse-Per-Second signal
>   * @DPLL_TYPE_EEC: dpll drives the Ethernet Equipment Clock
> + * @DPLL_TYPE_GENERIC: generic dpll type for devices outside PPS/EEC
> + classes
>   */
>  enum dpll_type {
>  	DPLL_TYPE_PPS =3D 1,
>  	DPLL_TYPE_EEC,
> +	DPLL_TYPE_GENERIC,
>=20
>  	/* private: */
>  	__DPLL_TYPE_MAX,
> --
> 2.39.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

