Return-Path: <netdev+bounces-218648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066C8B3DC24
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFFEB17C60E
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465C42E090B;
	Mon,  1 Sep 2025 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmJo526c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A2A233149;
	Mon,  1 Sep 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714752; cv=fail; b=n3iG5eFLLm8AnMFjImnG2G8DZWNbwiTlVr8ZviNSrGogxR0yKWvLQk6BrpZMjuJGTD3bJVHLZgHpEMS7FmEOpBCxzKhkpaEJKpIzmDBNHiY9oLHhGXCMWB3/B13uVOBKPEc2H7D5crv4x2h3S36iLxzB+aqJKsqe8xQYli+pbDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714752; c=relaxed/simple;
	bh=hZ+Af01QsfWuysSmcKepAzyXyZzrrLCYdQeHexHeekI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gl3/2im9P2vVN9+iLYtaX+R7UncNYqiKbR/Nja7EPKdYM3vYcwEG773aJ+7QOXGIdKviYO+5+8mHJ0CzpbTqohKLXFu1RsV+OCtQ7z8c5Ns3yEzlsVu4CfM6iXQH81pr0rx2zNoAskccGoZNOydSSNbIOABX5Pwjg2k2KaT05dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmJo526c; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756714750; x=1788250750;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hZ+Af01QsfWuysSmcKepAzyXyZzrrLCYdQeHexHeekI=;
  b=OmJo526cU0YBgc25W2Aioo3/KLbJMYK7fpe1fQdrPj4V6G2bGJw9IB6T
   vfx0SSh1KXJnbqMnpmcSAq++Mk02KjssTJM42si2HkKKYIeOHzBF3giJ7
   mq0k2oqDq4ScjgHoOqFuoMNS1OE6DlX0A5mv+oc1FYavRFV4wwL1o42Ul
   XI0L9hIHFW2LS5PX9ezSgrvaycm1NwmE0divJWI1kDPbwhj0M7qM7aMU/
   hd8tZ0kBfmu+R0xRU7NOc4SzSqqOxOj1xPIWV7zgsx6D1Ou25rbi/0jRX
   8Lh3/N/dV5oHiBf8xBo+PyoKS1eH4KSQo0JuJSWYjdj8mRhd8b4ha26+s
   A==;
X-CSE-ConnectionGUID: yU9IY4hnTIOon0sXWyGuNQ==
X-CSE-MsgGUID: IKGlTPeaSw+/NQ3dCb9Asg==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="62760540"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="62760540"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 00:53:57 -0700
X-CSE-ConnectionGUID: rLk7nSTWSaCzpysuCMMU+A==
X-CSE-MsgGUID: F1pKXGQET4q4MKc1SDGYJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="171734731"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 00:53:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 00:53:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 00:53:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 00:53:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAgsRfLXyESlWVHlR00SPbNcmqO+XVh+QJ2VMbtjRnjDvGvINFbARvA/OtKfGiLWB4p0kSlOS+0aiCmUU+V70LUndiNfuy5mOFx8NPjSokYAFjD8IXSmbkAbdm99ge9aF3tZpT5R3HwRHDMJyi4eIij0X4tEkybrBsZ8slW0MrjyRptX/y+fDpDUeTsR3srTmXAYF6sEeZ5V4+2czOy3HOkfQlKCHZjT0O34Ph0k8TtSbiJkEE8f0MYqaADhzdrnC3dfiwaaruZ55c/xn/pexBlfMlMxdDqL06QbWCRa77al2pwWphMB/Qb9novCDx406w7YYIjZjCk1WVCeUkytsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VK85M3QIrk9FHQbImMbHXv93qOGV2pdFQUfY+9rSdIA=;
 b=mEopvF59pZYdgKIJYurZk2to+8cfhy98qZT8W2xOlAHEt4BlbJCyueMHtvhBkEx3wYhv9wcfywuC4L5A8+cOC89vIT5sZi+NnzCOWWNESV6hJ7tj+rr6QcQoDQWu+N77yhnz9edzbqzeXYA/n1zkq5U/w7JHqua54gSdFlhNKNALeae2CvbgY59gAihGxfJjbmTDSM4x/EKZC8gm8/AQLHXLztYQHUdlpmmtDq2kDyL7MoUtQqUxRTNXdwQ5wd4i5QcOxYw/2Epws657XPpn8qn7ysasZsbI5fqvG/0CYx4/VBOwl7BWlhTZxsg6jLaU7OG+jzJdl7q3gfyqN1g6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 07:53:54 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::4a8e:9ecf:87d:f4ca]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::4a8e:9ecf:87d:f4ca%4]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 07:53:54 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Koichiro Den <den@valinux.co.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "mateusz.polchlopek@intel.com"
	<mateusz.polchlopek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [iwl-net] ixgbe: fix too early devlink_free() in ixgbe_remove()
Thread-Topic: [iwl-net] ixgbe: fix too early devlink_free() in ixgbe_remove()
Thread-Index: AQHcF8BbDg9oKq5T5E2PWZi/rf4uBbR9+N+g
Date: Mon, 1 Sep 2025 07:53:54 +0000
Message-ID: <PH0PR11MB5902C5678F60DB7F088CB528F007A@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20250828020558.1450422-1-den@valinux.co.jp>
In-Reply-To: <20250828020558.1450422-1-den@valinux.co.jp>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|PH8PR11MB7966:EE_
x-ms-office365-filtering-correlation-id: e147d153-9c43-4e9f-e445-08dde92cb2dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KYO06TOdkggCChcBY6AU/8skn6Ad/T9vHFkx3ZeiEXaPV/aaP4oMyPlRyyGr?=
 =?us-ascii?Q?tbkAR8f57MADi3brH4Yod5wpfiUgzgQO7toBd5e4YR/EWN0N64dxlWhQa8hW?=
 =?us-ascii?Q?CaHjuvh5Ymp5mwt/eRabHPprbJoGCG05JyzJ+SqZGnt5A7Wy0BKAbsN35f+9?=
 =?us-ascii?Q?a3V7+FNFXVxrCJkuwTMdXqsJXMs1PQvzvvyOtSnNC5FL3kYQ6Eo6FYy1edbF?=
 =?us-ascii?Q?uNkXqF9scUwRMED5tBV92EypDauq1UcersmwkD27z5ivweq0OtkUaNiTn2uy?=
 =?us-ascii?Q?l+7MSW7F6RYRN1ui0dJv8MqauoNm6rS0osdfmmob25yt6peNXI+EZaRfbiWn?=
 =?us-ascii?Q?JWsFaRmsS3m7s96OT14AihrxXQTJrIU8MarYYg5zEww8g/QhVk8laJfjWfRm?=
 =?us-ascii?Q?oKWFq5aqP3bRLgKK915Xc2guxOYgoX8EtO6JsZmNXskXR27BReWjl++MhA7v?=
 =?us-ascii?Q?2OSClolMcjFT0hIIgKngp81X6IuBiim7D57ysJGgBdK2JDUbOX4LHEksD9gG?=
 =?us-ascii?Q?GEuvZqhEu6wvREoYqfDaC7OaRW0K+KjQNnG4ZUGw0PTXuX7P3HGwJ8B9T0CB?=
 =?us-ascii?Q?f3BTHyM8sWm7YV8J5WXla2E0/klsU7csbufnPglafk1B/7uJ2Yr8iiiTtSlT?=
 =?us-ascii?Q?XXhpC4KnHessfdPVTFTiebcBophfuY6/nrVuhT5l9WIQ/75THxQuNQw3Bben?=
 =?us-ascii?Q?03dUUWlVU7gNI3d+XDJDYgiJC3JGa2h7dd10UJ56ICimZA0mAiEplQmAw83z?=
 =?us-ascii?Q?jwmIz70eEg4kDVyWtnvrrdXK3eTL1fvn5Gg1WQemtINQVWglVKComc+ho+Ad?=
 =?us-ascii?Q?ElTrsOdbfrxlA5NHIOC+zmWqfU/Q9XyAPMrqxlzZbl3gBbgpgG6KCz50tqPD?=
 =?us-ascii?Q?fFStjs4yj4mbLyI74xqhwb7ViPN1ZLVxzIU+zpTWJd8bCj4R9+IybLnbJtZb?=
 =?us-ascii?Q?H822/b08An0s1kKxdiS23MKeR74vbRH9ZdBjst5lezYJNJOMle8JlVKlJIcG?=
 =?us-ascii?Q?WWSW/MK5CVmmFspt6ZSIpgJbvv0m0L/BrikFzdQDBHOGiLz78WUzYJ+XamkL?=
 =?us-ascii?Q?tyi6qtY8whDlXsM6BCVrXAQ/1NcHd9l8Ne1qbxpbCRaLrisU9HmpmFeSYdB8?=
 =?us-ascii?Q?b8FtMbZ5y0g9sczHlnieMzySxSdgODELkOWLNrm4T0xkO65AN8LFVdqGzFD3?=
 =?us-ascii?Q?9mhTUObzp5jCtjlW/24vScuqY6Uedd15+jNeCEvfqo7e2rveg6aogYK9PCxi?=
 =?us-ascii?Q?qdncPtIvXUY+p0xaLS3FsUyGy0JjMuJJwNuGbHmVI+qnEhCYtA+wsArbXzrY?=
 =?us-ascii?Q?l0mTu2J5BmOVY+mGgEmMAO2V0GQ0eR7aFu+dxYpVLkJDRUnb4qMqPNP97tiw?=
 =?us-ascii?Q?ZEExsLprgZp5vZRAe0oD7EsxRzfhtsNyhF92gpsTbMIMm/eBwj9mzXlPoGf+?=
 =?us-ascii?Q?3Cz1hNqmxey9a0F6JyJKvAjNxKkX0NZKpJOqDcNbohCpmQ06cOcmka1VHvFd?=
 =?us-ascii?Q?fxAuc7FPA/+Kf5E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?voOIZ6JrddaLG+DOQfWyTaYhw75GfPrsGq71Us1sHuAP8M74L7HM7dC/+HhL?=
 =?us-ascii?Q?cqWhcITxdtBl7Z4zJku6zCkZnc4C3e5tntjNH9GbHJ/60ZcoiqLsxx9EydTG?=
 =?us-ascii?Q?f+Vu+SaTg4C0xhDgNlKuzoqCrbgLbaVpFwTOcb1VD695nkDsQPC1E+bwujj4?=
 =?us-ascii?Q?a8a8JDODPJMOTaKjoHFFdXEwgmTEBfknJ/bcaqEt+QjcAHsjbTUVdj/0TX6b?=
 =?us-ascii?Q?8k4sFjXVcXJZGhn3cWQj2RvB0v0rug7KmyOZHLmdgW69pAC3UViUokx0mr+g?=
 =?us-ascii?Q?Q//07tCN4hqKSnKqjYpOxgJPdAAt+lRhJGwRnBB3PjJPNJGrUcP23PLGssHj?=
 =?us-ascii?Q?9qfKQiFCLOTSK3Zq8a3HC5mF16PQVAltrB7d27hNyhIFsnjpqmp+8CcSFicj?=
 =?us-ascii?Q?h7+f/JhZUB/JXSgZS5ZUfkLimjhpkMxkyMYeeSYVHM59j/jr6NaqFA/K1AJ2?=
 =?us-ascii?Q?SxIbLEFbPP1z1XrbzzaQRahGGI0Uh/NOQcBiuOeHbz3AdA9YYQiMOPNubTA6?=
 =?us-ascii?Q?8G3lhHQtlVxSdn/LduEPSBP1o3/LHqty/jU/UrB2dCiZCO2cfKVijBxT57LY?=
 =?us-ascii?Q?3LvDIq4btnJ+CI0WIavTeLv197mESwAeigOS56CvZ2r/AR/MAf6MwJDyRPtb?=
 =?us-ascii?Q?+JbSFKdKMqxugAiEbZmz04kMUnPgpKTF60cUpi51gbgJXYGvWr/+yS4uVOAY?=
 =?us-ascii?Q?/I/ICB6nYHmn1yXVNA7Yt9scXxiRPS4bShDfqFdJCA3b95VZOIYeLNr7nwO9?=
 =?us-ascii?Q?niJfhVoxEHEW3lrJK0CcbTGLPgsvtqepNDJpLZg7JyU6HPpfmTrqi7lQ4GHG?=
 =?us-ascii?Q?AtD9e7j6qSdxqwjqFVvARGDgNdb8x739cESbJEjxiOamOB4LDdqDIarxfGwD?=
 =?us-ascii?Q?/7mL1/6vgYid5ZV7hGEjfGxyAYnP/gN+lTrhQC6DjH0rP9CW9n42RD93t/sH?=
 =?us-ascii?Q?o8mawI2kzXxlRTniNKbKpWDwgNs9dfnlM9wVgnY9SMmySYEyp1oPNPwR3Zo6?=
 =?us-ascii?Q?2RV7zb1wxgc1tBHrytEcODB97gWbLxdIVB5RrKs4y2QQHAfR4PAhG2LNK5K3?=
 =?us-ascii?Q?9m3q58PKcoODiOUG0MCeFW36CFwDEvu+qbnp+y97FvBn3AD6ymvEon1nrwJb?=
 =?us-ascii?Q?caLnmIJAtq10Nta8pJxQ0R5AlGzPKU7ZxIm9oD7f3ecn7NwHIhh3Y4zZbAKN?=
 =?us-ascii?Q?OruUr0XSTn5mDoh+IUAOnU+ZbcxVdPN0cVXUCrstMb9U73GnlrZ5AHUM3i7U?=
 =?us-ascii?Q?Hg4CaH7/TSgUK0Kgzj/H9yXivMP9YrmlbdzKqGGD5m9DPGtG+d33ytp8x+24?=
 =?us-ascii?Q?YtU17yrfnx966hCcsHSRPEeka4og5aI7UdCwx8Ktsm2tDh/nM69i9oNNQF9y?=
 =?us-ascii?Q?e1GL6RyZ8nKnlPsmxDCFUbQaHLJQzP0yCWMG+XCDTnp+2BJDP8NraCaxEJuF?=
 =?us-ascii?Q?dAHx+VG9nM6J8FQhFLwQ9LfWI6PLoLJpw4IOL+HhRXit2VFwNI8Xo5U/e+Uw?=
 =?us-ascii?Q?wMjEfFoA19f52gYz96eOZTKzUum13tdN38pFWx4WswEtSmUKOIe/8sHAKob0?=
 =?us-ascii?Q?hX1B4PJupZRdaouOpHulYLcvP0JI3JuvEfDbvBS8v1i199jyH5efPjmstiTz?=
 =?us-ascii?Q?Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e147d153-9c43-4e9f-e445-08dde92cb2dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 07:53:54.4887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juXXiYTokK47pLPH4ZyuTSUpcFJS7cZelnMa52d9s8TmjLYedAtlFKmP+xwkUoHhNDJ3yl1GN4ytkQFjXLUOJxz29KzmpujuPO7lX41OjVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com

From: Koichiro Den <den@valinux.co.jp>=20
Sent: Thursday, August 28, 2025 4:06 AM

>Since ixgbe_adapter is embedded in devlink, calling devlink_free()
>prematurely in the ixgbe_remove() path can sometimes lead to UAF.
>
>Move the devlink cleanup steps to the end. KASAN report:
>
> BUG: KASAN: use-after-free in ixgbe_reset_interrupt_capability+0x140/0x18=
0 [ixgbe]
> Read of size 8 at addr ffff0000adf813e0 by task bash/2095
> CPU: 1 UID: 0 PID: 2095 Comm: bash Tainted: G S  6.17.0-rc2-tnguy.net-que=
ue+ #1 PREEMPT(full)
> [...]
> Call trace:
>  show_stack+0x30/0x90 (C)
>  dump_stack_lvl+0x9c/0xd0
>  print_address_description.constprop.0+0x90/0x310
>  print_report+0x104/0x1f0
>  kasan_report+0x88/0x180
>  __asan_report_load8_noabort+0x20/0x30
>  ixgbe_reset_interrupt_capability+0x140/0x180 [ixgbe]
>  ixgbe_clear_interrupt_scheme+0xf8/0x130 [ixgbe]
>  ixgbe_remove+0x2d0/0x8c0 [ixgbe]
>  pci_device_remove+0xa0/0x220
>  device_remove+0xb8/0x170
>  device_release_driver_internal+0x318/0x490
>  device_driver_detach+0x40/0x68
>  unbind_store+0xec/0x118
>  drv_attr_store+0x64/0xb8
>  sysfs_kf_write+0xcc/0x138
>  kernfs_fop_write_iter+0x294/0x440
>  new_sync_write+0x1fc/0x588
>  vfs_write+0x480/0x6a0
>  ksys_write+0xf0/0x1e0
>  __arm64_sys_write+0x70/0xc0
>  invoke_syscall.constprop.0+0xcc/0x280
>  el0_svc_common.constprop.0+0xa8/0x248
>  do_el0_svc+0x44/0x68
>  el0_svc+0x54/0x160
>  el0t_64_sync_handler+0xa0/0xe8
>  el0t_64_sync+0x1b0/0x1b8
>
>Fixes: a0285236ab93 ("ixgbe: add initial devlink support")
>Signed-off-by: Koichiro Den <den@valinux.co.jp>
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/e=
thernet/intel/ixgbe/ixgbe_main.c
>index 80e6a2ef1350..2b1f3104164c 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>@@ -12090,10 +12090,6 @@ static void ixgbe_remove(struct pci_dev *pdev)
> 	if (netdev->reg_state =3D=3D NETREG_REGISTERED)
> 		unregister_netdev(netdev);
>=20
>-	devl_port_unregister(&adapter->devlink_port);
>-	devl_unlock(adapter->devlink);
>-	devlink_free(adapter->devlink);
>-
> 	ixgbe_stop_ipsec_offload(adapter);
> 	ixgbe_clear_interrupt_scheme(adapter);
>=20
>@@ -12125,6 +12121,10 @@ static void ixgbe_remove(struct pci_dev *pdev)
>=20
> 	if (disable_dev)
> 		pci_disable_device(pdev);
>+
>+	devl_port_unregister(&adapter->devlink_port);
>+	devl_unlock(adapter->devlink);
>+	devlink_free(adapter->devlink);

Thanks for finding and fixing!
I'm fine with putting devlink_free at the very end of ixgbe_remove,
but wouldn't be moving only devlink_free enough?


> }
>=20
> /**
>--=20
>2.48.1


