Return-Path: <netdev+bounces-259688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALuhGzIqmGlqBwMAu9opvQ
	(envelope-from <netdev+bounces-259688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:32:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CB1166474
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B8C3300915C
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D5031ED8A;
	Fri, 20 Feb 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQdE2gix"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC8322A3E
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579721; cv=fail; b=ZBL0i7OAV8ecQIxDOtid6dUM4FHcrpm/birrVrlwl9BkBdJTGtm00VPj+HNYrYcYI4lv3+i38N0VkfREtVpp6hCKgP21oQSqbaxomq2qf6ealIGXfo90GKeODrX8RiVyWHZMQUkRK8+XUg8nMbNBRcFNBJNJ08JZi6t5lJIEEJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579721; c=relaxed/simple;
	bh=90vl0iDBYh81AMAflQtsvNa0PvW+eUlbDg+6yzjuHYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LvGEjcmZZWSDaY+NmBdoVwaJ9BJ9MU1UcahV8G/OtyqawylO7Uf+CZ8IvyEfSOhvZ1QPepzjczdAOsbP2gOxNhJ4qfJP98lgDaA7k1+ZP332T7zItkKnbLvgEV+46P5At5xd7oSP3LSywkRMOfQQYFQhMHYLWlwZETwkuTmImnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQdE2gix; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771579718; x=1803115718;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=90vl0iDBYh81AMAflQtsvNa0PvW+eUlbDg+6yzjuHYc=;
  b=RQdE2gix6ch/BQJEmR+s11zSs21uBsit4OIJ91x8ltEu1XMdGDXcejkA
   2jdnYaqXqGoNKgoRE7fzP9/MIWEfZ6MHLlGd6+NMx+Fj6v+xqfFDD4+u3
   09y8rkrT8WdPXmM92nqP3ik52YaqDN+jkfUyMqgMsERLtfu7WTIS/p+2V
   afaEkuZpH5aQNif3e5EvMJdOa6EJ0/yYdqJEqTXtNn6YSpamfei/+D6kt
   jUn36sLNM84Hngq9tf6RX2UnmfV+neQl6XqPohbYJAfMXC6VHxWltEVp/
   BJUuzLO3oWDSZ81cCcqaE3NdzIvbNeLjaNeAJrm6xBtzndcd8jorHPs4g
   g==;
X-CSE-ConnectionGUID: /p6z/OpIRj2k3OhbduREfA==
X-CSE-MsgGUID: p/EOarWrQLWkDbXhsWGplw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72373651"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="72373651"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 01:28:38 -0800
X-CSE-ConnectionGUID: A+dRIgzsSr2KoTDO8T6tpw==
X-CSE-MsgGUID: 1/DLYPRhREae3v+hG5ToqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="213383581"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 01:28:38 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 01:28:37 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 01:28:37 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 01:28:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtIFzb6Hzr3DEKV4wZrDdWtAOMPgY1SK/6gERVTIYy1zcUbCKIklezVlT9eMEF2Yo1Oii8rwocTj/WRMJdwUk5KgPM7IIIkU17+h3bTErXhNmiEDUaLFJQ3B7CJrJYbVS+vUi4OV3pHutbBdkEUiveP2wjHLHkQLGEYgQ31XIZ71ZDDe40crDO+U/VhwnHqWaysnwgmYrY3jPBYhlc0qDqkdkIRDIJAs6q2Ifw9s97Rq2ZlZvxmhHOodCz4Z1BMA4JxhjyXwRnLCk8LH8lusJDi+NDawXIA99Z+DeDlwr5kMlyNnbJAafaO9FQw3N4hXjfpDi+65nHz04xkhqWDMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90vl0iDBYh81AMAflQtsvNa0PvW+eUlbDg+6yzjuHYc=;
 b=oV2gdJb3NXI6mTWLG3RzVrtQf0oNPcbn2UAccu3enTSfMPRnR6wnRg0dLqh3xfvlhOajJdxe47xJZtkCueCPkka/QAkXpyb4GOBaE923XP+OsqEHouFB1m/A69RcN78zTFeU3qs8Axi0j/HHlWLg27Ztb27NGxny7L+Sa7CHOtm7undpLhLExtZqGaST01nsc8Sve1d75e3sSVsPZutP+6SAOPn9aMyOpSsHUd89+AqUdvsgWMaEMcFu3A4OPSVUk64XGrIU4ZL+To7PCprlKzPMf5MXKckeL4PlHpJ+FLFageMqOKdz6m2upXNzr/Q0F3HYFwe8TRNJvJHWonYvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 09:28:34 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 09:28:34 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nowlin, Dan"
	<dan.nowlin@intel.com>, "Zhang, Qi Z" <qi.z.zhang@intel.com>, "Jagielski,
 Jedrzej" <jedrzej.jagielski@intel.com>
Subject: RE: [PATCH iwl-next v3 4/5] ice: Extend PTYPE bitmap coverage for GTP
 encapsulated flows
Thread-Topic: [PATCH iwl-next v3 4/5] ice: Extend PTYPE bitmap coverage for
 GTP encapsulated flows
Thread-Index: AQHcokq33CB1HL8Dx0+N8RRb0LYcWbWLUe8w
Date: Fri, 20 Feb 2026 09:28:34 +0000
Message-ID: <IA3PR11MB8986CE81B5463CA23B4E2DC4E568A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260220092409.718632-1-aleksandr.loktionov@intel.com>
 <20260220092409.718632-5-aleksandr.loktionov@intel.com>
In-Reply-To: <20260220092409.718632-5-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL3PR11MB6484:EE_
x-ms-office365-filtering-correlation-id: ac63e717-666a-4d65-195c-08de70626b92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?zXNOOu49Jk53zRpyp91P6aDvZ6vhqv5eSvgQ9IQMdWrxdRGSSEAbB8VKklBx?=
 =?us-ascii?Q?diFPnkJLCbm+J5pP/Q2a/n9LWLmSQrT8nSPWcrGkJQiTWGSiwLO/lOI0cCpg?=
 =?us-ascii?Q?+EbLcsJiANC3hGu7thXZiTvGMm2WOAtFucEW88cqEkczat8gHn/ed4Yj3HZu?=
 =?us-ascii?Q?Pz/Z5K8pz9JD5yX/8J51qWzIxVsTHSmDSZp7YilmA+QhRh/qt25rqt6fo2EN?=
 =?us-ascii?Q?apaTmjSi5oIZLewZIiv/LNYmI9LanWubeKz2+6h7WSjNnyurdJH+LBNNs2th?=
 =?us-ascii?Q?T95WUxaL9q50jWfHGPL+bckzT9uKZyEOdI+rwsZFbA6fZWD5Zanfx1diuT8v?=
 =?us-ascii?Q?A7K+D0POLqyaQXh752Ii2B+TFcrtK7yaxY0IiyQ4MQlOj2XYdrANkRVe+za9?=
 =?us-ascii?Q?kPuBzcbGyDvp0rtrsBC05ZBIUxgLU3wu2Cxgr6oCRRxb/LAFMIkjJp6mY8pS?=
 =?us-ascii?Q?Q4l16zO7zNzwPr10yiCC5oT6DebgZlqv/TJD7C78QBVQgn2p80hvX+6Wm1ji?=
 =?us-ascii?Q?yUHSgH9q9ggVoHtNTgYxRmH8WwTKOhIn+5PT60NeiCQWKmIQBgBF8SQkrF2v?=
 =?us-ascii?Q?Eoz53etU4mB2d5m/Qas/HAP9WKvyZOvi/aRuzYtJu4OGvMQPjt0bMdWbPoPH?=
 =?us-ascii?Q?TNzhr1kt05BDRdnw4ulra0D7owI97TsyvsmeydMXJvlahVbl89ZMtiNuEI75?=
 =?us-ascii?Q?n7fnjLUuqbr27alvsu5WW1D2LC+f75MuQwFHMQmyextVoGP8vW9OHvBWqkQr?=
 =?us-ascii?Q?b5dz6GlGFqxkNXql9pneKUAEY3pPCHQjStDtor1G+7CSHufDfopcx84r8bzs?=
 =?us-ascii?Q?arxrOCFsIu/wmY0wg65+K2xDSvVWfR9ZJoxSNR4lVDJa0cPl2/czrpU6hVwo?=
 =?us-ascii?Q?RBX5mxMQpvxCTlgWIzJPbf//p9Jg5dnCMeBC5JZXy+mUpq5GfCZYn9fY+2TN?=
 =?us-ascii?Q?4dx/5h5G7xKzzlQgKmuzr7Py+B4xYyTDZ7YAMa6NBsBl6DAGHSKAfI35S5nO?=
 =?us-ascii?Q?hPQh5c+LLpQLNv82UE0MU51ZX/D6x9XCfj9cymOU708KqE9unZpITFlFhr6a?=
 =?us-ascii?Q?xCrYv50MkD9luLrzZHU8PSskigyJ4gd3LotIJCiNznP8X5+Mk1HoONeQyQKX?=
 =?us-ascii?Q?4pFtD4a5n/inEcPjqWrRADii4vke/Z3jTIA/quljbtlscQXCNxUmlk4wBDra?=
 =?us-ascii?Q?DRtnTKn4Hpnznt1TL9cSl+QjxbG52vD83FojCcc6CG4e2CLIqNflEOA2HxbU?=
 =?us-ascii?Q?DQJaPuuyu0C8tj1yDHC0bM1RcLJmRoi2CzMQNlAVn9n2Vjmer5F4unjilA12?=
 =?us-ascii?Q?DJE3nBEaT/4ZSjVYpoGO51+byEnR3levVoQTIY7Fmp6vpb04AS6O/PmVHPok?=
 =?us-ascii?Q?gOROcsqrzyV0lxwfR3bOGjKNTFNuoLqh+OBqPZYeVTxrnCUHbkb7d3tScqEv?=
 =?us-ascii?Q?nkBLOCIAWOztF1AHh5xOcoObIRPEEuNlK/AxabBBgtqk9/S93DX7s9kPWowT?=
 =?us-ascii?Q?WIwTIfiSObKDk8iLJ6H7MI1GaMwdPzGu8AuDtH+JEPw2FMeEaKjd2tmICSaO?=
 =?us-ascii?Q?LyET9itsUbcyu8AMMACMUfNbQstkepG3aKNilJZm8Tg7F/HLsfnnEgrMOyMr?=
 =?us-ascii?Q?eBDl9jCQ5nIPmWwZK+R1vBM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hvlvwn98CwAQ6kjJz2FP4LSnfxuZOrjEW5WAqyk3/E1nlPsxcr2BsTjkkYz7?=
 =?us-ascii?Q?gs0KqNrYCXyoW0th33OVGr509aEbkfeFVFj6XBvX1jPmkRNixZOFi1f/yQ4W?=
 =?us-ascii?Q?eUerMZJ+ugD4gfIKVXkvYVLKmsGovaFFIzG+J3X5HgFOOlmYg5Ji2bdzG1eR?=
 =?us-ascii?Q?3lNMOxHpu6yZ0TvTi8pq33+YluB4MM0sbi49kM7ErQyPHDwFCz9BJu266VIr?=
 =?us-ascii?Q?73t4qz2NHTQkaj2hxEoSmcT00IeYR2NhkycHPYIy7bWB5cR0bRkIoLYfL6Ic?=
 =?us-ascii?Q?UN0N+jyq06LtEZiNxG9yc4ACp8cWmDVOh4yirAtCWCZv1oVQLrOY1xkkaYPX?=
 =?us-ascii?Q?lUZU4pFqh2Xfq1DkEXZmCAn+ET++0BRUsen92aHFUw36GZnPNNYxQJEDNAfR?=
 =?us-ascii?Q?1mDNNO0P2U3pgZBgrzpjlQ0nLgX5QTC9WVPAnvvPxKqJxl0Nk5h4K1gwa4sM?=
 =?us-ascii?Q?nifZ3p3GAesdqKd9dqMPOhXlr/9QsIUyKxTtBVbT+bfdBsAH7Fy6EUS1BzWp?=
 =?us-ascii?Q?rYIRYNVZb6yxaEpU2jrDY9O0g2Cccty8y49eA7qw7yakc2IRPCB/GSG/RUBT?=
 =?us-ascii?Q?hcNGX7kqrhDEPMvf/hGeJf9rtN0K8/FlFUEN8dmaa6afsw1igrFuqBiRoeiw?=
 =?us-ascii?Q?ubHNX1Ijy7ZdrvPi2M2hUUeg74w1jXJuRcrEGb1nnPtw6VEFIhvykN3t/969?=
 =?us-ascii?Q?iWk5QTF2gYR2bG7Td6rc+7NGC2Jd6b8EvmtwpsSY597O9oWYtYtwrSMfiEvW?=
 =?us-ascii?Q?PTTPhP5yOOHoFaSHgUAeG4NxKFvyDrOerL/5cufj5zbLEVsA5Uf9mDAnmVf2?=
 =?us-ascii?Q?55EyaXiT1h1XvyHNYih5OgJGhcys5wG4ZHDNQZYOEwWCvCaZLXmV5UBXAZqQ?=
 =?us-ascii?Q?Snp+DVdMbMGpaudIwcb6K3GMSrnMxMcdG69gEuNZ81MwN6wx7H0QGasV0ExB?=
 =?us-ascii?Q?77gtWOHT9/Hwkn8qaMvn7skh3NQO8NKlYfIp73Chg78wJ6NuwHkgu/5ocDOL?=
 =?us-ascii?Q?K7m5MuMjO22WkZ5dvNFIzLsnz0ft7B56YUTUmvdEOYJErKbnLlkjY7Oy4rfY?=
 =?us-ascii?Q?NkpZSfU+i+I4qE274MNDoaK4bwYYpd66Iu4ravMTA4VfGBBt8xaIJw0tY+yo?=
 =?us-ascii?Q?wazx86AQpblyT+46KDzg05l3PjoEtDlgiapv2HSBTHNb9rbU2PvcdkpKbYGK?=
 =?us-ascii?Q?0uLo7KLhb+Dzt9+4N/UHL2JHSzfjMcuCvWl8coYKFjLpwiW9tlwqWVuXb+1A?=
 =?us-ascii?Q?Fz07jOdSAxZ5CqF2mW08ZznFDLqEtu2Bw1Wf3ibBt1wHxIB3COcLTTEGTbKK?=
 =?us-ascii?Q?T5FtyaDGNSIgiQXzE3Cyc6S+aT8oJtKImQWDkGxp+35nQZWq4becxgEN0nMV?=
 =?us-ascii?Q?7oS5r65Ia0b30xz0cGIUUtkpji9m7bBqXUR2Oyca7rhgv7Od8IEzaohN+xhL?=
 =?us-ascii?Q?bdSMG9IDY99mzOi41vtm1f47R3jAm/on19s4Igc3zmVSxDJVGO5ANb9+jFf5?=
 =?us-ascii?Q?/MqygdDIfNDLIA9GqBrsiEVscpDBrw7JqOkAjSeEOnauxOWFE1dGwd38Wq/c?=
 =?us-ascii?Q?JLRomSAXDB0rqUKeWbDxEt9f2EaZfcJuaE/rSf8PFivFQs+VyNUxDSYcEqqR?=
 =?us-ascii?Q?esGG0qBiX4K+YroyLJpxG/xDItqRc9XgoBeVomMpgaEl1vXULxZgpo5Qhu8w?=
 =?us-ascii?Q?tJmxefeO89c5mYvb0gIcKgmaAlSKP2DDBXkESHgV5FCy4hmvF5r5aTnq34CJ?=
 =?us-ascii?Q?Y2s6Tm1Z/g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ac63e717-666a-4d65-195c-08de70626b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 09:28:34.6457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /p2fojKhOngTdswj9JDGLgzRrEQ4kTlEYoE5Ol5jo4b4RL9JVvMGF9sTchyXZRMybstyVEZnYVDYCWHGaMgMxrwaBQFXXlZsYarkJz6qrEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6484
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259688-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB8986.namprd11.prod.outlook.com:mid,osuosl.org:email,intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B7CB1166474
X-Rspamd-Action: no action

Please ignore this email.
I had personal e-mail issue.

> -----Original Message-----
> From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Sent: Friday, February 20, 2026 10:24 AM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Nowlin, Dan
> <dan.nowlin@intel.com>; Zhang, Qi Z <qi.z.zhang@intel.com>; Jagielski,
> Jedrzej <jedrzej.jagielski@intel.com>
> Subject: [PATCH iwl-next v3 4/5] ice: Extend PTYPE bitmap coverage for

...

