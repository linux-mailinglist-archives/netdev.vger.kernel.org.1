Return-Path: <netdev+bounces-63318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EADE82C4BD
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 18:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6864A1C21A62
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8429722629;
	Fri, 12 Jan 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfWDkbU1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96017C78
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705080777; x=1736616777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bt3aYz+ltTxBrd9YKgI9lnb6a0+vxxso98zsu3PtnOk=;
  b=IfWDkbU1xuGJc+GZ8H2azxUjafx2I2lIrcj3eXNJM3pRyCrq7GwuVptM
   BjKaZFiusBwW0zQY5icbhiRyXkoxf6Eddlp/WHkYe940y0jVU+8KdS/zK
   6/SovlmKB1gHt2487sObcDA8qZq+qrpBEGh7phJY0VujSjK2XuC6e3fYg
   WhCXQryPaMLrIiPE7BhB0976hxRpq8Cp9JPI9rS+XYPaI1bFrutBEHm8h
   Csu29anQsi14eRlH7orX0eNR5ixBc1ySMxGffEpRJMWQq93ERCE6+H7eq
   nrs0L+XB8tgmb4uqh2Ju9z4Hcb14WlbhxPgWVHHQSagDJWfqe0qPHtXRw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="396373775"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="396373775"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 09:32:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="783103285"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="783103285"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 09:32:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 09:32:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 09:32:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 09:32:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAk0dgi+nv7w5KXSu029ST9b58a7Atp/JZMSPT+Dwq8lAmL1G7lelMSXwOcAG5H/lbABqiF+BAavfOZtatpyZzLeKbkobW9SzU3PjYT3FCSOAwTu8vOmlZgoMYEfh1LtyNx3vcj27GTJoe9jr6ze2stqE7kZ8FGd1LOrgqPMHwaqJlMr50iihnAzTsjj/bx3nuyuN5Ulzh+0IGHIwT7TD3ZyKowV7qS/iQePMQZk5gxWxQ/v1TIZJZuBsZeGbb203TpWZebwOBfFLLrv2ATVomXwW+kU7LrxVK9t5Fn3UKzpu4eKp8E32xDLBR97VxIF55+H3yLXw5iVE5Ktv2Oa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOXQ76/Vqv0CiTJCGs8aSMC5gu+Qvai6mbJgzqweEoI=;
 b=F3ORqPSLLhNeIUg36pVx4GYnIEAjhznKNRjmD+nZV3ICimLA2gthVsHp4+224pOR57wjfzN0u20A3QivWctwVs8teK0EG2DcFJmCKshobWPokkkeZC2wKtGAKCrWbBU0TNLCo8ehpT62uw2d/2/F2vsmJOi8TP7IkMtaOIrgbLVxgAeo9VHfZ6c9SkYcZBd6gM9Ljy7oFo8HwtnpGyOHVGWStYO9BicIhuJzC5vwH5qgiUoLHkuSA1abJnBGWYyVFZwZ1e2YvK/xFBjGhbxkhqCLC6C7bpyJedEBrdC0mnlR5sY96He28lVym+syoc0AruegstaNqTDBNPuPR0i14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SJ2PR11MB8346.namprd11.prod.outlook.com (2603:10b6:a03:536::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 17:32:53 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda%3]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 17:32:52 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v5 iwl-next 1/6] ice: introduce PTP
 state machine
Thread-Topic: [Intel-wired-lan] [PATCH v5 iwl-next 1/6] ice: introduce PTP
 state machine
Thread-Index: AQHaQjD1vrzKDO97/UGaYfM+jgZb+7DWcx0w
Date: Fri, 12 Jan 2024 17:32:52 +0000
Message-ID: <CYYPR11MB8429A0AB85FEF4340B99E60CBD6F2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240108124717.1845481-1-karol.kolacinski@intel.com>
 <20240108124717.1845481-2-karol.kolacinski@intel.com>
In-Reply-To: <20240108124717.1845481-2-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SJ2PR11MB8346:EE_
x-ms-office365-filtering-correlation-id: 969f4c9d-ad7f-48c5-e0c4-08dc13948188
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t5mrv21nygG5PPbefn9fI0lNXAN0BzK+x9IFHyzqyWaxprtntyDi+YQGGvhFpuUgtsF100OoghnwthJoFzDgRubV4/3VxNr07sh8+7WxTexiFC+AcItOdSpx1hwEg/yimUvJQC60wCwZAlc8rdtDNJWd4gZnKI1rcN7h2Am7iRTEHt5GNvd7lm/wyzPeehUOJ0JJuyoNdemzgRm+q1zhZ9AVVG/i8H9f/F7DHlVwgwQ5dgYOeHtzmlFtzz1Lo3r3iK+p+53Ct3cE38KvcVAC3HTNMYKSQ3tRnPcnzFIo4FUby9beFUuwMABXfS+eauxiloxi2Ucr2B8Rq3BfniAAqi1pDTmlQseEFTf9CZK09kAI7i3Ij1eOpEvEmG2fYCQv6US2M95ZcIf+z8XitWWb83tg0ZZSLKNl6RLN5nEfGVl8lwA777tf6vWWH6egsT4nhxMvI2AqqVIkEN6pzAPROW046+LCFrADL7CrtPFvlspyJsX8tKIBUcC9gXt27b93uQEWpU7kFvtPBuuoPYLZBlxJCaBJUtg0c+v7ly9fKuj35xP7c9WKfQF63MynsRPs6IQGGSgw8WmXC5haESdOMc6snfNXUZv7hQYMNxWw2nMC1wVV4zSZwefodDdno2dS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(53546011)(38100700002)(66446008)(82960400001)(316002)(41300700001)(2906002)(86362001)(33656002)(54906003)(122000001)(6506007)(66946007)(110136005)(66476007)(66556008)(7696005)(478600001)(9686003)(5660300002)(4326008)(64756008)(52536014)(83380400001)(107886003)(26005)(71200400001)(8936002)(76116006)(8676002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R/kVq1yqtPufOLWXLZk2mhqiM10+d8IBRlvBVMIPCM0MhYihEl4H9cWZK65C?=
 =?us-ascii?Q?Zt+CdreD016MRVbMT4MSEB+tOQsZ6MuFhBujJUCpNlSeGvrhmKLvKRZxE6j0?=
 =?us-ascii?Q?rsrQlY6aLlb+GS4D6Rp0e/NPVQTuYK3eHCBCpy2AyMSJOLu5g/mtBQ1QnIw9?=
 =?us-ascii?Q?1ZFFdoJXHDIeva5Lsn3R5JflRMaa1dNO7QrOyt8WnvSPZCgY23IoqztQLNi4?=
 =?us-ascii?Q?P6+tSLAszODQm59fdgV22n5fAHDaJEFPza9q88i2G4ANHx/ok/ZRQqefsADx?=
 =?us-ascii?Q?Legu8dbClVSLZ24M3Yb/JWHdbPStc1ol8V+2X6o9A0ikupNpDlgtmNL3IvNY?=
 =?us-ascii?Q?Z0TBnpSk0a8/Vj2G42oCs8+VxnTCTCmvnUpgp9lqxfSigX8BRfRMO32DtceB?=
 =?us-ascii?Q?cWk5tNIvJCE/NHSd48pKpWh5F7CdFSt3qONLdoMXGQI3Cwo2t31/k/c353zg?=
 =?us-ascii?Q?E16CXDhCutPy0CoBtjEcPaC6vAISWI64wJUYUQLRm8Sn5Et7hzc/RsWk6W1H?=
 =?us-ascii?Q?ni5Epn/YCXPCR5fs3TH7BKuEju6jedWmLz85Yi6q17IeOgxY87wcNmogD/OM?=
 =?us-ascii?Q?kMsdnY88OH/rvbNsd1UlqYIZ89AJzi1iO9vJG34Tsu/dFyUbdaRTq2fq2ZFg?=
 =?us-ascii?Q?xVvLlPOCjWPJ4G91wtOm2oYU/tgvL2h/taRCMqtBT+pk+gMYF6KcFlK7N14U?=
 =?us-ascii?Q?dceJSUovhlqGXEtJNvrGHrJodROeLFhgHWuSm+nTrPVGTiHMbJveguIcNm06?=
 =?us-ascii?Q?GE4E3Iszo3Ri5mgK+pvGQy4dioyp3ZMENMCZfOQohqC8xSjKds5vNcNhenJy?=
 =?us-ascii?Q?AVn5zjAmQw6yXHPxseuMYq844+7OYBIGLCnAULZHY63O7htfiVSwEwwqXZ7/?=
 =?us-ascii?Q?OaEl4Kq6QmSv9jDHOi9VkrO3LGh2SLSxaEJhib6oD2ZatWAy4RTGmWA09waX?=
 =?us-ascii?Q?xFKuTHHijDNESfyxGSvDfL9rvWKr3h1Urg+AAWJw773x6XNmFJwh7qG2G2H4?=
 =?us-ascii?Q?/tK+lmDWy3HLG/twbzqWkJGkLXyJ5Ey11/EqjpmQX7uv0Umk/vEbsrDLovLW?=
 =?us-ascii?Q?7SjK4xBg86lnH/ZyfiDGWrGR/88GZUhoGJzoopbvRX/NvMntuhyRR0RTVsSU?=
 =?us-ascii?Q?9UFykKSXKUBiPmG+DXOpmXkqSmhwmlgdRllT2eFpXQNWwQFYyKmMYZOrfRzn?=
 =?us-ascii?Q?psy+MpDEpPd/b/n6pWfJuK3wCFsUnDQaT0U7BsYsHvplAHYfi27vHjocaM2p?=
 =?us-ascii?Q?PCWbwn6S+gvfNeWXl03enTwFPwsDmL7wiEjnAWAY6n/XtzSzz7WeVWF/zBDu?=
 =?us-ascii?Q?y3VOopaEVzJ/pgrySuNKn4Rg+mC1M7DDnBiPtLXSZST8X/XWLXbwRz+LmvwP?=
 =?us-ascii?Q?u0qPPA2n23pdwGyc9QeOQDUywR0Rx4V17sUScQ9uL345vRkXtgRqq7BZ/cEG?=
 =?us-ascii?Q?zwhXA/nk1KL15RFTIoc0jZM7133AJI7Weswsa0t/gKQvg8w7snWX9+SBxeT2?=
 =?us-ascii?Q?QvOeUR3Txrn2XqPrmcQZbyVZ+75se43eLqpPicVbl4FjHHqjRi2DgjYZKEWI?=
 =?us-ascii?Q?dXyw3YmoboR11m0Uo7Xx9uLxsmE14kwFp/Nf7HWtOraFqAAkWf2iDZqkJnMZ?=
 =?us-ascii?Q?Kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969f4c9d-ad7f-48c5-e0c4-08dc13948188
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 17:32:52.8572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YwqUotB/0QEkDP3Ar8d5uxaYZzjCLH35Oz6q/fa4YfAzIamD8ZZ7oXBZM4ijHTQj2xM3IIPG+XSPihOhqydpfQNPM7mQdGE66ZtoWOLpXmX2V69aeMJpi6nUuNXdFG6r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8346
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Monday, January 8, 2024 6:17 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; netdev@vger.kernel.org; K=
olacinski, Karol <karol.kolacinski@intel.com>; Nguyen, Anthony L <anthony.l=
.nguyen@intel.com>; Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Subject: [Intel-wired-lan] [PATCH v5 iwl-next 1/6] ice: introduce PTP sta=
te machine
>
> Add PTP state machine so that the driver can correctly identify PTP
> state around resets.
> When the driver got information about ungraceful reset, PTP was not
> prepared for reset and it returned error. When this situation occurs,
> prepare PTP before rebuilding its structures.
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> V3 -> V4: removed merge conflict leftovers
> V2 -> V3: fixed Tx timestamps missing by moving ICE_PTP_READY before
>           ice_ptp_init_work()
>
>  drivers/net/ethernet/intel/ice/ice.h         |   1 -
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.c     | 112 +++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_ptp.h     |  10 ++
>  4 files changed, 76 insertions(+), 49 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


