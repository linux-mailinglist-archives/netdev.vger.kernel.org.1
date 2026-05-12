Return-Path: <netdev+bounces-287344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id v00wKcy0A2o69QEAu9opvQ
	(envelope-from <netdev+bounces-287344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:16:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCB552B3C2
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3DC7304D254
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3DA349CDA;
	Tue, 12 May 2026 23:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LteBVQY1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AED7393DF0
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778627190; cv=fail; b=OZoUIyaTbrGU0JQOdZA/EminKI/h1/m/3lbWZ814O5N6t7U2/TvgNmPkr7JpSxEdYvtbROSyjjrK8xBN6T5L6a05W3+goOVPf0V1veuXntwWWqI+GTWnocfIBP64UQcDSoTiimYXPCK2zU6cv8m587yTBDx3xYnZQ7GyjuBt+AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778627190; c=relaxed/simple;
	bh=Vc84Yqn11p/W9y9837niNXl4O1dJjSK1mGl253sNLds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T1elcmDzOORG22WONVoQ6ZA5KXqWECyrWRd2Sq0o51UAPOQoV3zpDDpJjLRlYLhTTLjL3ROk+bTVTXkzn9B4hmibCxpCyDIe3GLatz7H1g0r+PR7wyUe2zyosylAS6wpPNREjjpq0H6obDlmgyEuYzOBNh4pDkO3IbIbDKCYbaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LteBVQY1; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778627189; x=1810163189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vc84Yqn11p/W9y9837niNXl4O1dJjSK1mGl253sNLds=;
  b=LteBVQY1Yzz9JzqFG3wmaOHAmGsdElkflhCLK/V7st4pOBCP/4uHScUC
   1Lntal+WWLar9X6qBWR1bKybdMM7QT3ZmgsCOqCaVSldY3R/7ITO1E2GX
   pRBd1Y61/hwgBjtwVbqvnBISfHqetZFN7MQwrT+a8wGKBa5cAi9ray+eG
   eU8JtTy/cmTgMx0J0OxgGqgKRTcgfyfyF1c+i0pTGXIJoFvG1ZW1rOg8P
   FdEEfxpxJiP0TcI1HvRlo3aBMhPQrryRWw/8xUEb87OYsJ9a7Wz6ZVhCu
   5Wo+OLGHu1Qvb+p53JIzcFbzg5GUOqk4j8tOJCYJ8bMkleFIxUgw2QVal
   Q==;
X-CSE-ConnectionGUID: MSME787EQjSCxkZDKPdlew==
X-CSE-MsgGUID: aJRP/JXDQnyHQKjToKKGVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79726898"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79726898"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:06:29 -0700
X-CSE-ConnectionGUID: eu6h7pLVTdazfUX7JPZF1A==
X-CSE-MsgGUID: QyKPRiKCStKYrRIc3mWaew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="236923239"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:06:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 16:06:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 16:06:27 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 16:06:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaGI+I/Zx/a8KEnqGKOs64p8/VurGkfLzej42HNGhIzNq4ScL06OdqnvACLumed0JJQeg/gM7+w5FfptJev/JpEFSO+n15iv4BBtkqOF5Yn+ue5hPDE7mm3415zF1mWex6E9lJeK2yNhDTnCbhzPsbB7jbPOQxljXcpREieI9gyTZbEepdnxqkGLw58iZxwZ6/8dU4ZIvnHUXOzpYXx7F28KeTPnMyjNXcZr7HeFsXbNnNr+jKOOUuyU1o/HlD6iwYDptxwuQhkWE1n8F5DOzEmLyI9ElukyPw+AK+XHNXJL+0RLciXxwYMSuFH72gwqE2+6/YL0C8X/6a/pH9s0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XncpoHlWzK+tRXz9XSuYLfe7TgEF8cYBRhVQvFjLjQw=;
 b=bKltUBPfybJjRmZXcGhtkyDj+E0HVc35eG1Lfr0nxNtTxFahOvESwHBX+VftmuMmK3fxPhiPK6tzjVyqcl+usb5PtNRyijUikKruBRzV0iBxb4Gy8vi6Sacxol+vXQVrBgW0TGbl575yNl5LgqD7qvRiLZo7Pqz+8t6PLlvVBPtx8PHGDXh0FnRiLmedczWfl0z1ce3NeEcW1WpwP6LFtfe+M5MqPm68A7gg+3jiOsfc+c9QjIVJn9nI9crgj20QkRX/3DUdPmInISRo7ZX3l5vSQauQVNod29XnVhil5GCg+V9kJhaVWQyuGTuITn1BSJ2Fdg+cTvPApWQA6HS53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW4PR11MB8268.namprd11.prod.outlook.com (2603:10b6:303:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 23:06:19 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 23:06:18 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: reject out-of-range ptype
 in ice_parser_profile_init
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: reject out-of-range ptype
 in ice_parser_profile_init
Thread-Index: AQHc2KzG7ntRbM9UVkO4Uyly2cNtG7YLFjlA
Date: Tue, 12 May 2026 23:06:18 +0000
Message-ID: <LV1PR11MB8790C4081357737DA15E106790392@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260430142153.249062-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20260430142153.249062-1-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW4PR11MB8268:EE_
x-ms-office365-filtering-correlation-id: b4e8dda8-f987-4ee8-d09f-08deb07b134e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|11063799003|38070700021|56012099003;
x-microsoft-antispam-message-info: EnnQodXzX+FwOiUgqIn3JZuXyJEO8yVmO5g4ednxidKik1GFPTh7VLSP/K7hG6wD5zCZ0wqhm+44P59HpmXrVe+rC4plfverX+I2Jt2YZXP2qwy2y91shnmpGfP1CEsOiRSbRff5qvqcozjdhYDDOpVQTln7iAutxRG3ClhScugPpo/hE3KtAgHZo0UTdHVcXYFYFlv88HP1+8ChlPE0FB0BPE1pKPK4Ol/kGAfL5v9Q56jl5fGK1cWubndKqU4Ow3ECKcpwoVLQmIwnzlkL+k/+4xZvPL8jKNUYPgXvN/v/Awpjkudttiz2jDL9EAlVNv1XNmpVrO1MrrB7+8xZ9nT9tQzWLqzXzQYjrrUcQYMBjKc+tjfcMoEWPpIxOBcv8y9hkSUC/U4vw+hLYUoCHyqZ0dwq8uwtWVC74MTa6X7KoG5qexGNVKfi4TA8EB76RUaAC8tQ+zuV4tMXu3h/I0d0I1jnmXD0/pnEglhTRPrt4NmQBiO9kxo9xOIyFFE7DA99n1GhnY7NJJIGs2bEOubCP78SqzeXP79Gd6XqP4QmcU8jGXVLwgvHR5QcDxy0Hbyz5SWVeKK1ZLKjI8UZ0e6Kd6ZsABjijPvks14j0rYpj6cSNxY9OjoqLK4Dl09R0gWkRG8x72smuWrCpBcE2DD2SrPVMv7dYzNObZwelkqXSvMyPtGob+UVTHLeTdKIxLTm/EBDLZJJ+mlroK4qnpawsxRrZ8X9LMKucqRCP4oNWbYNdpgqk839JiDwKTnL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jF5Jj1F9u7wyAa8X7Ns7j1CMxA7xqKPDmqC1mC8Wo/AUqhXe3mzbkUkccnia?=
 =?us-ascii?Q?rJRy2GOiN5cfHTg892rxhNdPlmF/7GW4sxt/cpKzowzxAw4T6+IRx21P4tzy?=
 =?us-ascii?Q?rlGV9EMpY96H/JRsmlcwbFW1Tj+VG3EIIZADT8DwWe//VzCiQG7PDUvZxVO9?=
 =?us-ascii?Q?tfE55cYDXDQsKPCKHTHvuBd+sVq8eL7CnR2GKb1ceF/Lk93uXaUY20KstuZa?=
 =?us-ascii?Q?tRV6HuSh5g2463Rtn4LTEzBqJqg7c4fbPcHUoSDEBmKni9T1yPaiHiYksiDm?=
 =?us-ascii?Q?hRRGI54HlLB95VBVWcsgVFLiT7NVIQc7R31J03k5WAbkTlSQ0rje438NO2dl?=
 =?us-ascii?Q?54w9W8tB9hET7f8oj+j1oHHFMlWVfttFbdMUOcSIYOk6DX9MQ+agtod+10ij?=
 =?us-ascii?Q?+CvtosHZlNfcpa09dKKvp1ZQGJbowaHH3leMDovoX5Lr8kFL+v1ypGAy2dsJ?=
 =?us-ascii?Q?3YsR0h4x1LJOly82G4oN92GaezQgZKB7Co8Vz/r558spvZosr9IxTJ2bkhS+?=
 =?us-ascii?Q?9tle2g7MYo01ancwPd7GGBUUJ8w23Au+7ht3ZFS7G3QrXimfCla0y8Y8kI8S?=
 =?us-ascii?Q?4sFIUE+WTGX0k4YyEYt6Mt6Yph3EyA8qITnt51NYX1pulgLI0+RPLPzfyJuq?=
 =?us-ascii?Q?+pSZRy9R3txssph0NUvVWBvHswtj3vJGK+tFUQo8RVtkAksPPyRazazhiKzh?=
 =?us-ascii?Q?jb2IfwiFMt297O15OZjewMkLkh0HHdoZE/VnmfPfJ4y/GCw0cDBXoDRddqZo?=
 =?us-ascii?Q?6WypJ3Snlbtm6QJk427nPSShgEx0jjXbrnWbVTeIKrCuYxe4JpCxZlZAQzsw?=
 =?us-ascii?Q?zCzbXej4Q78gcGv9H4GYdULycRxnxDvjhIgyyreBzkxZE02e2De778oqdErS?=
 =?us-ascii?Q?8bk7M/omHl7P8nIzzH3meq3BmCTY6C0VqhUlw/o5P3g4cWhSMkjZucELM0iK?=
 =?us-ascii?Q?wG7eZXGhyjLHbLTGsL5cKCipBXUL9wjj/hBzU//7dVqTrCLV+CPDjPiu+K8k?=
 =?us-ascii?Q?GqCc8Qmc4SWGNndJihJIgpFaRJIve350v1+5I5dmmufiqct5vb0bi03OQ+nL?=
 =?us-ascii?Q?ypFM9gFfqKD8t8uBQH9aFecKU8iBi78HOYQKPqhckvVmnyzAY+x5yT0dFpVW?=
 =?us-ascii?Q?N13N4zwmx78kHEGHXZkWrjeZIBzZGTknuge9Pc4TSp5XIqAsXQ0VkzeIAbFD?=
 =?us-ascii?Q?nLtX20CIYlBz/LoCj84bmecpM7I1JHqMyzjw+ZS1jFyOfiqG+TDFXbgclJXG?=
 =?us-ascii?Q?YSAYkJaRM38dptCz/9uqznCejxGugdeUy/Stw/DLuXqxZNd9UMGbQ79V7kZb?=
 =?us-ascii?Q?VyMvimKMXoc4eaihCAir8mFsK+/uYfZM4J0RsXqk6NQ+zHLBP7YNaeD8CCEU?=
 =?us-ascii?Q?D/EQZnFjSW4L2p9dFG8hJnGXYyQg9XYbCayUYhpWAdnBmxuK3Xd4OSv7QPu1?=
 =?us-ascii?Q?EOFzXMyppQzX160gf8/mdENCFLZzmmGO6n1pU8CLnxdNPUeK5ogUct/IecaY?=
 =?us-ascii?Q?cjWtST7jcr4CeiUxybvWZGdTvG3hEbtU+QMX4YTrxLJIT5NnPH54yPh4BZsR?=
 =?us-ascii?Q?6u6U4G+/y6cVgAsRG/GIS0pp216dK+fi8JzWdSmXjK+2+SHlGYrd2oxoGUQK?=
 =?us-ascii?Q?GaNwqw3Az0UI22jV5lqcsWz9gewfTMbmUi585/6Uwbb3R9d1KPUojM2xiB8p?=
 =?us-ascii?Q?z5bhOq95nRzuKDEHZQIuk6Sz9lBuLT7gTe6FkianP3kzdCzkphYH1JAuovAs?=
 =?us-ascii?Q?OTNwJSRcqQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Tw9xqG86aAFxDtiphzbVyU4aIN8I7ds/4TlmCKBG5ZAK+vTS147BF1cq/FXitDBAGlHanO9A/TQkGXJyt/qZpff7ZJW3vtGgiGn9GlKicA0tJGjLHqPvD02ozlPEpWCH//+PONbTkIbndvkneYtLzu+0VYhTSXoPcKT1wCP+o1x2KlFusb6WD8ePYs/swufoHjNJ8y+ivgD3/AHyGdCFJJ3XbN9XV8eycNB4MArtvtTDv7ODNp7cvYYC9KSJl4Fw8Tx3706b5VotJf6rmJD8GZyO85PnExHTAMzO9JZ4bRqDW1YJfnixj315JnQHxxj0rA9/jbilIkJSRuaptwDPsQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e8dda8-f987-4ee8-d09f-08deb07b134e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 23:06:18.4530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tuCWkuxW0QlqIeWly4BJ4xcproKHUAIjn6xCveSPg3CeAiaxpMz8i/yF/hCMG8mGdSAzS0jOH27MV/k/VbqdtM7lPAAqRXLZI49fkdIqhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8268
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 7FCB552B3C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.34 / 15.00];
	URIBL_BLACK(7.50)[osuosl.org:email];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[intel.com:s=Intel];
	TAGGED_FROM(0.00)[bounces-287344-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV1PR11MB8790.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,osuosl.org:email];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.689];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: add header
X-Spam: Yes

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: Thursday, April 30, 2026 7:22 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: reject out-of-range ptype=
 in ice_parser_profile_init
>=20
> set_bit(rslt->ptype, prof->ptypes) operates on a DECLARE_BITMAP of ICE_FL=
OW_PTYPE_MAX (1024) bits. Nothing prevents a malicious VF from providing pt=
ype >=3D 1024 through VIRTCHNL, resulting in a write past the end of the bi=
tmap and a kernel page fault.
>=20
> Reproduced with a custom kernel module injecting a crafted VIRTCHNL_OP_AD=
D_RSS_CFG on E810-C QSFP (8086:1592), FW 4.91 0x800214af 1.3909.0, ICE COMM=
S DDP 1.3.53.0, kernel 7.1.0-rc1.
>=20
> crash_parser: ice_parser_profile_init @ ffffffffc0d61b60
> crash_parser: setting ptype=3D0xffff (max valid=3D1023)
> crash_parser: calling ice_parser_profile_init -- expect OOB crash!
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> Oops: Oops: 0002 [#1] SMP NOPTI
> CPU: 56 UID: 0 PID: 165011 Comm: insmod Kdump: loaded Tainted: G S U OE 7=
.1.0-rc1 #1 Hardware name: Intel Corporation S2600BPB/S2600BPB
> RIP: 0010:ice_parser_profile_init+0x2d/0x1d0 [ice] Call Trace:
>  <TASK>
>  ? __pfx_ice_parser_profile_init+0x10/0x10 [ice]
>  crash_init+0x127/0xff0 [crash_parser]
>  do_one_initcall+0x45/0x310
>  do_init_module+0x64/0x270
>  init_module_from_file+0xcc/0xf0
>  idempotent_init_module+0x17b/0x280
>  __x64_sys_finit_module+0x6e/0xe0
>=20
> Bail out early with -EINVAL when ptype is out of range.
>=20
> Fixes: e312b3a1e209 ("ice: add API for parser profile initialization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_parser.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

