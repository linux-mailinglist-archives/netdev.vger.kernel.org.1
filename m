Return-Path: <netdev+bounces-174977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E845A61C7A
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 21:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E12B46048D
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 20:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED859204F92;
	Fri, 14 Mar 2025 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFvqfsaN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A91204C18
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983881; cv=fail; b=H5fm8Q2aey7Dkr1FZxmw3BA6H07Pf5pD8XIWFBobUJtZzRoJd5I7vNJ4ZOooxIzfa4L4RGVOUhx21njBr6wOBKLjjIQbmlywJ88XgLpdJfR9ULIq6h9ugvsNqHMM/TcLaoMdUAzv66GEHv9WOOq1GOT050eNx1kp0eNl5EuP/5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983881; c=relaxed/simple;
	bh=EjgZ3pPq7seEqOSrLpM1YgiAvf0j9O75ODlew3hhDOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fnwlvOR97VrSBmNzCteUvAd0BhKTMm+KG1c9tfhLbUFXM4lWTVbjaEwwqM8Qt2yH5SZstE7yzdG2++Uz9JzQNJjzGSXtkeVxLN/yuo5Iup3qDfCs/P+GEV69DQq0WTBROKlHi5cZDY6Xmb1syBLBcvc8yAUlrfw+85nCwuLFPTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFvqfsaN; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741983880; x=1773519880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EjgZ3pPq7seEqOSrLpM1YgiAvf0j9O75ODlew3hhDOc=;
  b=BFvqfsaNEexod3BMkcTHzIPH1jsx5dOus1GyvynL78L5I3M/s8m7/iwC
   N/zig35dKB/6Bv9NfJwnzyjUh4w2vXmfCk/3PqYsHDbvv1KoMUsK0ahQX
   y9832NqlygjH2hI+KTuYFMWjpI7VkT4HIbDCWUFuqj8iN4Mi8oPBROYQk
   z86z1bezx7FCfyV5Ktw0yYNlHBHqcgOWMpY735X8c6/yO1bWE64ewTBUq
   fazLG5dpo+Z2DXGX8NhuUfpEUGiAKiVlW7EiaVNikPKAS4WY0p9IjqDos
   1cGnleibkCq9gX4YxCuhMUQcQpx7FJNkMF8N6q9MK5+MlQWdosfziCGBv
   A==;
X-CSE-ConnectionGUID: KcJpzeuvQH+fLpoxq9jH/g==
X-CSE-MsgGUID: 8iq08nKjTGWAN1Zwer5WAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="45914087"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="45914087"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 13:24:39 -0700
X-CSE-ConnectionGUID: 9H6ipCVnTlW5ElT7lFkqwg==
X-CSE-MsgGUID: A7/DhdEoQGqqAMOQCZ+HFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121414473"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2025 13:24:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Mar 2025 13:24:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 13:24:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 13:24:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQV5vUp+id3O8xVrgSyrnm/mpT5jmHHrsAqhpbxZGmIS9c5IieLWDP9I/HrW9pYacG2/uMdKYdoJzYwGEO4amLxnjSVssJR4rK3L4Noo2RlWGxTB7Jm6znYr/5FgJxuXRcdEg7M29Kiccw1Z/SdxcHD0J0JKMfsWFRIxQqzFlxTvMnLtePYnTdJ07uLc9/CkU+Y3q4rFovP808RsCaSBjheBDJV9OYH3VgGA6b4T3M+vUIBlEd2KSImqQ048VUz3HNPoX2PdTcr4r+A1wLmrySztooRRHPRzW5jLOU2QD8EYLqhURrf7uJ7483OhpXH9ua2V4a3/jGyh+62EzrcgvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjgZ3pPq7seEqOSrLpM1YgiAvf0j9O75ODlew3hhDOc=;
 b=OMlWxvAvV6lY8tfKu2TI8aI7NLOHHud9JuFLEgckUgyeWw0j4ZQRQtIQ8qHLuV46LQEXHfGYf3YRZ+49H51rg3KZIrVuzCXacrqwKPoAyVyJ2vN9rgRTfQ5GFjyP9gn6ot0A9xnh0z8cnoL2NrKewFtenxh+ZUDt73TYiGboHDQAG2ufrOXIsJ3ZO9lnaUxS/E4amN1h71Gyp7XLUX48lC+aaI6pSB9IcDds+xQjNA3zTJT5rDxvWQFNpkQZTQneNgKSiKH+Vdwm0bvoFVxGR8Jw/hfUJ7zZdHOZqbdAuuoDCd+iu6HgUAFXTlagQJBwSvkd4e3YMApfmcHP+CzfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by CY8PR11MB7922.namprd11.prod.outlook.com (2603:10b6:930:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 20:24:05 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 20:24:05 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Olech, Milena" <milena.olech@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Willem de Bruijn
	<willemb@google.com>, Mina Almasry <almasrymina@google.com>
Subject: RE: [Intel-wired-lan] [PATCH v9 iwl-next 02/10] virtchnl: add PTP
 virtchnl definitions
Thread-Topic: [Intel-wired-lan] [PATCH v9 iwl-next 02/10] virtchnl: add PTP
 virtchnl definitions
Thread-Index: AQHblELY4eNhulbH00S4QP/R4XrxMbNzCMCg
Date: Fri, 14 Mar 2025 20:24:03 +0000
Message-ID: <SJ1PR11MB62978EAC5D04DD059113CE3C9BD22@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250313180417.2348593-1-milena.olech@intel.com>
 <20250313180417.2348593-3-milena.olech@intel.com>
In-Reply-To: <20250313180417.2348593-3-milena.olech@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|CY8PR11MB7922:EE_
x-ms-office365-filtering-correlation-id: f22841ef-0b38-4de4-08cd-08dd63362ac9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jxWt2GD/T+fNcpbnRsgxSrM2s+kl41OZz9JeGhLrPVNAUcdi/8FfzSHvQlEE?=
 =?us-ascii?Q?EmrbmMdMxDwNBrzPYM6F2T0FfOUAvtNzGluUP4fSaS79KG4lgnr6KJvbemKc?=
 =?us-ascii?Q?ShxB8aq26Gr0osPRArEVaY+UMSbmDig8wKUD28Y7xw0gzitnWl3jDUgIIFRy?=
 =?us-ascii?Q?NyWefHc2dpLeBH4LHInBJjspsg0i9z9KpGe9ylzg4dkk13FLlMKSn1BTC9Qf?=
 =?us-ascii?Q?1+T1fqa8KJWHmMgxRFhyh42HI0Mj9OTDyodA42xgbp4Ab1MUNlMWzhIG37vX?=
 =?us-ascii?Q?CIqIONCsujNLPeaII0kJbeht+3TbXQChEnoylypNrOcwyRO98Fe1/8RcAjnc?=
 =?us-ascii?Q?bQRH4oZvd7jH/KPE59W380UgyTVbhFKcK9TKTlBvbc/KtA6n4g4Dpd05+TFE?=
 =?us-ascii?Q?6WF0+Q+aKD9LYbia7jZX7P3Sy+On+MwRh/e6Y0OklGKoTxretn4zg19ZqPYS?=
 =?us-ascii?Q?R0OtX0GuD/lCib2uyAyqOvZfI4oSYy2HiVn9FG9YQrZAlDcsJfuEiSmbbpUN?=
 =?us-ascii?Q?gLPK/dHQeCBhNiY5BmLCiojLX935CDmLTKz+mCHMZLBMXG3nuS3z7fG7d/bT?=
 =?us-ascii?Q?2+y8F1XbnMJpLoSfyC8iuzTfGwwDusvlX9hdjHSgRotESENDg9/7UW202/gH?=
 =?us-ascii?Q?zwX1eH4oRWgcf2ceRahOGYuBh1kfhmYcerM8ArAcTTEUi0t+EuNJEJtCszup?=
 =?us-ascii?Q?VPXoVo4d90qDWoLmbxb+sA/PDrCOV81kaT7d9+6NHdBuf+1TSUEr1NmH8iLC?=
 =?us-ascii?Q?jQSXejSjUTU2nH8kh3xIeYZhjGlYJm23acS5JQ2k7rmTUrI6kydrq1EAxPFT?=
 =?us-ascii?Q?+plpP9IVmRqUHmvHSokdXmolJaq5BuWifubjofIW3c2zP34zZf106mKlI2OL?=
 =?us-ascii?Q?TJXV9ylmUX/Swqxe1X8/+AuzXPYasbO+HRA10kDlB0QEMEDd4yUs2cAQA8mk?=
 =?us-ascii?Q?diJ+7OAcIvqVrDCLhCFejZERvAyD+IzN0n8GRwL2KzFTWVJUDzU6V4cw2LYV?=
 =?us-ascii?Q?KeXRq30EVD/YvVXlrW4kBgWAWJJ/en2YGYhW5ihIbIgV1pLJ1RTzAoy9ATuh?=
 =?us-ascii?Q?94LhPMOZGPK5+ClPoQrAZ5XqnMwQQ8GynyBxPbA1Zqw0NqqV19GdGkjeDWBp?=
 =?us-ascii?Q?1WzuT0Wv3VgE8GOREWN/LUF8o+ut7wBPwsF/heIXwIxfaqT/81SbuohmofF7?=
 =?us-ascii?Q?YJVCG7qfKDIEdNBZbAAETjjFxv6YyLek7oV/FhrUKPcq+VggkCmGD3rrzu6R?=
 =?us-ascii?Q?gdywv6bz9USIHXLcSAp51BsrJ5l4TgxUJkf/6IhIGdXWD8utVfTVWkAk6J5b?=
 =?us-ascii?Q?Q6gYHAkm9efK3I+H1j+YbdtPi3qJYiKeJhunUzj7lHmj9/QuUrbgXH6ynoz+?=
 =?us-ascii?Q?0jVpDHZlcBK+Ll91T36EVBtDEAM7dsqwbV0VH+q4A+1syWpIDrfly/iYp9VZ?=
 =?us-ascii?Q?44vrEyDC+h+iacNHy+6Tof0Uef5hNtkD?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RDB7HLIgJYa7H83upArePbAvGVEAucrxmci/yBMe/9lWnPvXC+Svvmsgsa+U?=
 =?us-ascii?Q?4AU0h7NpP54m28al9GCgIIUh9phF4+YaCwjt+QhRVB5sfCwJ3adi+0dWnUY4?=
 =?us-ascii?Q?IG/7+b01c92Wa4/dfla+tIh/PQK+8Sc5uA/Q9jNsZNnBuTMkNG0CWryrmE7q?=
 =?us-ascii?Q?E0ZJ0Rt6OtodmuiNaMeEFdvj27Yrhij5N0JXgovC9MI5V3zqISArnTCLpfsr?=
 =?us-ascii?Q?tHKPqEK09H/82gTO8yk1SXDBHyCj6LSj7Xpw5RMNplNtOYpauU4zWG/7bVPA?=
 =?us-ascii?Q?jK6uswMYuB7+v+jWf3nAW08FVpoKp8RA+7UEbMmPAOLaA0M29rzqw9MqsFgu?=
 =?us-ascii?Q?W1F0YH1SBlAUasPqlb+YAypAQxHB5NCxg//T5rcRpUpVbbjH0MjWhJenIMew?=
 =?us-ascii?Q?hwW6OL2SmfUGtUJ0RQFX+lDeB4cxUypfR+IF1xoYVcKg5cvTgWbQJ8HHfS7e?=
 =?us-ascii?Q?6hg1dk81AEDISjyBm0G2k81A/Ibj7H47RIS4VTC/E+tLGLJ/sBegAGNrJ3zl?=
 =?us-ascii?Q?QdVraLbaEIcjWm5KpfQVICZEhfJhoYtCmmbdCyvTnpW+eN82qkvkTASZmjFb?=
 =?us-ascii?Q?73LeJzSCQsQo1Vqwe05Yr+TJ4TtdDFYV7nWmUh4EsWRUVklLI3CNtIzqeXtN?=
 =?us-ascii?Q?VHINdi5odwcfTrsnxtVBba5PE7u9lcMkVZujo+D6YZ5/ENUz7jfFKuurlh52?=
 =?us-ascii?Q?GJd8eyxiI4lO8eSQRNBVe3rwI7fyq5PcPSrGwALjtspmccSQCfkpPOdEALsW?=
 =?us-ascii?Q?zFb8PLupxY6Grutyhx/yrA8lNBJW7r9ykLjZSSC9IztqDh/KMy0p/PytBGBU?=
 =?us-ascii?Q?Gp5jL0JP+zLo1HT5bB+kTwWwNyYmBkd/P71PdtQKHWyKFe8rNgGHI3GH0dBt?=
 =?us-ascii?Q?ycDwBZ4ud8/UDTs0oxUoPN7tOj07FsNi9puSmmhCmUlsAJI/iD4NyWL1gtHW?=
 =?us-ascii?Q?Z1iswbgmJs6ta14BAj3XRntH9BoPzm/lXiLum5hf8JaoUgbqpnr2vsFrhgxy?=
 =?us-ascii?Q?ud92uBENc3rkta0VSAFq6kK3Zp9X4mB7KlhCyU3nv3nvPymgD5q/Qcpeif/o?=
 =?us-ascii?Q?uGr9bAPock7u56Je8BSPFZWfp2TvtZQVCimEoiKcCfa00P2+fmiD+mZKrSo7?=
 =?us-ascii?Q?4OmPWvtAz7GncaBLsgDLgtkwC9WjhyUG9glVpAcIsmLkmwvf7HHu+8JCVWFa?=
 =?us-ascii?Q?xT6pCLSbo4A83Uux/LIb01u8+gY6ncph/8YlkaVFsuU7dwORuQ2Z6+SBQVNr?=
 =?us-ascii?Q?VhkhjjOJAS8uiUKbieBqWgN0dG4NXRbo/M8LBAzA/9RxcnSgUp8QLdhauJdX?=
 =?us-ascii?Q?1n3Sg4NbiL/1MWg414YQp0e/hhZ4bfbZBVB2bG8Y+4QrSlIvJym/EvyBrTF/?=
 =?us-ascii?Q?qnhhMKZ9D0e5Vt/S1HwwEV8sy6BmA7An78iqa6DWEomPPm2npi0G1Cz84Gdy?=
 =?us-ascii?Q?9CcjcykbiZqKAp98ihRHT+8gGmwrkV13QXNfunQNKuql9FFScBM9ohaekPBk?=
 =?us-ascii?Q?ooR7LPaJd/5lAy7mvJV4BtzHttuqD56WWltO/8xfdf4dxUwUaqWppa4hPQSh?=
 =?us-ascii?Q?pKCzBHg0lanrCGnH45X9lSvA2HmkLU5IBCXjuqKd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22841ef-0b38-4de4-08cd-08dd63362ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 20:24:03.4502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dkcJ74QJ5l5+SpcOEspvN0ak0UZVfKbfQHt9EJ+P4dgu5k8LncoLPeGb3EP+/soGO33OhBYuB9XCMkzoTYDT7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7922
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Milena Olech
> Sent: Thursday, March 13, 2025 11:04 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Olech, Milena <milena.olech@intel.com>;
> Lobakin, Aleksander <aleksander.lobakin@intel.com>; Willem de Bruijn
> <willemb@google.com>; Mina Almasry <almasrymina@google.com>
> Subject: [Intel-wired-lan] [PATCH v9 iwl-next 02/10] virtchnl: add PTP vi=
rtchnl
> definitions
>=20
> PTP capabilities are negotiated using virtchnl commands. There are two
> available modes of the PTP support: direct and mailbox. When the direct
> access to PTP resources is negotiated, virtchnl messages returns a set of
> registers that allow read/write directly. When the mailbox access to PTP
> resources is negotiated, virtchnl messages are used to access PTP clock a=
nd to
> read the timestamp values.
>=20
> Virtchnl API covers both modes and exposes a set of PTP capabilities.
>=20
> Using virtchnl API, the driver recognizes also HW abilities - maximum
> adjustment of the clock and the basic increment value.
>=20
> Additionally, API allows to configure the secondary mailbox, dedicated
> exclusively for PTP purposes.
>=20
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Tested-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
> 2.31.1

Tested-by: Samuel Salin <Samuel.salin@intel.com>


