Return-Path: <netdev+bounces-119551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4AB95624B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 06:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3D31F224DC
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 04:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D2115852F;
	Mon, 19 Aug 2024 03:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXzAXR5c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B1143890
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 03:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039909; cv=fail; b=V0wfU+3Lnh5xDCa+/hWkBIyLlA8/Cis6Dhht2WYxFMnTuKqn8frbngd0oKp3v8CC/mMtegE2o+g1xQM1RrTs06lt8hekVwHPt6LciPEjlFKR4mfX9Wa9ijCNR4oX9fEqGVifbDuEzR27cYGeV5oKrD3JDCfgyWgCPKnrTxQy1EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039909; c=relaxed/simple;
	bh=t8WKK5MPP3zviaCvnXblWRVBxdWrez0jLLO8q7aMOXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DHBK+XF81wn7lvMZ/1mvDU8H+CjajoskG3YCylDC25c/77qQIji/6zfXl2axLbXBqM2er1yNd8pUQTVOqwWfNs0QJQ3azdJ6W4n/nkLXP7G8Lg+CdERenrY6u3htMl2wWItXq7QiWU0FEu61Om1TYIyb1pimmevF1Pg1IUSiJR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXzAXR5c; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724039908; x=1755575908;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t8WKK5MPP3zviaCvnXblWRVBxdWrez0jLLO8q7aMOXs=;
  b=lXzAXR5cqXSr9xRDVqH7YnkGZfhmrxBXgWP2TuWLGkzA4Wd+bPEYXIUL
   atLOqnkWHqnz9wKtXch8y64g4FuINvfjzGMEg65toNBbRURbxj0LJOBsY
   TuOxmpgZ3B2Vvc3h9vC2jYXhzNMKqUtUIba4XYkk3Xw3IHf1cwx0pog94
   ej0qBAN+6OJDKhU3VMd811YbjtG5SHqz9fY9mVId8uufVaACrC0vuPKUb
   +fGeNmbhXFzGgEbhfbB8228d2KOyC4QV6KdUpQEdYwu6OoCe058H1kJYk
   GAebBthKgtpTbMUE8pBob+6DEI0Uo8cXK/3OeboGyTBjhel1qs9QC5VCq
   Q==;
X-CSE-ConnectionGUID: tf3zLmANQYyDCM1KLYuUDA==
X-CSE-MsgGUID: B9+QkKZMTbOYf5wzEcfh/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="32932487"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="32932487"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 20:58:27 -0700
X-CSE-ConnectionGUID: tKKj/nf9QzCtjH4v6b0r1g==
X-CSE-MsgGUID: rv+3usaISo2c8zdFXaS+Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="65205206"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Aug 2024 20:58:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 20:58:27 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 20:58:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 18 Aug 2024 20:58:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 18 Aug 2024 20:58:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEUHEgt/PIPW5eIonlJU8DUTdmA7bDXHn1ZoUrcfPrG77motCUajasBBi40uxoMvnIVkfFugUNoFGyPXLd+9Mcl/nyGiWOS3R6eI8Ms/Q0BIo2Iwu1kNqsS+ksDlXSn8TWWSPmq6IIE22GO5eEiM3iwVJjK+/VkOu+QmBTSAkZVu4v1bfUX6DQUtRFalpIDvyqPm2Cq9BT/N71BGGrgCnbbLhd6WVUWGfrwJh15rlZVfphOZRsdpFyF2sTMGUatsjCpfp+dQc6YAf1c2bwRurZBKpjN/gGB2WRMXPMa+kDM7faSMNNgSXGnGIznYRHAifuSlScZmMsjsJkSZ4zx87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF63tSKsbp+vy+3jjrMbkiA2IW9OxtxEMD/5Fo5HEvM=;
 b=VjpLBna4HnATJpstTuQPwjP/kmZKFVnJ1ZUKUEoLgy0JI7o59SAOhtL7nDY40JG3c1F3Xn5hc1C8RUfglRUoJFzT6XoXKqSTewEsrlcFZTmY7Jy3hOkwwfLlwARjbJRLWSxruxB9GGO6MDlQvyoZghdZxhYhNHESxdxed2kYZ7pyXx7m2lY2AuhmCtTNLFvdAliPsfj83kx6IzTURINgH9zs+Z1nOJ/NE9RqEUC2EbVkopHVOHWSGBX1yqkwcyXgCHTZPGo76pOSJhxah2tm8dmRjIA8NilpalQMLl5xV8F8BApg2D3Xo+CBMEYQB2d+su+wiKDwKbf2/0sY37kTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Mon, 19 Aug
 2024 03:58:25 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 03:58:25 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-next 5/7] ice: Disable shared pin
 on E810 on setfunc
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-next 5/7] ice: Disable shared
 pin on E810 on setfunc
Thread-Index: AQHazIYwR+EssWr10Emcvan1jgYQR7IuPkDg
Date: Mon, 19 Aug 2024 03:58:24 +0000
Message-ID: <CYYPR11MB8429A756856F627D6271D1A4BD8C2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
 <20240702134448.132374-14-karol.kolacinski@intel.com>
In-Reply-To: <20240702134448.132374-14-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SJ0PR11MB6792:EE_
x-ms-office365-filtering-correlation-id: 68df1b5c-b093-4d3b-44b6-08dcc0032ce5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/szyky3tZw4oO+5HZSOTg7S9wx1pRwa+eTbQ/R4WEax4+Y7kdc6utm280K5k?=
 =?us-ascii?Q?zaOYs35qjjLl/9mwlF84qHCIZqrwZJAAmFZdRiCMkBSVgFVdVS9nhZv3tMki?=
 =?us-ascii?Q?rk/G3kv3p08aykDRnOIozLhUQms4qtxhGZuPRM+H6TzPGBXkiac50uNAHepE?=
 =?us-ascii?Q?uXrj7dw2rUnknillxcLxs744W6uOqHs3HrzMLvrdV8+sze+cwX9zJ8nCh6bR?=
 =?us-ascii?Q?8khx8Vm1m/GGzRrMi/9hBoLYBgVHfb6/F542b8uqRV8vjZO2Dq1mXWxXW0Pb?=
 =?us-ascii?Q?x5ELTXgE4qfS7gujU5un1SX4Gr+tOhNzIlgaJEN+hlmHPhi4OPrJb118pM6K?=
 =?us-ascii?Q?3D9T2vgWG+agrNnXmdPwSPmmr7yHyoMal6r/Nq7aJn/OKdodC/8AWrDNYI6N?=
 =?us-ascii?Q?bJtY5OhaCk2Z7KfAX6BUygHVPqmVD1NfuRVnotmU5Aldzp8SFzm5mY/yaHW7?=
 =?us-ascii?Q?7tuCTXaih/zQrSaGI7nrmnusS1EPrFCoF2Ncphyv4CFpiU9FD8Yfe/X7sscj?=
 =?us-ascii?Q?en/7x+7/a6pYX6Nw44BG3GJVRGS6vkMLXgRGdMxsIAxjrKEosaGgrEjQk5ky?=
 =?us-ascii?Q?yhGpgcb8nvuhQBhI72YMGQ2/DyD0d3rOilYXXwErIi5Zef5F+LT884iUXvFg?=
 =?us-ascii?Q?g9LEZRX9N+RmeHyioL6NdK9mIF98kG1BxK7c9PpoMZfn8QeLdRFXAtTSsk7T?=
 =?us-ascii?Q?5w/96/WdRHNcWktMcM/TZBe+Ce/TRy/KZfcDsbL6kEX9L4YghIeWUtNeq4aj?=
 =?us-ascii?Q?qxSzt7eekl6+nPUZOgn1y3jFwjtXB8eqp50uB6bVjoMMV1lp6iifs8XAntwy?=
 =?us-ascii?Q?nAJUPqLpcxdPNY5htVJ+SV3rcVnxWVp4lsuXIXbEZe+rIh02wMDkbjgcDOoQ?=
 =?us-ascii?Q?1yihebBBIS3UQ/bXmgt52LLhP2nXATiV/S1SmWEkxnKwpM6xqgskOq6TzziK?=
 =?us-ascii?Q?SYUAMElhKMnX0zFR8nEOhC+Bct719Jqtu4u8KwndXg9FuWzSEZpZJDvrGkBP?=
 =?us-ascii?Q?prjsxKjVtIwCg/EOUVWt4s43M5KAxGOEL/tSTQyxKY0pJCO1RBb+iFYMN3xw?=
 =?us-ascii?Q?hK0JC8MzflUWb1/POBu0UfLqjbdO9EHsTLsMFDYWjyLEOWPbcwaxoVcUa5Ki?=
 =?us-ascii?Q?hBAtUpvRgAtuZEFzjgFCrLr5eIqks3QOsS4qgGZNS7PqE0B5D8dZ3EjhOoFl?=
 =?us-ascii?Q?G1D3htApyjXNw27J9vXwa16FduLmJ4JSf8ldMIyft5jsmHnIr10XUr+271ty?=
 =?us-ascii?Q?tXhNicTCnwCcBTetCJd4EZDMiqS3kKqoXnZkmqgUorkEefQdEwu8cBy9i3it?=
 =?us-ascii?Q?IQ9qM3buScPTHiGt4bftQ0n5+8b2BPQMDOiUmi9gsiuupMTwKkvRqJkU418f?=
 =?us-ascii?Q?+Uqw+RnJ+KhTa/75VQgUVyHiF9TG1ENCIu7hXtXErkkFhZYjXw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zmRHUfoomnSmUdutBOVDMMC9QlIZ7vVkgwkn/Fbd6nMJcHpbBWBL3RsXDCaj?=
 =?us-ascii?Q?ihX1XytnZ85GVJg65dg0GaYk+kwaoBtPvZAlREUjxZz58ISuuJpYHFeByZHr?=
 =?us-ascii?Q?EmaVIbO+0fkA0SN/HTO3ZU2BW1mVKCc/IqFyf7orHEr9J7LKUq027+5L1Jpu?=
 =?us-ascii?Q?Wy8eB0pyAOIfsg4rgZ1JHlT2x7Z5SRAuMe+dxyPlvjchCQuk475TaFWwxH37?=
 =?us-ascii?Q?e3DxYsMsp1Akglqs2OmoUlp9h9496KMjG6QZKRMc/YfsJjHGKILWBdKbfe+Q?=
 =?us-ascii?Q?lhofEbQW2q/jbRSTlMHH6wvLbjqyLVEQJY0zqxy6/zGlHoBQdvAIV6T7988B?=
 =?us-ascii?Q?cXCOx/Aa+AhIKRpQhASt6AIh8BtVmzKdAU5D0cxaRgnoRuyO46Svfgz0Eij7?=
 =?us-ascii?Q?f7rbHovAgioferNHPmV3KgoZXjO06JJbJJKzuQh9joZEMJjCOSlQTGKjxXf7?=
 =?us-ascii?Q?Cp70qACdZwhTO60bLwlZYncv1d6T4FxMWi+0C2pAbHNve2WZgjR1OsrkhsAi?=
 =?us-ascii?Q?4YW74tmAhFUIynHALJQkWDr7UWGyu1BlMKO4jexir1gFL2ZEmyqBqe7hzHra?=
 =?us-ascii?Q?Jz7yvUVzNsfOchyYovvrsXr7VZ41fladL5iS7KA09Ie+DdpNvl9BPEhhBd39?=
 =?us-ascii?Q?ug3FOBlstAoGu9wzoROUT7XsWKdvGts7z7EameBbZ0T8KfvM2S1007iApFhf?=
 =?us-ascii?Q?KSstegAoz+hHPkAlWe13LopToOHhY6ii8aIgJrsr13BmlEvXz90mEt7wkXrJ?=
 =?us-ascii?Q?T4sPyRcM49KiF2h5VLoGXF088BnYgJTZxMe1eTG2Tn2UuOMXWPhI9iD3XY9T?=
 =?us-ascii?Q?8jLfHwSUvpf9kAvzCtrAPufVN6Pu+R6R3cUVk8B7aE+Z4jogb8xhWckAZg6M?=
 =?us-ascii?Q?8PWsyE2ZaaEHy3nXuwdvCSCe3jJNi4S9GBbI5ANV4uUoA9GGEgFO9qw1L6vb?=
 =?us-ascii?Q?xlNp/3UgfN9ww6M71g8l15/1u2kkOcL4ky9gCitaugAYXWJG8zpU3uYIWBNO?=
 =?us-ascii?Q?hpn8Yd0rEH0kr0kT5UTj0JFjeDPVWX3GiBdE4Np+zuZJNkMQZ/a8PHy33wRR?=
 =?us-ascii?Q?UeQcT8leqqzZYLfvzYjoMDYpk/bkrnPAF167p1iPmCYgNe0L060jYhZ+Pyf8?=
 =?us-ascii?Q?mb2Q3yBKs32eY16oDX0eLhZdkZx2CdW2j0WB1b06A9NBsRG2pDgrBzsNAg+y?=
 =?us-ascii?Q?fwCwDjxpIh8tV7BqXE0YfPKVshZ6pPRJhjHBit0vgiHtSqa8DL7yHMAd2JXJ?=
 =?us-ascii?Q?LKCeCo5cObUHREE39CoTZhiQbcOEY3aK/KZf+VTISVTSlWoKP1NRcPrMAO8K?=
 =?us-ascii?Q?vOlFshuIwTnE8KX1balrrYEe+DLw6zJxOjFodikh/4B01Tw1sqpvrnAbfCvR?=
 =?us-ascii?Q?aooB6bkEzpcMWkZyqk/qJC6MQkWJou4GHdEoBEqQP0RdvJJqGKXVa+AxY6H3?=
 =?us-ascii?Q?vaQjDxkMBZIi2qqHZqH5zymGW7Bd2CbVjt7SjAIZ9wqH167pU03HD/LB5TkH?=
 =?us-ascii?Q?9JMMLMcUAVRvvgh4lY12lAWdZhhELfVryL9JSlvX+ex060TvpNvRzQ00S94i?=
 =?us-ascii?Q?qnFnygGzVGaZeBxHY/FQauFHA2JFajnMuatKY+u2l0u/TEsW+vqTF6q053rF?=
 =?us-ascii?Q?sg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 68df1b5c-b093-4d3b-44b6-08dcc0032ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 03:58:24.9834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hH47aIdKwenETHECjfEz963b2drdo8HEAlOoYZKTC2sfVJ378p0lutCDsFyrwbqGgQXe16rM/z/Wh+cp9n6N2H2C6lB0rt26qdwlJ32dlA0vNtMJhvVkSqsxqPUB9+O5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6792
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Tuesday, July 2, 2024 7:12 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kolacinski, Karol <karol.kolacinski@intel.com=
>; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Nguyen, Anthony =
L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@int=
el.com>
> Subject: [Intel-wired-lan] [PATCH v2 iwl-next 5/7] ice: Disable shared pi=
n on E810 on setfunc
>
> When setting a new supported function for a pin on E810, disable other en=
abled pin that shares the same GPIO.
>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V1 -> V2: Fixed incorrect call to ice_ptp_set_sma_cfg_e810t()
>
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 65 ++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


