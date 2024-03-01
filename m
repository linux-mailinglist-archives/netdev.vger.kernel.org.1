Return-Path: <netdev+bounces-76443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B34A86DC27
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 08:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E83CB216D4
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 07:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D9169317;
	Fri,  1 Mar 2024 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlGFjp+j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E969952
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709278475; cv=fail; b=J1/QU9XwO4eRidKOQwDA85OAEwAu7FK34qoNlaqEFNYndkAX5Zbt+U8KrAx0+T6WD67ov4s5P1TUFEl7utBrDG+KyfPUbVnbLzItG6RohF6BJqSttv06gQGzjNOTmuJ0Rvhe47ixf569+33FqtgjKq2nHmd6GXmfjjaaTCIa2Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709278475; c=relaxed/simple;
	bh=fMvjzkNSw4qo7PhlaTAt4jgF2s6Sv8Ty+PjmGrWnsVU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fkVxKkC84Kb2cosiUyPoRx1DmThXR0TcAXzN0vMdoGp6jCZv+QTkXZ0Sb5Hh19UTD/yP8Fw3zQL8kV4VRytFt5RTQwhbECPDPn6N7y8atRceZiyqWcw7S/LF6pXjjskJ/pLub0vZ5RKnmsE/sYAex6fUpdiAAXqT/XIg2ujpAo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlGFjp+j; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709278473; x=1740814473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fMvjzkNSw4qo7PhlaTAt4jgF2s6Sv8Ty+PjmGrWnsVU=;
  b=OlGFjp+jK2vSXppA80OdbDiwfT+HIjyIwWwLip+FfD2RwbxvSNe+MVEM
   pDXmj7zqxKiaWwNfkVNodUpGDffUeLt2u3/P55Gd5sM3SAfowgAqPSKTp
   P3eA2SCfxF6urNsTxo/o0DFpEoF5J7QSkPN2DUj6oiQoZisnt38jw2BKQ
   1zq8/kuwWkHnHtZlO8CDhLYVK6LO2zApwUEXYqp+jH1dETyf0GT7XHw40
   knW9zWzAeOHX7JmXV3ntk0b2oostKISskNS3GiVLx+aAq2PK/p2VzBgmf
   dC33D1TR3gPLfeD8bcJx7ePEwEJyRcrXmLo0/ahwU+jxemqxIUhhlwUt4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="15214173"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="15214173"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 23:34:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="39132582"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 23:34:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 23:34:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 23:34:31 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 23:34:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJ2wGS6GctjDlSs+uzH6IrDcuWpjuxN21wKVTm8oYVVgGi7xVexKwe4DNylBr4aVKCJz640c4ICeWNvCS9ztjmap7X9/eMm7NsYM5cPL91DZFmRQ3Vh5juLAeiLwYHcg+8PI1yhwJmr9nB+ibFNZcFy1WlfNH6cGZ1ewdRZIaEYgiCWCmaAeiOgmimwBTkP4xGaxzrBFOrOI/NGsMQE3BX7E+RgmGGpp9QPNEirJb+idjXV5i1mxbCF0QuPueyIC4lGTajDNI7WJ2tmOsoaTo0zuym230nnYI7E4VtHi76KjyIGvkXeuuBQcCaqL+zgnFJAyEXrO9HFmDdTTSfLGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHKPC1OhyHOQB2KpE5sHxZuWJ1ngPkqmrNN+JbLzh+Q=;
 b=bl1fMBSitcA/yhROehZtcVLQwZF4M9ILgy8kIW5xUFGso5vO9FilsqT3iW7BgQE7asF7zfAJ+wk6LGasC3rtK4Lgiolr8afl1Sn8GOMinWpAq0lfgCh4+isASsl7zclqyzzef1+tnfxCSx1Ym8q5BwhN2ZmJMFlPrbi0qBhVHkdMHNl+paTJIrfUjGbnsCUmht7kyNYBouKLXE0zIMePMVnoH62IlmlCB1g6UO4J8ij9fHTB3dSDR/6PBp6nZ1lcXfmZnKeG0nvi6FXcTZsCOJhNfLvoDwCXkELU2NX0jbfiBZo13MmnGjN+k1ybiA8H9xPN2UuwX33ZsO2qrrDjEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SJ0PR11MB5215.namprd11.prod.outlook.com (2603:10b6:a03:2d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12; Fri, 1 Mar
 2024 07:34:25 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7362.015; Fri, 1 Mar 2024
 07:34:25 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Karlsson, Magnus" <magnus.karlsson@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-next 1/3] ice: do not disable Tx
 queues twice in ice_down()
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-next 1/3] ice: do not disable Tx
 queues twice in ice_down()
Thread-Index: AQHaZnJYwa10VgwQLESqUN1jusGr0LEiiHDw
Date: Fri, 1 Mar 2024 07:34:25 +0000
Message-ID: <CYYPR11MB842961B158708C36B8A3346BBD5E2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240223160629.729433-1-maciej.fijalkowski@intel.com>
 <20240223160629.729433-2-maciej.fijalkowski@intel.com>
In-Reply-To: <20240223160629.729433-2-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SJ0PR11MB5215:EE_
x-ms-office365-filtering-correlation-id: a84ae215-800e-46f1-21f5-08dc39c20515
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: COKMMzYzrY4okxjI6VXlOGfjlGw7h9eomiVLjOCrZRZ5neCz+zrPQvX7a5hGn2mO3KHDPK/efCIRWfnycYitDuzFGFGP1ZuWeRVncGAcqlBhGSuBAMTGqs4YYYg0topNYtFNLm2iCkKZta3540hGu+oZt3VzJmC4YPL5WyGdko0n1+A7x7asAR1cvxgp2wTYPyOQop7VARTX9CValc6beY/wMDjA8W8cucQOKN/GD1EHR5dqeHxhi4O2B0hEEtRCX8z8b+V7LfAIr31ZKqeMw4sXznPeW4ZwIEHiVqZRtzTbs+pVDeQhNjnE+QjqydXn0TNe//DrQF554sSggF33akl8moTqzvLu2jpFWzOAjyJYVUGh9XS7gcvSRnc1NUj0mMpGm5vYTfSHOiEOBr2OUkOyIPbkHMDoeGVwJusCfgjow8UWN54afd6GORmdBkASmX3Li9BBd0SkwStfP1XB1PK0Zi6ttYbyLpTFrBpJS8rnxF/+yPlFyd5g2jwFAkUX5r/YcvVUoGwLQPqqQUnsaVLz2QmtivrTnA2oF5L4JzvGJyDcaIw3BJ59Er1Ysz3DFuXCdTytqPSPfYojQdfeAJAS+jXmFJwPFGqC+upDUvmQmQXkDb+BMTS95z8WmA/RkAb+2ajMvPr+JpfrCGAAQtaMJd8Vil0oUF/zj2bRQxWnBVghEj/CvlyTi96d4mYVD7p9C37fI1RrTkcvS3WkzzJOSGQkTd0qKatixBTEt6w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/9r+zKsbT3ic0swe6aWss5bHXQ/w7GFSzvJE94S5yYaY/aNsBd1DiF1hK4HB?=
 =?us-ascii?Q?q39nBSt8Ild0LHYkslbgDJnexv5FdP7uwm0JUAiYBqE2UULM5cajFvviRGn+?=
 =?us-ascii?Q?Em6V8yVCGWA5buwPp/joJFk2VRXaoswxH5v3SQMiyKqJIHQoqe9f6i8cZbP5?=
 =?us-ascii?Q?nshlEhYvjEdaYIFm4f/Y17vbsFiYnqLPzP7iRfCdBt+/M+TDmgaHEFB0BuKb?=
 =?us-ascii?Q?5iJn7hdLCpSJIWVJP9G4srtGnVaPAczDdlzXTTQUX2HxCGeaXmcC9KSMf50L?=
 =?us-ascii?Q?6KxkatAo8j/DDlGuZbhLVSjF2MU6xsn/Z5Edo8xZEzSGIRcGUDA/nyJOi2e5?=
 =?us-ascii?Q?jCe1MWvah5stH3PLGQj5lq1U3JbNY08aPpNJhHP28w1ClxEDtKGrQer64GK+?=
 =?us-ascii?Q?0f9WUpSWITZ9G1mN3eSAK03xUisgF3YNNtsOmmwqw3PQ6yb2tvh/AaUsWBGJ?=
 =?us-ascii?Q?0a4Qagkd2Au8NXJIj1vtM0KCJ4ph3J7gIji64ihj9wl8Vt98N8dwM4w6HNeA?=
 =?us-ascii?Q?loH9uAv456zyjhNgKenEz/xAtqI1YHdAtWRBSLbl/iDEayc8fHzryHqfmC8i?=
 =?us-ascii?Q?aGo1o2QnNWw/gvBhrWjUuzwmvgdvCfpjvkx5LioxYPURZUuEAIHq/joS+lLU?=
 =?us-ascii?Q?3yuZtN7v8yJtryIUC/OqjO0TMNSUmzkj69Y5y2sOXenUIsiO8LTzl6vSpMEm?=
 =?us-ascii?Q?3yHbRH6OYp3Z/RuEgtQZpQd8NYmkHjUIi/9qkzlhSvRgQ3U+no10EFzp6CJF?=
 =?us-ascii?Q?DgYX9/l4w+XtLSzs7WdZTXROCk4lKSd+bSWQ6Oo9Q3nmxrW2BS3TXH1XvD0j?=
 =?us-ascii?Q?oxD02Oi938hjY68YaHSUq+f6xXQlF12/NqrV2ATtEkWavAoPzA5Clz4BPGr7?=
 =?us-ascii?Q?gn/z6UrqwuDluNGXkjaQPPY+TYhfblfNXujHgxPI1x5pxOwX67I3AK96XHFI?=
 =?us-ascii?Q?MsPBbPdxokkh30LWsxplzrmoT3PdnbUKN/ZrIGnUAJ3YY2iHP4nj6uJjmD+U?=
 =?us-ascii?Q?aD/uLfz2ro3Z1jdaFRHxduK47shNuNsXUcs/kMNgbc+lM4EEGWBQ5oGHsqSJ?=
 =?us-ascii?Q?sCL9+vuH8a8DEri1N5llB6T/cYv1btKKeI3IZm4xnxvqum2LdGqxAXSokwkb?=
 =?us-ascii?Q?7MYc8rEn8nSRUt7KK0I5gsvZ1Us36e5BEGa+Hm2dp6HAGEXvNg8nCSuYC2y+?=
 =?us-ascii?Q?2Pa+Nf3pDOEaDClmApovLcs4jl+a8tLmDgh/YCL9FphRTAHPTniFNvi1kdYC?=
 =?us-ascii?Q?+rMxTz3XSPmefhMgxRgJNmTdvNSPhJ4AbDU/db4SyL9tStytrBBqLe5PKbPm?=
 =?us-ascii?Q?WdvBj2BkJtIlvYmn8vE7cJKiY718vlGT5LOqe6B2iepmDvWUiVX7mlXNhmRs?=
 =?us-ascii?Q?F7Sr8IQGleEMx96252dMZvDmU1XetfBoJVKTgt/H7Ny5TvxVfP/wFXDoqTh4?=
 =?us-ascii?Q?VmIej6/Ny+nq/w4b8W1UWpiqCVZyUPjutHarheDPPt5qzNdAuPZV6HzqsLa7?=
 =?us-ascii?Q?TFzvAUpde1Can/DA0eoF48/yDoz2FtDcAv7gjKHp/DZ7BM1u8oa9r1qrDVDo?=
 =?us-ascii?Q?eq/TnkWKYSGp6OB7fXIOHrTrVQAnO60nwxt8Hw5Z9XwUnfX1cN07DIzJb1oY?=
 =?us-ascii?Q?VA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a84ae215-800e-46f1-21f5-08dc39c20515
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 07:34:25.0979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4zpZbATbanzB1dedlINqm8EqdZ/f1UBN+3IKaZPs6X/Ou/pKowpwhTozpCI7WIVDq3ihP8PVPhhimVKy6pe6sbZNCESM6HqWQ/NWvqu3GgcmirQP7bjtS+4zfEWYiFV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5215
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
aciej Fijalkowski
> Sent: Friday, February 23, 2024 9:36 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Fijalkowski, Maciej <maciej.fijalkowski@intel=
.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Karlsson, Magnus <ma=
gnus.karlsson@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com=
>
> Subject: [Intel-wired-lan] [PATCH v2 iwl-next 1/3] ice: do not disable Tx=
 queues twice in ice_down()
>
> ice_down() clears QINT_TQCTL_CAUSE_ENA_M bit twice, which is not
> necessary. First clearing happens in ice_vsi_dis_irq() and second in
> ice_vsi_stop_tx_ring() - remove the first one.
>
> While at it, make ice_vsi_dis_irq() static as ice_down() is the only
> current caller of it.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
 > drivers/net/ethernet/intel/ice/ice_lib.c  | 55 -----------------------
 > drivers/net/ethernet/intel/ice/ice_lib.h  |  2 -
 > drivers/net/ethernet/intel/ice/ice_main.c | 44 ++++++++++++++++++
 > 3 files changed, 44 insertions(+), 57 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


