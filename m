Return-Path: <netdev+bounces-199669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9711AE15CE
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A00E19E49A4
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 08:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698EF235BF0;
	Fri, 20 Jun 2025 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EmsKCS14"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B822356D8;
	Fri, 20 Jun 2025 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750407826; cv=fail; b=ezLl2VbjCtE8tvAxcmQzcvDdJH/773U8+ROaPep1hkFFfTlyWtMpA7fESc6sHzZx7w5/wNb/My/tob17COqaFvP+YljA3zfqv75GwSzP8LZ/E4w37rKxGCrHW2bt/1lGEUUABI6d8dY30javA9dNa7qOG5bdxWTVGmdweO0RY84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750407826; c=relaxed/simple;
	bh=udwhuIxHt3vGqsAPNlQWkUG6rIe4NdVPoqkNtapSPYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bNqTbIVMaYmEtGPRW21iCdjBnbQbPt6SqmVNG+xv0kJ/hzJxi0o1EKxqiRaJiuhIz13SL82Nla4+9m8C0btTCTAWr3/O51/qVzPtJonWq6YUhi+T8oTJiK36a4+d5+YxiLtmVZZGHOB3xlnbgVQMi7qzHYOkorNWH8GjpxbScLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EmsKCS14; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750407825; x=1781943825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=udwhuIxHt3vGqsAPNlQWkUG6rIe4NdVPoqkNtapSPYk=;
  b=EmsKCS14VFuK05BjE712v6caOkuVBcawAsAI5PwLAKI5c6pdUbv2HzFh
   wB6Rg8Gt2I4rQxKnaAnBlsKT6bVe688E9Ruz8+M26hvUDaIQNzJB9I4Ol
   +kvcIBkDUtC/eYFomO88hEwQX/ZBx+Lq7+IzeS+h4TJUBUp594ww/6FZ8
   /pqpbO/pVrp8kowOeWwJl1lGh4MbDJUDz//ac6k6zwNQgoM7sRKHPM0di
   hLBVHXcE/SJCfGT0yg8laliTvsY/JaehCMLPd3BFcktsj94Yegczm4IK0
   zMM0SKkhWOEXEij5FY9JpNR/DfRyoMpUEIXDoNJoyI1lL5ZKCFGFlPQ0B
   Q==;
X-CSE-ConnectionGUID: J1eQVcF8QwOWegJjorbdqg==
X-CSE-MsgGUID: IgyWb67lROKoj4clEkIMEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52590603"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="52590603"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 01:23:10 -0700
X-CSE-ConnectionGUID: SEM+7MIZS/il+mLVU81F+g==
X-CSE-MsgGUID: ItPjncG2SoqQDMEMspnkCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="181724221"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 01:23:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 01:23:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 01:23:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.43)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 01:23:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJgztf53plNU0sSTCmMLX/4Bd6qltVAICaOMNISassR8jdH3d0hh7boEWkiI8478Ym5Z6kovVkhlVuNNCrqqIWFfKr7GmQQradm+CryQxA3afSnqk/X0C9MVxOPjbplP9NJbCPHS/YfY4Ewh+RTqppwen7ruqgEpmUxvNi1Hw7MHoeCw/M2MHkfjdTydyDx5K1KSNrdLKN85myHP6h3JehlL4/WoU2R8gN8pgTTmrOw6NNZCC7otkeXQiJEEZnIXKwjjvwmNNUYs1kW858VWpK0TzdLTQLm41YbKSYAA1N0njekj2hHvdAm28oUjUX8sDJzroxqReSYr/KacOwS0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zT9sIme88RSf3NAUGb82KCgGBjNOwuwA4FdObb9vk/Y=;
 b=AmKu4BAASKoS9XCNPma5jq9bEjDHFycYRvq6zgWb5pRR5RV52ug2TvIHostDy/VtK0BfN+IViQd/fEZ4VtU4mNFKZicx74Bl+savssepgpWVxofEKLGbDNirBcN8rNAGO/aRXQNPBNpqupzcDD6THp4J+i6nv7whXQiFrcb96UQMksAVJ8sXEXwbb8FrYFgew2comIsHH0dUPWX+a80ah0C3Ytx7LKSmFINtSIwdNqzaSM7RobdeExI7wS/7uwAIelXCIe7bH8xlThpp4SfRSeCrkzRiZnLBsP2tsBUB6qTDY4z0T2CbTofUZiaYi8cNU3TyCKyFFmO+d/WqYHuquA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by CY5PR11MB6091.namprd11.prod.outlook.com (2603:10b6:930:2d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 08:23:05 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7%5]) with mapi id 15.20.8857.016; Fri, 20 Jun 2025
 08:23:05 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>, Jonathan Corbet
	<corbet@lwn.net>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Shinas Rasheed <srasheed@marvell.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Brett Creeley <brett.creeley@amd.com>, "Blanco Alcaine, Hector"
	<hector.blanco.alcaine@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
	Sasha Neftin <sasha.neftin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "Marcin Szycik"
	<marcin.szycik@linux.intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-next,v2 1/1] igc: Add wildcard rule support to ethtool
 NFC using Default Queue
Thread-Topic: [PATCH iwl-next,v2 1/1] igc: Add wildcard rule support to
 ethtool NFC using Default Queue
Thread-Index: AQHb4TAVcBc1dnZR302Va4jTpPeIkrQLrEUAgAAD/wA=
Date: Fri, 20 Jun 2025 08:23:05 +0000
Message-ID: <IA3PR11MB9254669DB8DEF4132693B0D9D87CA@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250619153738.2788568-1-yoong.siang.song@intel.com>
 <8734bux3dl.fsf@jax.kurt.home>
In-Reply-To: <8734bux3dl.fsf@jax.kurt.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|CY5PR11MB6091:EE_
x-ms-office365-filtering-correlation-id: d07aa891-eaed-485f-6b8d-08ddafd3ae47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?Y1/kc7Z/WvLogQgUYobbIhc+NEWsq/zK0S4XmYGQVT00jFxPr6VZfR7okyxy?=
 =?us-ascii?Q?O+1oXBF3+J7ty5KYdEjC1dUuiXtdM1G5fTl67h/7p9O8rwHPCDhZje/YSa2m?=
 =?us-ascii?Q?6lv65fjQHLDbH1TTNtPjZENs+e3eqRkgWEszsaHl8mtFZN7HdWkvBa2228Xv?=
 =?us-ascii?Q?Y5/t2HveigxSPqRKgoZmF6agsbJ6J5tBVUW8r/JWzH6rJXwsLbHmqPbHWY6N?=
 =?us-ascii?Q?xtgHU1cZ/lQ4NHattKV/Q/reB+HnCL5/tVrRZJbkww+cXbH5/zOqOACIm8+6?=
 =?us-ascii?Q?nLLkHZ29CjJakptvW+TgjXWoz7GvtQTw6M40OQqdm09NIrtX9EN4ph5e1KqX?=
 =?us-ascii?Q?PmmeHzq/lVmjzRTl1zshG5vW4XxO3tfE+RlJM2HdYDxUOhFflrTm7FGlgfXV?=
 =?us-ascii?Q?EoCy46x+23Xx/nVLzGE6TFdJFdplN25WBVjjyasd48v5B75U19kX5OZ3uySj?=
 =?us-ascii?Q?nD/nyNc6xugONUWjqzf3402LqXKq5b/ZpIqv0IqKnbly8EdC5xKzHRRDHm6l?=
 =?us-ascii?Q?yLPxjEQAjgEETNKcWJMyn3cvEit9lk2Csy7R+BEE+/YGEnevPTEqjZSmrPA+?=
 =?us-ascii?Q?DX0uYbyOBAPk66Elj7dkBp4kzLc52dlzOTYXP7nbdntZC9Td/Q0JRidxeQTc?=
 =?us-ascii?Q?vh1ANf6E8fjJYDa7m4h6aB5EsOXDgXi8AcMl7W6q1BFh2ykgAv+bzyy9kt98?=
 =?us-ascii?Q?fnHUkJQNzJJce2tpdnsoGmustKp1rvQAwH45hjh5xYL+NGVssfUbpLem+5IJ?=
 =?us-ascii?Q?CWRXHV2y5FcF35L6YsmHDy3JlNun53wPrB/LWyZkVFHsI47VTa7CzVzepgwb?=
 =?us-ascii?Q?q9nU4nA9tI6/BK6tqr04PJZywPjNXmy/T64eycWwVlseN9sEvkb1clFAsclz?=
 =?us-ascii?Q?LWXKl0uBI/cHitG/yHhf3Ogc8mKXqz57NEZyjmUcSu7jAKiFD3MLD4WrPDvB?=
 =?us-ascii?Q?mbm7qsr1jNBzFmJq8n/j4BexH3Dey3MFUkjSPwsrcPynwNcGlvUZDEEB1BcQ?=
 =?us-ascii?Q?Sj2rCWgJpfAm/egtoCj56DJZQJicQp2Y2iIGUXuH2xutBEz8e1YoN3o+uKc2?=
 =?us-ascii?Q?kcHUoZ+Qil4CJ34BT1nVq/2KrMuPmX1Yq8qN+1P9RjB6OUrH/bboswVwDXrf?=
 =?us-ascii?Q?GXbXHZE1DaTZwcNlel235tgFIZNB9IsR9c9aTwnu/2PFeY7YBakELm31vR7J?=
 =?us-ascii?Q?2Xo/p5HlyrMIWyGr5dJd4axQAJBKyrNhdVePmDudnItCPeP78kXDuTPlUEuc?=
 =?us-ascii?Q?eA9ktn901a+lzBJHdshjf6pheuccoQjZ54TvOfnw3E6c9Hx+hsqZM1Txv+XB?=
 =?us-ascii?Q?0++xTTeyl/WD5DuFtWPJ9eJoohC5eNZ0ieRMlATde1+4phis+6LAM356fNj1?=
 =?us-ascii?Q?dhkS1hqaMxbUHq8zpnT1jf+//sw6WyIN3cQZcd59NK7ed9X8yRFF5hZuQipW?=
 =?us-ascii?Q?Pc6BCJBK05Hz/qDKkue0xsfC6w94c842QqIKCM6mXtrE+ml99OBxt5ltgB1Z?=
 =?us-ascii?Q?m2xADcYTqfsyE4c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OW9zZCdeNJ6497zOHFP80QTYYn2Ys6TF/buF9yc51pBb73rJcSB15Ld/hGp4?=
 =?us-ascii?Q?L8pURhMitdMW0fouFNAvJgm9uozf4AygW7m/e7VpxvxxOYkzQcbigq34ISWh?=
 =?us-ascii?Q?gAUODD7SYm81l3NT6gNzm1aYVoGTCtmE27VlnQp4cmlkb+F0NFikocgLRRWx?=
 =?us-ascii?Q?WN7B/wZo+4ZLbNrGRp6vptpcd5YCAJ3QVgsFrtCZyNWaiqUeY/X7G0FEkO+Z?=
 =?us-ascii?Q?ngZmX6nA1rEkXZHW5WVXZLC2uR39AdhhtzHLqg4/UOkK5FVHZkt3vBVbCLN/?=
 =?us-ascii?Q?LJU/touq5+58n4xRRSNGv93CbHBzra+QEfdZgbyTZjwqAdoBDAVK4QYHcacy?=
 =?us-ascii?Q?aL9KamNmcpYStU8U75Uumn94K4jKD4K4HC+hQiDypFTYyfRDdVvKfpk+Dv4/?=
 =?us-ascii?Q?nLzGif07AWZ6HsSO8MDn/LFIMVcPbhgfpLioX55rU+gUSowl7/pIpeI5Pjfn?=
 =?us-ascii?Q?AQZMlh+L6jEc1XVVY6l2ABQc/GE0pk8iLwLFe2y8jfDTAeLtVF+BprBtI3ii?=
 =?us-ascii?Q?Smneu89EfBYTyADYpoX3vcmlq0gPApeicL598cvfu49UQTWq51o5oOM/4iGp?=
 =?us-ascii?Q?1yRH+LM5bW8L6pAKt+tBIWn54s+pYzf22R4Jmkjk0AxzewvV674gla+cDSBo?=
 =?us-ascii?Q?q+HtDhcH2+CC43mowlMzhdo8xtPzM+1Cxy5y+pwBIAdnJzWGc9AiMDC12qo2?=
 =?us-ascii?Q?AJy0weQQC9rzidSVXFz8qy/b/XirpmBPWYjB6DQI7GIRNALLe3JDsnMjFU6G?=
 =?us-ascii?Q?XmNNM/6i31DzVoYkj6IiMzf9f+dqjg4fNkl6DAOJMF55CmoxLpJ1yU9Ywkka?=
 =?us-ascii?Q?9IlzLcvngiQmKSszC+70huST9Z14y8PmfTd22Nh0aUWa2qqQ2y/At90qhoND?=
 =?us-ascii?Q?KyXz1f9rMOin9douS4Cz7dTGHv8U6ct6SNnOI+KkAKhNp3BWDB/peTsRm+26?=
 =?us-ascii?Q?EPycDhJuxuwFgiX+QrLGHznDsMpv4P83hhdXZFObqm/C+62LBP6aqtf3o7dk?=
 =?us-ascii?Q?Hmyg8VZ+7sCBddNnn+p9m+C1J0IeFaxpwcLjAvi+AnWdj5RpwSujuuf6KVQ+?=
 =?us-ascii?Q?uL4dBc9RRY1feUAcPhQNT5rdF+O+q+MMtkG4lzRA8581Fj6+MDlXvyUOYJ+/?=
 =?us-ascii?Q?aviDyhTfu8EhIfEycUuXAQMKvKdEgBytk2IVU7NjlxaDynclhUkEKX06JVob?=
 =?us-ascii?Q?qPR0JhKw8xiiRflqFpWVBWkk+TDYMUTjAgLuBCKqEAJAvMX0lEXfG/cckbVc?=
 =?us-ascii?Q?CViKAEOnmuz7Db5/DFmd6SqfhPKVHJUrjphHvWdLXK9d4or7Ugyj9PmSPtNG?=
 =?us-ascii?Q?vcKYa/vT+Hasm0d2o3zf8VW71VRgduabevqnq3XwdjoDc9G4ltqFLMcbIgYI?=
 =?us-ascii?Q?8Mdp8aevCcE+ZrOzE7MbkJsYk7XhcD7zxNJ/y7EjPbVZpCFGp6WocLWR+UdE?=
 =?us-ascii?Q?5Bk53j8R8XTWb3XqzrCj5iiYLueHA/dXZg0zPdppnXVNDPl2OJFNdH7Ki58E?=
 =?us-ascii?Q?6SQfMOjhzJqS6iyrn4YOwDJLkBhYlPyrioPk3OcVcvUUx9vK1ixgXyoU365J?=
 =?us-ascii?Q?tCuu1WNr/pksdGLGoJJUOSBPpHPz+my6XqS7llUYFT7EAONqOoxze/l69n98?=
 =?us-ascii?Q?wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07aa891-eaed-485f-6b8d-08ddafd3ae47
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 08:23:05.2823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/tE7w+j1qaguh31WCD5db2s85IalVpTmrvJvgIyTvot4X1In5KzWWKGsk6OpLHWcBJLjOaSJE4eG9sVbqHJmS5270XR/cIZyNFmDJZ2bMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6091
X-OriginatorOrg: intel.com

On Friday, June 20, 2025 3:46 PM, Kurt Kanzenbach <kurt@linutronix.de> wrot=
e:
>On Thu Jun 19 2025, Song Yoong Siang wrote:
>> Introduce support for a lowest priority wildcard (catch-all) rule in
>> ethtool's Network Flow Classification (NFC) for the igc driver. The
>> wildcard rule directs all unmatched network traffic, including traffic n=
ot
>> captured by Receive Side Scaling (RSS), to a specified queue. This
>> functionality utilizes the Default Queue feature available in I225/I226
>> hardware.
>>
>> The implementation has been validated on Intel ADL-S systems with two
>> back-to-back connected I226 network interfaces.
>>
>> Testing Procedure:
>> 1. On the Device Under Test (DUT), verify the initial statistic:
>>    $ ethtool -S enp1s0 | grep rx_q.*packets
>>         rx_queue_0_packets: 0
>>         rx_queue_1_packets: 0
>>         rx_queue_2_packets: 0
>>         rx_queue_3_packets: 0
>>
>> 2. From the Link Partner, send 10 ARP packets:
>>    $ arping -c 10 -I enp170s0 169.254.1.2
>>
>> 3. On the DUT, verify the packet reception on Queue 0:
>>    $ ethtool -S enp1s0 | grep rx_q.*packets
>>         rx_queue_0_packets: 10
>>         rx_queue_1_packets: 0
>>         rx_queue_2_packets: 0
>>         rx_queue_3_packets: 0
>>
>> 4. On the DUT, add a wildcard rule to route all packets to Queue 3:
>>    $ sudo ethtool -N enp1s0 flow-type ether queue 3
>>
>> 5. From the Link Partner, send another 10 ARP packets:
>>    $ arping -c 10 -I enp170s0 169.254.1.2
>>
>> 6. Now, packets are routed to Queue 3 by the wildcard (Default Queue) ru=
le:
>>    $ ethtool -S enp1s0 | grep rx_q.*packets
>>         rx_queue_0_packets: 10
>>         rx_queue_1_packets: 0
>>         rx_queue_2_packets: 0
>>         rx_queue_3_packets: 10
>>
>> 7. On the DUT, add a EtherType rule to route ARP packet to Queue 1:
>>    $ sudo ethtool -N enp1s0 flow-type ether proto 0x0806 queue 1
>>
>> 8. From the Link Partner, send another 10 ARP packets:
>>    $ arping -c 10 -I enp170s0 169.254.1.2
>>
>> 9. Now, packets are routed to Queue 1 by the EtherType rule because it i=
s
>>    higher priority than the wildcard (Default Queue) rule:
>>    $ ethtool -S enp1s0 | grep rx_q.*packets
>>         rx_queue_0_packets: 10
>>         rx_queue_1_packets: 10
>>         rx_queue_2_packets: 0
>>         rx_queue_3_packets: 10
>>
>> 10. On the DUT, delete all the NFC rules:
>>     $ sudo ethtool -N enp1s0 delete 63
>>     $ sudo ethtool -N enp1s0 delete 64
>>
>> 11. From the Link Partner, send another 10 ARP packets:
>>     $ arping -c 10 -I enp170s0 169.254.1.2
>>
>> 12. Now, packets are routed to Queue 0 because the value of Default Queu=
e
>>     is reset back to 0:
>>     $ ethtool -S enp1s0 | grep rx_q.*packets
>>          rx_queue_0_packets: 20
>>          rx_queue_1_packets: 10
>>          rx_queue_2_packets: 0
>>          rx_queue_3_packets: 10
>>
>> Co-developed-by: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
>> Signed-off-by: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
>> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
>
>Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

Hi Kurt Kanzenbach,

Thank you for reviewing the patch.
Brett Creeley points out a nit to have separate patch to
move following macros from igc.h to igc_defines.h.

#define IGC_MRQC_ENABLE_RSS_MQ         0x00000002
#define IGC_MRQC_RSS_FIELD_IPV4_UDP    0x00400000
#define IGC_MRQC_RSS_FIELD_IPV6_UDP    0x00800000

I plan to split this patch into two, then submit v3 patchset
with your reviewed-by tag on both patches.
Is this sound good to you?

Thanks & Regards
Siang

