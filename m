Return-Path: <netdev+bounces-273891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB3DEsyqzGnNVAYAu9opvQ
	(envelope-from <netdev+bounces-273891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 07:19:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AE8374D8D
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 07:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25A7E3006B7B
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 05:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B92D061C;
	Wed,  1 Apr 2026 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHc8lIUj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F8296BCB;
	Wed,  1 Apr 2026 05:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775020744; cv=fail; b=PSvzeLvn1y6LuU5tV268DX7srQoccq+Llvu5Ab/C/tQbrv6kPithvzB6ZbGJ+99tNm5FSwOfmFlOjWaWxnQuB3HM3eVVHReql1nV20UhRv/02mO8EW0jEn+I1QFZjskbPxqoqYCSOf01Zdm4++4AvnhxUNBaqVVAhCcUZnyF+wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775020744; c=relaxed/simple;
	bh=2/o9LzAFFJ4I+IR3VvGww6FDKjFdKRdB/Zj9m5FvtFI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=azJZsag6OYcH0/py8JItMBPa5CUjqFbcfBtdAPTSN+TQZWi0aPj4ppO6kg1jXe0R3hggiC/vR4kfSBmeIfLJU8zhTbEWJl3kvsRXFswpFyGTUBaaGiR+KoURh3lQ826ex7pxzgzP2G9MsfZwwXYdtxtHgKev3B7j+aOz1PlSZWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHc8lIUj; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775020743; x=1806556743;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=2/o9LzAFFJ4I+IR3VvGww6FDKjFdKRdB/Zj9m5FvtFI=;
  b=GHc8lIUjq+nz0EvBHjnhvxMOOAmlxpXW8Pu25EqtNy6Q5+fltjvvuP5U
   +p7csVO4XordHeOunLxq0Pnm9adYfreHbil9mhNmJYIKqHYxX91z6rjkU
   haYx9NfGuZdgoMH6ahhcH7W8kp2UDeTVanjOf+SDUkBwDbhvdISLba9aT
   24ZAXtzML/qK0BMpXuLdljd2WSts5RjS6fk+U8YPjkHaNXi0MkI0KVZdJ
   PepUfGxfKJBfWqaJMSrA9q0L4H9a27l+dBk/KXgLdEJfIPMq2Ji5qzmcb
   /lViIafM4adReZDSypn+fAQZtWw0rKhlZgNjOohSLN7u1dC4E2Vkg+ppm
   g==;
X-CSE-ConnectionGUID: Aa+T4khWS8CTvVrxAOYpKg==
X-CSE-MsgGUID: yMsXbBRcTMSsL/kQK88ABw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75934563"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75934563"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 22:19:03 -0700
X-CSE-ConnectionGUID: jkCPRS3GSIKwU/41O6TZcA==
X-CSE-MsgGUID: 5BBY8wHlQgmBN3Zt3HMRhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="231370515"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 22:19:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:19:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 22:19:00 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:19:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkUv/o848dRlU0cKMyJDCGiA1l1TiYjVadRAzmO0x6+e1T94FV+iniZwFobLMhw5ad8M5FJRSkycUSrt7uzLXZkwioKVmqm33pCEaIf7NRYEcASbov3X1aFIl5Dot9tmPt6D1uqdoD0eeMhno3N6tC+JvWY7jzL3qtd0VeP85KZ9A0IRlloPkb1h6q059mImAIYdRsNZRpfC0VN+6XK+OHySkIE+GHh76SRJCim69VRXh4PFrkpoahJ4SdkVdAcrNJ3kgG7oUestv/QT6esdDqvjFOxAUo/Iz490g/h33pcw5WDWJ7WpWpQFcTbgRj/7bDkC/IfvUDAJFsywH0CM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUHNG+2vYItgjPnTSFNwO9nWR5SRbAwXnxD+PKkY6jE=;
 b=bAGIu/dvi1ZfvjeAvNwvs2oDt3Ai823+wbFnntf1MzGymi1suBK4jQQHsJVeP+VySue5Pg13Wp4VsxnUZc3sBEcFZq6YIPxoqj+5SC9vRR8azGcf8dLs+HcURYeu/dNWZvaX1iUf0u+u5zRnjITFm6SL1Sn9YbnMvJfArh5d7aavxYjucwr4JC0jX4XFcYDkJ7mDkfQNpRoasXtBAG01Fykz9yuR6107bmcdeV5Rsnu0PaLSl4YLEo99nzmAqGrIyKFbKxkzpKSI8J5w+Ax2+BY0HrlQ28mQw4tmsvYOcTYggVlB8Gn1UO/k5bW2OHDINsj5rSF8YO8sx1la8T8xLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PPF5217261E0.namprd11.prod.outlook.com (2603:10b6:f:fc00::f21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 05:18:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 05:18:58 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2026 22:18:55 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Message-ID: <69ccaabf8d9cc_1b0cc6100fd@dwillia2-mobl4.notmuch>
In-Reply-To: <20260330143827.1278677-7-alejandro.lucero-palau@amd.com>
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
 <20260330143827.1278677-7-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v25 06/11] cxl/hdm: Add support for getting region from
 committed decoder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:303:8d::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PPF5217261E0:EE_
X-MS-Office365-Filtering-Correlation-Id: 75daa7ed-e51e-42d5-9683-08de8fae2d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: GkqEpJeWADo2MgTEPci7eqypDlrp2CKA/Bd42c1kB3jxexz7pdlXzROT8fZLBEP8hG8QY4qOwjp2WNnI2j6E9RrR4bJyFxBzr31G2FtHixzuCLb/QSONxVgGgjpodg0UZAwoxQhaovHwVsdub9mSABEHqBIDJ75f+wMvCPjZCJVipKAFgyXESoDusL5as7MTsDJANyQujWCHBPiNLtxZd33AJIAkxSm9bfpodrGi5W3I5cI5Aycko32Aq5mAQypIPByFIrjmDsdJ3nii1viM0uxxgxLr07vMm3FWwt0f+GBw+zyjfNr5jTvjoSHxypzR+IbW3r5tPbwB6kJoWMNRxcIyRLzF0NTBgceRsE/nQGErABApZkwWkIzlX7+5v8fDngTZGBEeC1MeLJyjm3yfq4ZhGZys6tZ30VlGRqWq2irIvnR0BST94hBNfNBpTp0LwAOPdR2bTx+IFanvmsHqNAQVwAquGi47sts3GF8PZMnGqLLfceiZzSN1R2N1EXqGwcKXaIRNR2sdoTT9gtZzYYYNFHLFhXV7gC0t9yODbRqlwg7sxbS6TM6hVlrf3bvqT+QI+0v0ZzzGQKu38PE/9kH8IbUi9vWpdCSAGxQ5wL5OCsC7LXvUYTzhC8GdUDP2I7EZxpsrfOeFvq+ue5T3dAiPXK+awYqtASyn9KjKE8IFloUmwoJSME8ejKldDxIgpDgII8bwnDO1vdGpXvfUXYe5O3NOQ7kso0YmauIilKnO1ONToSMIgsmnVFcZpUKYWPWzO+u0ey9YXGE9L1XELA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MisxQ1lCOU9YYmczclRxSnYrUDREU1oxdFJQYVc2NGtROGZGTm8zR2lRUXhz?=
 =?utf-8?B?NUVqRDdUNzN0emoyU2pFMkpWVEd3Z3p2aHd4cm1oaFRMRG1IVHBtWFpFcVV3?=
 =?utf-8?B?QklrWUtDcjVVOU1MckVWbng4WTFQeE1GSU43c0pKd1JzM2p1Q2tWbGhNOTBm?=
 =?utf-8?B?SzA0R3h0Sk1Zdm05dWdtQWplaXEvSEtSbUFkZnBqejZydDdpUHU4ZEErVTQ0?=
 =?utf-8?B?c0hIS01VUkJYUWV0a2Z1bjU3Nms2QnhUdEloV3pBaWtRa2hXU1kvZ3lIUGNB?=
 =?utf-8?B?U0Q2VnIyclpkVlUzaEVMRUxkbzVHSThtMXp1UDR3ZW9qVTl2VVpsNTI2bVV3?=
 =?utf-8?B?RGR0WUE3VkRQUjBCUUJHM0pTUmFrZFF1blVjVFVXbXpDYnl1NTJGVEpabzVq?=
 =?utf-8?B?eWlBQkFpQ2FmWWNGelp3L3VWWi9CdWVsT2xwMnpYRWRMaTRsRjRKVk5nZFBs?=
 =?utf-8?B?eTBGZFBDcVJtT3kvUzIrcUN1dVBlNm5hT1hDQVdVR2VKTUhYRTZRWVBESkNa?=
 =?utf-8?B?UEFBamwyYXZOT1VnRWcrUWtyQURkK2dmUkY4a1NDQnRwQXdzNFlaRGpoYWlm?=
 =?utf-8?B?aGlFOW55Q21Wa1VjdlRaZmJqc3cvN3VORGpySU5zb095NHQrTFk4Q1lBeEdV?=
 =?utf-8?B?aDVJRlpFUDhKdmdnR0FvaDljWVVTaE9wNkwzbmxTUC9YNk5JNU9sQjdmUDBm?=
 =?utf-8?B?YmhzU1ZPLzRLSnpmMCtpQ3VPWk5nZlRpVzA1Y1hUcmJLUmcxR1RoOUQxL3cy?=
 =?utf-8?B?NjlqR2N0b0NIWkdQcGU3S2ZWeFZmTmV4L21OUTZPbkdSZmFHdkdqYm41THp4?=
 =?utf-8?B?Q3VrekwxczBTZ0plUDdGQ20zZ0g2bTVWYzk3ODE0UC9HZTBRUUJyaXBjSUFy?=
 =?utf-8?B?RXlGUDRvY2dNdFRKRGRXbi9MajJ2M01KczdkUDFzazBpY294N21PYkZmSTBs?=
 =?utf-8?B?TUFmUmhBdUFzbThtSDFYQWt5a2VoNy9BY0FYNHR1bnArUmVvUGpZQXJhV2Y2?=
 =?utf-8?B?aHpkNkgwRnUyM2NDZkszWTFSUmN5S1NRT3R4Y3I5S1YvaVl0VkUyY0Nocktv?=
 =?utf-8?B?d2NqZkc1cDNBNWRid3p0bjRXanhZWHo3ZkRqM3gvbHd2VGtUc28xb080djN5?=
 =?utf-8?B?R2pURzRlOUozdXVCc0NzcENZUElvVnFFdUk3TXNzbTFWd0cwNmJ5S2QwenN0?=
 =?utf-8?B?RGxlckFhUUtRZVZyTFZBZFVVY1cza0NTaDh0Rjl1Vk9jQVlkL0s4alZrZk5k?=
 =?utf-8?B?aHdVWGlHbk5DMXBWY0dnby9SeEt3VjNWSTV0TmxUd3B1Q21yT3A3NGwwQlVE?=
 =?utf-8?B?NFd4eUUvZ0szb3RWS3NCS0MybGtDalFUWHd6T3lheVcxWnpmcHYwUXJHMERY?=
 =?utf-8?B?SEdCSjE2SjFaVzFQWWRSSkhxbkdEWGw1MjNHZCtBS1huSk9PMFpYUnRkd2pC?=
 =?utf-8?B?Q3RROEVMdFdFcHNZQkcwclVuMkJnVWJnYUNXa3BZaUQrci9GQW95VmNrK1dV?=
 =?utf-8?B?aHBtdTM2WnZmak1FS2Y0dzN5N0RPWVp1aENmdXU3WWdJMU5DUlVQZ200KzRI?=
 =?utf-8?B?RHZhdGZiTTFhNGgrMU1qT0UwNW92OUo1UUhKRERpUC9YalJMWlQ2eXFBL3Jt?=
 =?utf-8?B?UElGbWx2cGNOV1dsNlVqOWxLLzdKU0YzZEVCY3VhaWNnZFdYTmwzcFFyaFZI?=
 =?utf-8?B?cGtRNUhTQ0tybkF4UjArSnZBVlJHNzhRWWpwUWUrTzY2eDdpTHk2N1kzOG1i?=
 =?utf-8?B?UExQRjhSblQ3S0Q2TFRKbFNURDZjZzArL2c2dXVsUHp1U0dzRWdTS3U5OXk2?=
 =?utf-8?B?NFNwbWtnUmljWXJqQUtGdjJIYjJUb2NYUnl4d1Bid2JsK1NCclRrSXFkcEZG?=
 =?utf-8?B?ejBjZzBxR3VXSVY1YXFIampNbW9LL2wxdWhvU0c3UEx6QTliTHlxNmNnVCtE?=
 =?utf-8?B?UkhrSDJES1F4TE05WnNOT3ZEMys1Y0IwU2VvbmFWT1kzUzFqemFta0t3T0Z5?=
 =?utf-8?B?WklGK3cxS3R6VFFpTDQ5b2w0ZFp2dUYyMitGY01MRERmTGZrc1JxaU1SZlhD?=
 =?utf-8?B?NFVTT1UrTkRwZ2RCZllzUzJtWjJGYnRHemlFY3dKYkl2bEtQNCt6MW9MSnA3?=
 =?utf-8?B?MUhWdmY0SngvUXZHSjdBUnVNSytSZlNjWlU0MTBhK1lKWUZVQzg2RlBoTXJI?=
 =?utf-8?B?REhhV3k2RjN5NzVtL2ZHUjdnL204enRWUVh1WW9KQWVINzVDZDBCanJ6U0RT?=
 =?utf-8?B?cTNUV2RnWGVZTnJ0UTBqQ2xuajVqTXIxQittbGJydmtkNkxNQnJCWXlIYnlN?=
 =?utf-8?B?aHg0V2FpSUo3YkNMS000bUg5WlNaWW9NZHI3elRiS016YlF1ZVUvUGcxSmth?=
 =?utf-8?Q?cZSfIli2U3eaDiMk=3D?=
X-Exchange-RoutingPolicyChecked: dMgP2K2Oxo+InKL+tNfvTV/CU67yi6Ic1GhGJsr2qqaJ2dYwT990zXrK2fCPywcmQuKu0c3AhUXdXv5X0L3xph1em11/VBXS6c4LwOwdmfVkEwW4qmsSkAsXDZIWLvNY5lXqnV56bVVNtvTuAfeXgB6Mfe++32Zwm++WE9XPqBs50aMkV5o98t1k02MrgZ5wnf9tz3IDcnB0r/dxy2CQD5Zfyj/uVDggdJBF6Y6WDWWY9qAasLnLiwSteloZz0eQ6l5/v8/g34mHd2tHfogHR+5b812pL4h04Czsk0V/mHviwNKN+KgL7CiLmffPBM6oiuixxHBXDwKUyH8qMR717A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75daa7ed-e51e-42d5-9683-08de8fae2d65
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 05:18:58.3426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuPxh/8uhTyVHDTKLUQOp5zKvU1XPVM6rFnPQWpjJL0RxdM86rLbNdrWi3R1abpU7+1dKUYWw0A01ZpKOv+Z3IhVqB+ukYWc7WxY2JUT2a4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5217261E0
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273891-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E4AE8374D8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A Type2 device configured by the BIOS can have its HDM committed and
> a cxl region linked by auto discovery when the device memdev is created.
> 
> Add a function for a Type2 driver to obtain such a region.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
[..]
> +/**
> + * cxl_get_region_from_committed_decoder - obtain a pointer to a region
> + * @cxlmd: CXL memdev from an endpoint device
> + *
> + * An accelerator decoder can be set up by the firmware/BIOS and the auto
> + * discovery region creation triggered by the memdev object initialization.
> + * Using this function the related driver can obtain such a region.
> + *
> + * Only one committed HDM is expected, returning the first one found.
> + *
> + * Return pointer to a region or NULL
> + */
> +struct cxl_region *cxl_get_region_from_committed_decoder(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	if (!endpoint)
> +		return NULL;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	struct device *cxled_dev __free(put_device) =
> +		device_find_child(&endpoint->dev, NULL,
> +				  find_committed_endpoint_decoder);
> +
> +	if (!cxled_dev)
> +		return NULL;
> +
> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
> +
> +	return cxled->cxld.region;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_from_committed_decoder, "CXL");

As soon as this function returns there is no guarantee that the region
is still valid.

