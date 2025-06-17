Return-Path: <netdev+bounces-198423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14452ADC1DE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 07:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F711645F6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 05:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FD227EFE9;
	Tue, 17 Jun 2025 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1JDr63B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60662397A4
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 05:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750138788; cv=fail; b=CuogI7X/AG7zqBWq3qWUVAcd23AvqWptS3BZudBtB94N8nI3g27/KioqetKZjAA6jgavz4raP6NZIGxx3qFgh6y1oquCNH1/sOEW/elNzQWnoHmJc2FnGbDwRzKjww/KWnPaMkj0nijSCeTMXmeVXBjKAsNoIRUAkkQSyPzUiCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750138788; c=relaxed/simple;
	bh=ESuG56rcR+tt+s/3bcsY2StzmnO9b95TAL/fh9GUA3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UWSexG7enwEYxKRso45+gUJQ5ALkT96c2mNqv1jYQniJQp3LKJOQLCT1iVl9r77qw/ANfe/n+Awm00EJPBvjHqfLZAtt7SkBJnDlN8/tr0PxFpjOLRQtCFDEfSwgwUORh6G1cMKufEpXMhH5IGgH3XRi6GexhffcryXTAapeDHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1JDr63B; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750138786; x=1781674786;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ESuG56rcR+tt+s/3bcsY2StzmnO9b95TAL/fh9GUA3I=;
  b=h1JDr63BQd/0AiQxDA39P/RniuNHltxMUNE7/QlnN9FHEG69/YlhBc0v
   QXKPjLRj4sNpWVnmeiAhoS5ewNG0lSHezzdWMDyWXAMSS7pERqdxBBixg
   6WVdJzwPBoyjWieiPQSeP2kLK0poowLXhDgwju3pPRwQ468hsGTtILeL6
   VsifInn2l0oJdsZeJlRWL7ETmE1i3zrmn7hI/uOl6ibjqCWLv0khz4XnN
   y7pRF2ENESJ3U050ZO23dnJ3rax8LUO2fjMFUWjt0yl5s/Mk4yCt21IN6
   2pYqGPBjilllmtlPx/IDDGvzg5Bby8NcgLjFmVXBEAGkK+O8yVS0CmQOY
   Q==;
X-CSE-ConnectionGUID: 72vxJtFvQOiQWuD3l3PkZw==
X-CSE-MsgGUID: qd0HvqDiSnmrLFJ0wSn9Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="63714438"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="63714438"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 22:39:44 -0700
X-CSE-ConnectionGUID: MLOVFiMbR4aJsW2/UalQJQ==
X-CSE-MsgGUID: 1chIDVl7RRCgIPQ5DRb6Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="153848472"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 22:39:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 22:39:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 22:39:43 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.66)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 22:39:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5nZqoWmmEuAqM8LVhm1d+9qXl8D5PvZSFliN27Zk5z91NghC6gFXnkf8bfzCCxL8VLejTbn86LjcLcNS2gX1GFLgrsdUyBWrq8axL7cJvo+GiBEAE7/nBzU14c8xX7Epe2+KdrYbo4rhxk+pQgr67vVFnjVsJvETxEQ9N/f58noy3mk0ydyJ8ZzJKVkR8lmf3JVzXu2+fwGKOdyKnRx3xfjiCMv3MZ1wUKtrffzDYD1XwhUoDnPiBDFSuWo2Z8uxlsEfeF7XA+YJyFTanIKqswM7C9lHG0nU22oO7KrkFm1ESByXwImBAHnCTNC+OaCf04XbnpkCw2GxhHhjpAMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NnRg90jkOGNAGcIHgsDG8RdbSbgNHPHj4Tdryfvf9g=;
 b=D+yIAMrclCbOXKGGm27Hm8SwqCxhZgwTa6Wp6yYIKIfe+BbartCcyOoKOHX4e3FYOc9U8m/lKPiyAmSuEZg9SKtsl5Glf/YAYM4JFRIbNgXxIEpAjMOaaiLj7NYktLhQorsDm+QpcGcJSWI1NQjiubErk9WaYZ8+U06VP0sofH0zm5HwRBAHUOo8du8y7uCeSokoMyy/WEaHNAkRTS1GCzylL9zsndyWvb4hIbWztHO17RdO02kFYscGX7tKMgy4b5MU/mQGrmh3TSoTdYeYpb7dSH8mmUgZ9dWkHgl4ZSe5RMu15g16N3K4Ylkj8zJQFK2gZ4nn1Nz2maoeYcHcAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB6664.namprd11.prod.outlook.com (2603:10b6:806:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 05:39:34 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%7]) with mapi id 15.20.8769.022; Tue, 17 Jun 2025
 05:39:34 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] ixgbe: initialize aci.lock
 before it's used
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] ixgbe: initialize aci.lock
 before it's used
Thread-Index: AQHb3sX2fMHQVtJGf0SVaVVEZURFi7QG1r2Q
Date: Tue, 17 Jun 2025 05:39:34 +0000
Message-ID: <IA3PR11MB898650F1DA8C2169071387CDE573A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250616133636.1304288-1-jedrzej.jagielski@intel.com>
In-Reply-To: <20250616133636.1304288-1-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB6664:EE_
x-ms-office365-filtering-correlation-id: 246f6a60-cc40-4011-6272-08ddad615782
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cfJ+DJo5SJ3miVkCBwLgPLvAMlIiQ445hu66rdSBSBL9jLsrWrhkj0p8lGnf?=
 =?us-ascii?Q?2aAWaNv3VFF5QkPrTzu/pFqIX9plgVEL4N6mp+Ba3doN29rOR2zD0oJHW4wM?=
 =?us-ascii?Q?P1wEusP9eOw3MICPUvZ+rHTd+tzNILxlHfdvIYOaZsGrt00GdZbjJ3evj+p6?=
 =?us-ascii?Q?LQRDBa1fzkU12cG3x/cAITVOBUUbpXWsHukvvELpMb+4rMkA/+V0tUxbh9Fp?=
 =?us-ascii?Q?SOYLFqd5xS/l86t9RPO/yOtjD7KqnaUIHIAynvqKzz5tQt0wOGw3PVjy4/bO?=
 =?us-ascii?Q?KnEWNWyFNgMkYvp4UTOYwOAPgYmAyVaFGnBT8OEh+M8QZGTONOt9op6DZhSQ?=
 =?us-ascii?Q?OtLcDs1C1NoGII7miwNxTn/BbTNQjviQjOXN/Z/xNwWmbqYdoEppSKPw7sT6?=
 =?us-ascii?Q?WqeR9rWp1KAQ1Yjau34p2Ys+OyRxpwyICv1kmrFPSkC6yXIbqpOjPDjuTOli?=
 =?us-ascii?Q?i73voIx0UJmdGLST+lGvmsXAaluR4PJRLRJUbja56PL3SR0mSDrT7+xvZsvZ?=
 =?us-ascii?Q?XvoQYYYRiJtNsFmXb5OeMXtqb7pQHOXMA7MvLWU7tAFLXDCPWj5uRT8NwKN1?=
 =?us-ascii?Q?7IO1hYMvnQVU0IsoSSfHgeKE0w9F4Jh2pcO5vQu220pJk/4Drm9il6AzdSqr?=
 =?us-ascii?Q?THnS8OT2/8uVj18/eu+BTx/n6Z0oUQZforBpfr9audbSt1RYWXwtlwxm+2dL?=
 =?us-ascii?Q?ACjyi9F1tDYTZd5v7DhPe75pzjG9O8uWgEXlett2od2efeZSkED2MBcnQ6XA?=
 =?us-ascii?Q?a0KpEn24uTRwYg/oL9bG3WWffGRkcZK2Xbrg/Lz0pspFdOVuXN8gbsnfUIVZ?=
 =?us-ascii?Q?20o/NXh7Zp+tDZ7PxQCWUAVHOooKtdO6bRlGyFfvpk+1HPTMcRAfqRbQpaAV?=
 =?us-ascii?Q?X7wxXbUSBTV7toNseFfbemUf5GZRVeM7pylOaFgq4lvfy9Q7m5NsJN2s6tPA?=
 =?us-ascii?Q?ksNML1W7p/tnj6EKQosOPW8ysA7XDkXssyidJVfpCYFqWdqKvAnZRl3EgMF5?=
 =?us-ascii?Q?lgi+LJ1GSvnwJC3yDdZiRUJugoaL1dZX3KwEKdNFeRuwREaMvel3NbbEOPj8?=
 =?us-ascii?Q?fEX34YmDzPn7VeR+suhCIk3EG2w3rl4uQLMc3WLWt4Nygkip/4ANThNxRVdc?=
 =?us-ascii?Q?C/q7S3uie2pxZVHoiJgCgTy0Rg75PBjA2jxy5YhYIbgLbhXmVMdqStrmNZmD?=
 =?us-ascii?Q?A6uD81nuZfXbopmk7p9TFPuIimADgas1jD1OX/82iggvHiWP3F5qIDg1Cxrf?=
 =?us-ascii?Q?MOabdFti14A5rm6kRJbobzwwUWZORB5JxY8syhYqhbUQjpJkIckOGUrqNVed?=
 =?us-ascii?Q?RfrA3VC876lYw3rdIwSpUnhxKZCNNPGSIfhPdWSCcTVhVemlsjGhRKz6a0GU?=
 =?us-ascii?Q?I8Y0AVUQdARPmT7EZi1M54IVxce3TbkYw5E9D20fF/Ec51Yctflfxbsx9Z3K?=
 =?us-ascii?Q?jCFFFpbYK9ErydrdRKb/t7baBZS9j4ORBDzyrZe7ZkqL8E61sq2SQA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QByUJFgWlYtlrnIe+aVyQj3sBiuc2PrXDEpUXTd+h8Qt48PR9sNMkjBmaUsk?=
 =?us-ascii?Q?2lPlVc9+GzAF34f7BhbJoCAM58HepIGAQJniawT9Yi7N7CfZPGQNWLwDa4cg?=
 =?us-ascii?Q?mZoCV4klNE9+jgvB3a5kh84iKEAHg92n/20n6SEA15jLy6DfsZpb8YTeoZmt?=
 =?us-ascii?Q?yJAzUzXmvLCoKThOksmvH5P8WSNL1yF5DVtPz3IKv0eBB0y/xCLaxAuKlzh0?=
 =?us-ascii?Q?ANu3rio+E7OFGR0PJe7pjUvJ/cIlpAlv6Zim8B0GIgVtsCOEGvXdamF7Cr7p?=
 =?us-ascii?Q?CDqkWbDxmUOAC+m7AzAr9KtQwtpGmPXwmvZkqjm3xH741tIZaugeRf2mAR4m?=
 =?us-ascii?Q?qJ3fYbMNKWfkyJx+OWUvSBETCwQwfRY9ia9XvgRfGRvgiGK19AMn1YbUZ4xE?=
 =?us-ascii?Q?IG8d3+caPEk1hcLlCFlhTOSpS+xEur2rU5WDLyofkNzhqTxvFHIHL5MRYPLC?=
 =?us-ascii?Q?se/5WHW4q6sNuM7BQS6vzgTsYBLU5cPiN8jk60q6/HL8G1F3pyGocBX3YjcW?=
 =?us-ascii?Q?uveURg/30dNTDUHBy4HefL6J0Be3pQ20gfhPwpkDTiWDYmW/TEAiMRgwGF8B?=
 =?us-ascii?Q?S7xc04YBDu1xYudmie9iAYX/KroZL8BU6tVolIkbWQ+8LgMUZ6aqmBpKN/yq?=
 =?us-ascii?Q?ltr1LTAASIJCNtRqJsMdlTsn0X/G22DxT3zpGNtuNjphXmcnp2r619W+I4Y9?=
 =?us-ascii?Q?zZve8XJsWKZzBjeUdCxjBwua8jDfVCqExkfbmzdNXW44s7Q8I+rPPhhfNTHR?=
 =?us-ascii?Q?o/phfcOBitjZ22J8ny5DUum4acn8pBlQyk9q+NLNEzaIWnOHSRMnRHUV/LdB?=
 =?us-ascii?Q?oh22SBwz7sd+9j0nujbvQuQG6JFdH6BnNVym7XlbNypI6sKGrFMvMnF2Sl8y?=
 =?us-ascii?Q?n6s4vCv7SZ8EdLL70mjdk248rb/Cs/a2VMq8YPsTLfW4V7kBdQ6/SOg1aA6k?=
 =?us-ascii?Q?DcjwKKjftcvaKpWR83rEZ1VT1jrAIBy7i2PEFfaQIw8ctmA8xUw2dwcpv05+?=
 =?us-ascii?Q?NaMlAsDR2vu3D6OmtfuG1uYXXg6Qih4+gwu01uBh4eQhLOtX6GPkUb5U0Mhy?=
 =?us-ascii?Q?Xfj8BDF8DApk+LmfOq4yCExrgZDgaYxMy9CxqgzTBR+W5bTPKMgB3jDxaBRb?=
 =?us-ascii?Q?mfm1N60RujmIi3jGnHgItuB2GECeCocSjbFIn1wbk1DlRAUPByMu7YHvRG3r?=
 =?us-ascii?Q?RK6rb6Y/ygxvLdTc1axICu2kcHvyRE0uAKRugozfG0RDQeKlh6VGjpQMH8GS?=
 =?us-ascii?Q?IS+Eb9TQuQaNpxOCMSGw+UZT0p+mmLbCHLz3+/U4jtWkszZue6fgcHMiQ0Sw?=
 =?us-ascii?Q?fR1XmdIQYIcwpPXBbkaupcWQmWkQrCztO1US0X+N9YkVzvJ3ohPTyTQOVymp?=
 =?us-ascii?Q?ogFuEWbpC5/UNkvucFnwes6EtG2AmUEy2TD3nuJZ7TCQX1Ta12uPaljtovGI?=
 =?us-ascii?Q?22sjQbx0m7khjgzh4uFGQhOzk0qxJIPDDKTCMvgnXeysfbXhAucrRidbCPRc?=
 =?us-ascii?Q?W0zyhr7ouQMI9pajzAU5zhYm2iEwGkT4xCLMPGAYw/08/b/eBXdNvhnHI8jT?=
 =?us-ascii?Q?0vwMP8hdIR8TKS/OBQSFBZN0j1AQHZHsn4mf0AcbNukv5WXUK8QoNuwDK8C4?=
 =?us-ascii?Q?dg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 246f6a60-cc40-4011-6272-08ddad615782
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 05:39:34.7761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pWIn/N2SD1iTnXIC8DpsYosogyiOaQociApSQrPZyos27+G53c9TavbIbW0UEpaGbgIDdV3ufh+vVl9POwjczE7WtgrnbOs110qCaWEse0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6664
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Jedrzej Jagielski
> Sent: Monday, June 16, 2025 3:37 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> netdev@vger.kernel.org; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] ixgbe: initialize
> aci.lock before it's used
>=20
> Currently aci.lock is initialized too late. A bunch of ACI callbacks
> using the lock are called prior it's initialized.
>=20
> Commit 337369f8ce9e ("locking/mutex: Add MUTEX_WARN_ON() into fast
> path") highlights that issue what results in call trace.
>=20
> [    4.092899] DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> [    4.092910] WARNING: CPU: 0 PID: 578 at kernel/locking/mutex.c:154
> mutex_lock+0x6d/0x80
> [    4.098757] Call Trace:
> [    4.098847]  <TASK>
> [    4.098922]  ixgbe_aci_send_cmd+0x8c/0x1e0 [ixgbe]
> [    4.099108]  ? hrtimer_try_to_cancel+0x18/0x110
> [    4.099277]  ixgbe_aci_get_fw_ver+0x52/0xa0 [ixgbe]
> [    4.099460]  ixgbe_check_fw_error+0x1fc/0x2f0 [ixgbe]
> [    4.099650]  ? usleep_range_state+0x69/0xd0
> [    4.099811]  ? usleep_range_state+0x8c/0xd0
> [    4.099964]  ixgbe_probe+0x3b0/0x12d0 [ixgbe]
> [    4.100132]  local_pci_probe+0x43/0xa0
> [    4.100267]  work_for_cpu_fn+0x13/0x20
> [    4.101647]  </TASK>
>=20
> Move aci.lock mutex initialization to ixgbe_sw_init() before any ACI
> command is sent. Along with that move also related SWFW semaphore in
> order to reduce size of ixgbe_probe() and that way all locks are
> initialized in ixgbe_sw_init().
>=20
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Fixes: 4600cdf9f5ac ("ixgbe: Enable link management in E610 device")
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 03d31e5b131d..18cae81dc794 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -6801,6 +6801,13 @@ static int ixgbe_sw_init(struct ixgbe_adapter
> *adapter,
>  		break;
>  	}
>=20
> +	/* Make sure the SWFW semaphore is in a valid state */
> +	if (hw->mac.ops.init_swfw_sync)
> +		hw->mac.ops.init_swfw_sync(hw);
> +
> +	if (hw->mac.type =3D=3D ixgbe_mac_e610)
> +		mutex_init(&hw->aci.lock);
> +
>  #ifdef IXGBE_FCOE
>  	/* FCoE support exists, always init the FCoE lock */
>  	spin_lock_init(&adapter->fcoe.lock);
> @@ -11473,10 +11480,6 @@ static int ixgbe_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  	if (err)
>  		goto err_sw_init;
>=20
> -	/* Make sure the SWFW semaphore is in a valid state */
> -	if (hw->mac.ops.init_swfw_sync)
> -		hw->mac.ops.init_swfw_sync(hw);
> -
>  	if (ixgbe_check_fw_error(adapter))
>  		return ixgbe_recovery_probe(adapter);
>=20
> @@ -11680,8 +11683,6 @@ static int ixgbe_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  	ether_addr_copy(hw->mac.addr, hw->mac.perm_addr);
>  	ixgbe_mac_set_default_filter(adapter);
>=20
> -	if (hw->mac.type =3D=3D ixgbe_mac_e610)
> -		mutex_init(&hw->aci.lock);
>  	timer_setup(&adapter->service_timer, ixgbe_service_timer, 0);
>=20
>  	if (ixgbe_removed(hw->hw_addr)) {
> @@ -11837,9 +11838,9 @@ static int ixgbe_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  	devl_unlock(adapter->devlink);
>  	ixgbe_release_hw_control(adapter);
>  	ixgbe_clear_interrupt_scheme(adapter);
> +err_sw_init:
>  	if (hw->mac.type =3D=3D ixgbe_mac_e610)
>  		mutex_destroy(&adapter->hw.aci.lock);
> -err_sw_init:
>  	ixgbe_disable_sriov(adapter);
>  	adapter->flags2 &=3D ~IXGBE_FLAG2_SEARCH_FOR_SFP;
>  	iounmap(adapter->io_addr);
>=20
> base-commit: a76bd1156de9fd1d4be4502cbb5160a709ff4cd7
> --
> 2.31.1


