Return-Path: <netdev+bounces-258585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPD/G/DrjmkCGAEAu9opvQ
	(envelope-from <netdev+bounces-258585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 10:16:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C03F51345A3
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 10:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9DAA3018BE6
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 09:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC734BA3A;
	Fri, 13 Feb 2026 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1rhWefh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998AE34A78F
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770974153; cv=fail; b=Fu8V4ijcFrsTmH5DVQZGGuvhv9782Wjp5hA+jV1JLpnzdIqXrvzyhh7ERnvRsx/143z9zbjTcir99epxn3SjpJu0GuE4APCC1lpGCpnBJBJ7NYfbrrX8Bs3rOpUAlEUtXuynVvJUWKRZWY2YriAgK0W9ReHfU4p8ODxbv9DKoME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770974153; c=relaxed/simple;
	bh=I7uD/LoS4MKU+Q1XAyiB6Yf2qmpUGJZj75RBw70zivY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uIy7pZ/x52+Zb8lGV/5ydpUa3XiPNaCyq/auJqof16cVovxB/Oh1pEjKO8pr0Ovvl5mY+OgJLZfFx+qd12m8srvOxGFwnhqgaRRSDcrzJtSlTeOWBfv9dFArm0/XSqcaGyLDa0RcxsjVMcZDYMUhFVb1tYwRga3WO8fkYmTmmFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1rhWefh; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770974151; x=1802510151;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I7uD/LoS4MKU+Q1XAyiB6Yf2qmpUGJZj75RBw70zivY=;
  b=P1rhWefh2i59sHEoi02sk2HdTQM2fcvictuV2qaDaZZmO9Bn24Z/tKnm
   Xep+oJzG3zXky/3PNyClSHSAwN2E6dtKGc7X5ME6ukbdY6crU+IDqM4Ao
   Itzs/a86aq9lkI+Hi9PJpx/gMRRGQdk909nOqphaUuxvK6pAxFnFSQBtr
   lXPUJ2ZtKh/EAedku+nAtGS2s9cCfiEoT08znnVgrt6a1s2c2DBVcu1px
   2ChvtqcbbwXTzSsxjFEgKw8hh29GuQ6mUcLppFAfve1caTz2GddWnbae+
   t8tfPdjPGN7Y79AbVKPgizgYq2GlqHI6yQinLTnwlA0oYQY35ak+R/p5P
   w==;
X-CSE-ConnectionGUID: 8nkdn0BHRimEaa2W136Qng==
X-CSE-MsgGUID: RVDgKNa9RtGluSJQU4ssdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75998220"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="75998220"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 01:15:51 -0800
X-CSE-ConnectionGUID: LpFWc8whRy2vdchqVgoNlg==
X-CSE-MsgGUID: QMDFzOV6RL6CB19Q0hsEOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="217344477"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 01:15:50 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 01:15:50 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 01:15:49 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 01:15:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yP1Y4QvcXRo6NBT+h933vucfRfSFD9srvJzK/a6ijq5i/0FGY90yc5UBvpbGUrWembL4cPxj9sPGaivwvKV/ybyNr5E0O2Qs/zqi1+U35oZUJflXRlLL1N3ECbx/KuG+/oPLrK4Zs5fRiAxM5dTCWbr8jrKy8nj8eEne3cq4JXZEsogiC7Su5TaZjIXnhhX9mFK8LsXBisV/gdV7Zb6domlR0Yidhqh0YLHqKr4LDt5r/QAJr+LFxvrKJVJAaOPJEGUYYbkkZk6nY2UzDfAjSwxGIaE89BwxyRPWM3JGU8lHNnyBUBygVmBmqdXCnR8uFVyDc8S8+OMXqHn+S+5f3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G17rbjfvtTLVWu6YJ1u+hb0czvsWQJZSJfsuEaEkCTM=;
 b=grJ4C/tF1vB7UmiIrQ7DTFxygG8WAmASw6fcd0vH7qu/wfjoqTRkNBiuVWwj4EXgnG9zKfHgIf/w4V2edEEh/Wp5BI0iNk0z/Lr/STHu8o6gtMU9KaMPsdcS3+8e2Tk+JOhf89gshxSVIctmkpLSO3S0VUkJiQeOJ5/HGUg/ptZepg1BGNh5R+yhFmeUacNV+a7wLE4SIKnpPzIizovgHGOsOXJnlH6hfQffNdvVE8aiwNHchjW7p4ofQVl9Y7mg4O0CIi74pD04QHJjiccg1ggf20aqW1dVlJZB81E07iu6oFr8IIDt09jdCaCKrtiwMXCUU6ISeNrO4pfnWIMO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6554.namprd11.prod.outlook.com (2603:10b6:510:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 09:15:47 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 09:15:47 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Nikolay Aleksandrov <nikolay@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: David Ahern <dsahern@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Greenwalt, Paul" <paul.greenwalt@intel.com>, "Daniel
 Zahka" <daniel.zahka@gmail.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Ertman, David M"
	<david.m.ertman@intel.com>, Mustafa Ismail <mustafa.ismail@intel.com>, Shiraz
 Saleem <shiraz.saleem@intel.com>, "Nikolova, Tatyana E"
	<tatyana.e.nikolova@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH net] drivers: net: ice: fix devlink parameters get without
 irdma
Thread-Topic: [PATCH net] drivers: net: ice: fix devlink parameters get
 without irdma
Thread-Index: AQHcnMXzhOkC45D1d02YA91FK03XHrWAWQOA
Date: Fri, 13 Feb 2026 09:15:47 +0000
Message-ID: <IA3PR11MB8986CB20CA811DF771F9405FE561A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260213084841.1406442-1-nikolay@nvidia.com>
In-Reply-To: <20260213084841.1406442-1-nikolay@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6554:EE_
x-ms-office365-filtering-correlation-id: fc93bd14-2de5-4e2d-e84e-08de6ae0794e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?4yJu6KV+ceIRytvKqgjgf6RS81bXodeoKvucxo/XKvJ6Ai+B6kh+WfgNjfVu?=
 =?us-ascii?Q?eF4vmO2W4hxyawG+c2opl3pR2vxGDu6MkZq4mzugdo+57VoYw8dSYwGzDkK4?=
 =?us-ascii?Q?Gm4SgZ6VqjvTuMmN05Qpyo1oJj4cNYeIdPV4RSifhSNtRHrU+OLWJQWembcM?=
 =?us-ascii?Q?Zazpx1Kn10ZqfgBnnpycuJL2tpz+airyVoIQZZdDj+tcY02+vomqdPj0D393?=
 =?us-ascii?Q?KTxPb598vfVX9vJFXfWbYnQoij5ka3A4kRXlOZjjqesOZ19GzXQzjf5J87Me?=
 =?us-ascii?Q?kRes/hJ9p0QZi6Jko7zMOtOIS/v2LVDcR9VH73GSjZ2v35CtW8euKm/E3gKI?=
 =?us-ascii?Q?ID9JAAeq/Ul8/mbZkbIKmkBmTUJFGDMch7edxAF03NUXl+sO1zg67XlgtmxV?=
 =?us-ascii?Q?JDhcYgNGu4eVnh515Eg1irbWvlsOnkaPjtyKAfMDwDb/CbjIAdFP3iwVKd9S?=
 =?us-ascii?Q?kI5lUehUxEEOGqZ+rTsubSIQ3rAjJppT7ryXD5Jfo9wP+82tPECp0Uqu+n7s?=
 =?us-ascii?Q?DdMZXK1n0MMdKfzswu3C8ICF20U1yUl8pI/TujKYmW0g40OK46+cEeW1NI38?=
 =?us-ascii?Q?Zlpbotnfj7nmtgMseo0X/JF0hfVsbwDAMmF8rIekVywT3H3CLeTcU8XyMdQL?=
 =?us-ascii?Q?nv1I9muCdgX+kfFdwIq2XleJS4dYjDJ4TKHzmqsyHCLP4uvQobYNao5UVniW?=
 =?us-ascii?Q?uHH2YFPELqiuo59McsU1bViwaYVwWz+aramzpL5+sX9V2BLJ9HnuklYblxtm?=
 =?us-ascii?Q?2ZM70lIB26wdZWr5D9xfVc2RwLOGZtmA4tn/VeRAa7OvPpqUjD/RVh1Jste9?=
 =?us-ascii?Q?wSJWKo8hT7zJ8lim4Xfx73SsYhLnRbUbweftKyWr5zJhp3vyewsH8tHtPzuo?=
 =?us-ascii?Q?6lSgGDhe4jArF3X1t4SgI9YPXyeR4dHHkh3gYeeqkdBRN4oki6cBLTlDYaiI?=
 =?us-ascii?Q?p3cfqsq73wBhtnbyxV7oqxuR+JEgIFUV1TIT77bteT+x0oZqD2EXp3JJbIW+?=
 =?us-ascii?Q?DPnTMVlnJWUAD84b5NRQPO8vsWXiRvw3AyUj7gv+MxyIubxffpxuojorK//Z?=
 =?us-ascii?Q?6Z/Y4Nd62b72o/mmFn6jTbhOLcqqz2xJO849RBZbC7n9CbbaLYPMkaPwur+g?=
 =?us-ascii?Q?z5UqusER+TCp80rcTv41Zy3JtnCN77tn9OzPTDH9fQ4LHqPJyMGLRKSNlZ4L?=
 =?us-ascii?Q?6DUll0JfCR6wLk+g9qmAsbP/Gzz0X2RjprDwZ4ZjCVIWx+qzRu8NoTJwQAiQ?=
 =?us-ascii?Q?6exo+V7fGyHl880rDJVm9cxjbvxWw+lAUdBDkwh/5KFeNfEX8p7dmqSjuBm3?=
 =?us-ascii?Q?L/Yew8TDD8SOQUSQYY96azweka9r2PkqnkX/KsePVKeLpT0CHkkBItRzuxCI?=
 =?us-ascii?Q?DqYxx3wejuaEjzvwbzzrbs1X4n86M9LZ8F4g2MdIBmjIINj+4rrk/PmAex1D?=
 =?us-ascii?Q?Nr3UXbLBDIcZ0B/Vuwh3pHwgb2NdA570Ox8kDY3kbnqBztIZcLc5i9XN7Nlq?=
 =?us-ascii?Q?LHHKYaVBu33pMZs0xdcAUjxEKrPWHwSp6/6ISwL0SNmT8lSnUBrhGu63J7wT?=
 =?us-ascii?Q?Z4UJblUU2QaQn7F6fDn3epxv/7QZ5ToOeIghFBM6cM5oCO2iZAAl7vzwTEsU?=
 =?us-ascii?Q?QEqL2lrn5D25WqF7FxD8jPY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZE1QE65MbYdxhgLyNIgItu7E7Co12MZcdCKHvf38195gGqN5TlkUySX0h7Ij?=
 =?us-ascii?Q?4qCQYlBpxDn4j47zsL15UtfIAoeyLQei0pbvTRKucm/C4aX12ypvvm6Lunc0?=
 =?us-ascii?Q?QT0ZcbEs0xOfms/okb9FNXHBIpfKVmkWWBSwXQwlnuDwoiIK9f2/ynso1pAw?=
 =?us-ascii?Q?GsWixCyLiuAurXfEW3iPcb4Ra46x2dazOu6LlKhf0AZot4QI0Fheolzu4pyu?=
 =?us-ascii?Q?A03vKLDc0T1G0Tb1ejJIudLTzlq9h9QhP+rd2BkLjfzEo1vIeCXf6PwBVnjV?=
 =?us-ascii?Q?MFe0lxWV2ytiubvCQUhm/tZGxUv7YuBv/k5vjEgTZ/KcBlz7WWad4PmJ7iDr?=
 =?us-ascii?Q?YUzILJWJBrJNT+n4MOfW0xfwlbEW5OGBBBByv4f9ITdwP9FmvnLAAoacV8Ap?=
 =?us-ascii?Q?oDnNRzi2AapbX8vSsU8v5H8g0NDlNF3I19oL3clxdEaQ2E5eRnlzZApP7cZs?=
 =?us-ascii?Q?unn0nVr9ubPkjUaJYhosAZvjsFd7Y5+ha4V9nmPH2bhiozN+jlNaG5n9c/14?=
 =?us-ascii?Q?sBnNLU7+KdMWPfiC1iytXei4iQzu1X+9VGtEAd6uf9Ow/KWAQAQW6tiTU96O?=
 =?us-ascii?Q?kU6sasxzc8X1oY8M/QC2DY5QnN/jKqIbPp99g3fxrYDfx9Z0Xc1mWi5Y/sWu?=
 =?us-ascii?Q?6y3Z0bFnnmYCbxqHSx6ow1pggLgxBg0sKZjhvs0nseHm58kvdZ7zpoZQMXph?=
 =?us-ascii?Q?qsYhRfLT2lCx797uw3UKPTY8YKJ3ZDqKVx/6ayBOuAQ7Pi/lY7jsiFiK+omC?=
 =?us-ascii?Q?E47U+9gaomz44gmoz/yASNxX5IgLasV6S/K7iJtbar1Z67beHR8ZbOrDpbL7?=
 =?us-ascii?Q?sDVTfv38qLDfcMhOu/mNuLa0s+AacIDkt60Lnnce8oTG3rVGwWkzQOk2NQsY?=
 =?us-ascii?Q?ncsCBfg+6nf6RuARfE2SLQwnmImiRYo2ueMk+1jlH8xu8yu0xBUknWXM6Fle?=
 =?us-ascii?Q?ouoUH7fO4qKoDeIoQA/x7dzZoJJHcvg9lC+pJmuoZNnMjDTC0M5lRxfVt6cn?=
 =?us-ascii?Q?NPcMtuV/qPh/iUkSGoDIKQ9MY8zVZ030G0IYIeWCiDEol6jMbv57VMfZVoh/?=
 =?us-ascii?Q?imS2NZoShgvZo9Ul8D3gTNVwBoWRyntV8olMhbGz2MFTasGChvwFckSQSbmc?=
 =?us-ascii?Q?uZ+ErOkxqilBmV6BBKn6T1RFuZU/rqwNrgu1SR2s6DoYzhWpLApeQWqIOIiS?=
 =?us-ascii?Q?GpR4x3JfXKOQ+oWBbS0uLhARAvf+OvMNKeESUtSJz9c1YjQvABEX2zl/AQNA?=
 =?us-ascii?Q?sFg1sVxWXezLiNjXNu2dGueqN8uu5P0hezN4PyyTleF5ibcIBcSu3sBOQ4dx?=
 =?us-ascii?Q?7E+eraApjBEU2rbYTh3oI2cZW7huaBW2OPwQ81krRlJuJL1felXCluZij+Ph?=
 =?us-ascii?Q?G//PY3r8d0OlGhIBeOYrM7LQztEW7qZDRu0RCs28t/ui/erCUmsV/cP3lDQt?=
 =?us-ascii?Q?gI3bZO9A70jvXQU34BN7CX2VP3IUNQmhSumEGAcoxB7jYWxDks9zen7J5qr6?=
 =?us-ascii?Q?m7sztJ8U589Nn0373rl7H9+SdiHF+yt8dyVU08O0NrPtCZlKMih7t2kmvhjw?=
 =?us-ascii?Q?DZNItLOyBU/ncSOGZ7dk/Vovw3t5IS86BSvK5KALWJ9W8NSHhZojWLFHuFdb?=
 =?us-ascii?Q?qSdFjAX6VRfx/jLRPQyJyf/o+pdtP/8I4wUXW6pdEaei/fMzuqR0/cCC9h4o?=
 =?us-ascii?Q?u/77p1OUWsFxoHwzSclfYGw23v0miGemmFoBI+5RfKcR9bMlcUtCjom29pKx?=
 =?us-ascii?Q?2xPb8wEJ3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc93bd14-2de5-4e2d-e84e-08de6ae0794e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 09:15:47.2715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mn2pI1vmdzHIz5ArW23Msbjl2MoSv/wmz5kIL+jrRDoxoY4+wl7vw6B6PVpPrSdL4cHMs/LDikiopscpEY+ZpK3PKtfVXSDpu+wOJh45PoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6554
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-258585-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,linux.intel.com,lists.osuosl.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C03F51345A3
X-Rspamd-Action: no action



> -----Original Message-----
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> Sent: Friday, February 13, 2026 9:49 AM
> To: netdev@vger.kernel.org
> Cc: David Ahern <dsahern@kernel.org>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> davem@davemloft.net; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Greenwalt, Paul
> <paul.greenwalt@intel.com>; Daniel Zahka <daniel.zahka@gmail.com>;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Ertman, David
> M <david.m.ertman@intel.com>; Mustafa Ismail
> <mustafa.ismail@intel.com>; Shiraz Saleem <shiraz.saleem@intel.com>;
> Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>; intel-wired-
> lan@lists.osuosl.org; Nikolay Aleksandrov <nikolay@nvidia.com>
> Subject: [PATCH net] drivers: net: ice: fix devlink parameters get
> without irdma
>=20
> If CONFIG_IRDMA isn't enabled but there are ice NICs in the system,
> the driver will prevent full devlink dev param show dump because its
> rdma get callbacks return ENODEV and stop the dump. For example:
>  $ devlink dev param show
>  pci/0000:82:00.0:
>    name msix_vec_per_pf_max type generic
>      values:
>        cmode driverinit value 2
>    name msix_vec_per_pf_min type generic
>      values:
>        cmode driverinit value 2
>  kernel answers: No such device
>=20
> Returning EOPNOTSUPP allows the dump to continue so we can see all
> devices'
> devlink parameters.
>=20
> Fixes: c24a65b6a27c ("iidc/ice/irdma: Update IDC to support multiple
> consumers")
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> ---
>  drivers/net/ethernet/intel/ice/devlink/devlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 2ef39cc70c21..7de749d3f047 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -1360,7 +1360,7 @@ ice_devlink_enable_roce_get(struct devlink
> *devlink, u32 id,
>=20
>  	cdev =3D pf->cdev_info;
>  	if (!cdev)
> -		return -ENODEV;
> +		return -EOPNOTSUPP;
>=20
>  	ctx->val.vbool =3D !!(cdev->rdma_protocol &
> IIDC_RDMA_PROTOCOL_ROCEV2);
>=20
> @@ -1427,7 +1427,7 @@ ice_devlink_enable_iw_get(struct devlink
> *devlink, u32 id,
>=20
>  	cdev =3D pf->cdev_info;
>  	if (!cdev)
> -		return -ENODEV;
> +		return -EOPNOTSUPP;
>=20
>  	ctx->val.vbool =3D !!(cdev->rdma_protocol &
> IIDC_RDMA_PROTOCOL_IWARP);
>=20
> --
> 2.47.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

