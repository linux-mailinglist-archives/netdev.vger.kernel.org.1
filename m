Return-Path: <netdev+bounces-264723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEa1M6ynqmlTVAEAu9opvQ
	(envelope-from <netdev+bounces-264723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 11:08:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC1C21E749
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 11:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DC95301DB8C
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33E52DF134;
	Fri,  6 Mar 2026 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTF1Oub5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D1F23D28C
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791520; cv=fail; b=pNTpbypfrnEH2kHGXfzsx4nW8fG2Bsh75safwuw4+DD7I87Y3QXWMsP3VEx3JR1BnAv62U0AGGNnRjFrbOfps+CdXyo35g+9qT7ALJ3dcl4w9QRWR4EgkuvesBCeQ2jPSQbZ/ktDbrb3+PKqCu2lBDTn2FsfxQ+0elNFCoA2X8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791520; c=relaxed/simple;
	bh=+ClSVlgl3g9fs9LNjeXWyNFn3fTPSHPQyambslBo8wQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oCh1C6og/UUqZ4Ny6cpcrP24xE9GkiKnGgh5i32YHqV10iOSweLT5SyM+EekrZ5QMoSAoXkt0gySgSTUQUCrf2RA8CcA+zd+K7aibDw4epzywjyBz1Ft730Xr/DIkzw8nFlcKNHG8WF0iVYCs4+7w4hUnp1G6ZMuW7PWqZw9fFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTF1Oub5; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772791520; x=1804327520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+ClSVlgl3g9fs9LNjeXWyNFn3fTPSHPQyambslBo8wQ=;
  b=RTF1Oub5GxbOGn0/TrasTRfd7Dlhi7+zj23uv5uzDc3+OVDlzCHwSGGp
   T+8gPbZcaU0T9G/y8UmmRS+TQoKVsQ7kMefpElr+W+ROeKddDdWFN9AVY
   jGuB2zNKxDHUXHGHlJV2o1c5gls+fKJmtniPdLcIdAY/V35PBqGzM1vC8
   3X6UreImjE9ZvdUS6h4SpQcKCfZCS8lC717DQjIomNe3SqvQN9qoyU+H7
   Lhrxf3GjF0ImIIUn5/udBLJYuB6I7e5KfJ0np7eFNj9FslbS88yaqUXDU
   yn0pzMXfH/gHS+KA1lo4ReWgtpphlVJ1+MdUdi7n75PUb+7mKYzgbvb7W
   g==;
X-CSE-ConnectionGUID: yqn7DM8vR6qz1BzpawsW9w==
X-CSE-MsgGUID: Rz8e3c3CQ++hhzzw3bp1vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="91286332"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="91286332"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 02:05:18 -0800
X-CSE-ConnectionGUID: 6vqT4XO8TbOrDbRF129xIg==
X-CSE-MsgGUID: FPCQKXjRSGm6Do0amqBP2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="245279961"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 02:05:18 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 02:05:17 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 6 Mar 2026 02:05:17 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 02:05:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s257eNEwArRoHW1QbLs+PwLATHgo07+WA06+7K85BzXtOj1UrcuO5O6R5HC0+Xz1JOmgBVoadpXPS1N21zG36aJACVBn30B8qjv2UJuLfo4Nk5oYATLREMAXywjSpnt21KgYA4ON8E1E44rZ6GTHFJvyRqbDlTtQM66aivVtQwmP2xz5i78iz6Y2RL5usPcCT5OqML0QH0hzXvBIFTSguaM8+Wy0oyQgE+32MpUQPPdZrqulvEqBwQ8tJGrI/IFUWpLyt0zEq1vAdxIjyrQ8QyWz7qRwUh94YIs39v0cacr8Am/bp8/R17kHR1vjhsEX24I6L98owlMSnQlJgxwkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H07jo77iK/5G0fpgmyF1ZtMh+k6DCKfaOChvPLELpIw=;
 b=cGgVIHFK0i8KQ8XQjDIp3D/zo6QZOGhpPpAIkKE+FEequ8S+YW8CDUAsqTTor1Zkzy1wjUHkhqzhRs1+qgDTUuOUk8e7sz3/SyJNe54Sr8u2m1WAMpOK+Z+V9CwVNLuf9p9Dn7CpQsJU/yqLUyXi+P0O2VU3lkKvONTLjSX5sJXOBBI9jrbCogHR9H926a85/rUh4gmSzcYgNx5KACN3f+xXrYD8due8Ug7+9LaMrCkod/QsdyeAzWci3jse6z/HT6adBwkcJ8kQV2arAgxllIwRE4xPeHN0GqXaFgOJFlTAQ1Y5dG0RP7pmup5ix+jTA7TA+x6to3PO9aj5tQsmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SN7PR11MB7468.namprd11.prod.outlook.com (2603:10b6:806:329::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 10:05:12 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9678.016; Fri, 6 Mar 2026
 10:05:11 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Nikolay Aleksandrov <nikolay@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: David Ahern <dsahern@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"Greenwalt, Paul" <paul.greenwalt@intel.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Ertman, David M"
	<david.m.ertman@intel.com>, Mustafa Ismail <mustafa.ismail@intel.com>, Shiraz
 Saleem <shiraz.saleem@intel.com>, "Nikolova, Tatyana E"
	<tatyana.e.nikolova@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH net] drivers: net: ice: fix devlink
 parameters get without irdma
Thread-Topic: [Intel-wired-lan] [PATCH net] drivers: net: ice: fix devlink
 parameters get without irdma
Thread-Index: AQHcnMWNW/ul7w6ZvkOjhICbx07HPbWhZ1ow
Date: Fri, 6 Mar 2026 10:05:11 +0000
Message-ID: <IA1PR11MB6241A88179CB7D5CF82E3E3C8B7AA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260213084841.1406442-1-nikolay@nvidia.com>
In-Reply-To: <20260213084841.1406442-1-nikolay@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SN7PR11MB7468:EE_
x-ms-office365-filtering-correlation-id: a3c2e946-47e7-4bc6-5ece-08de7b67dae5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: Sek2pKKkshLflpJ/7fbKjShU5QHNC276wXXtn5mAzPIf8ZeVOCcmxUziLM6onWqDfyHjxXmmOuNzX3yOaf6QFWrjd+7Tc1c+NaQoLzoFBrZ9n1Vmp6AzfqyVADkNlzVlVTnEYN+KdPx1EMfxV8SU3UtC9oWU6UJNUzXYnK5p2fAn7+vnTTmDlX50iL+X3Otd+QOPVYwQy0YfNw6W3fEaB2VTmOWQYQRPWYYwmGfV8nHnMJJTl5FGf2KC1FAZyHdLo5wqYcOmbDiVGVzQ7DVEoHEpvUM+JoIuEj5Ssa9t1m/YE6kdhRmrmG4+kgSCsl1t+EoGPdeB5fY0nXCfrnp20GrL3cWB+p5+FTwRtKyAypIMWiIZGz8g1jycsFejCN9pPyXVbeTfqCZdYXP/Bx7F6py+J+B5RJqSfBuXrZ0HZ5OtGM0tLu2nSnQJwnxbA3/PuTZT9jEtDZTBfnXuUKC8mODsFcB/WnsAWvXw6ffqYCrlVPaT0pfI3yEqhvxbZdJmoeia5msf27r4pACnHMwUHibLoSd/uCgYocrOQaMeLE07IFGAzat1k4fYN2z0w6JFz4Mec5zL7/sNKOkd84lwdo+Ix3TcDBS2gceSvBD2dU79p7nC7CVQZ7lTVfpTP5EmlL3AeKWRL/B3B2JyNZUYXDDvME+eCxP8Fw6jf7bhyeTqkrIqRORxwcziJwXqTe+Ywo3E4RuS/gTLhqVcVSPZyolFTIIJmvWb5jo5mMd0AGjflJNNnwgKTcH0vikX9/sJQ/0bvYCUFkFbnqjrhn7ak5aT+gZrGPYBE3/T5HveqHo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GaWTJBsAGmaWw0vqyZ5eRPBXO4M8Wnk950+k5lQbh6gMaG7YiS2HngQJlZXA?=
 =?us-ascii?Q?QsIkozUw3n3HNcJ5Lz668rFlTHcYI5UlVyBgil8Nzt5/pGza70S9AljElJBC?=
 =?us-ascii?Q?9rkaXJ5FUO62XZexpAwqG4JRfGwqMGEKsG4dPDHCuq5OgSIHHJqHSCcf0D0s?=
 =?us-ascii?Q?XFize0vFT3FKkpvhvAS53CWhA0pl1UNePTJN3vK8q4D+W3eLqtb+o/zbZf7J?=
 =?us-ascii?Q?Qe9/ldpbK+sd2YYTgl+tUPOC/zHeZI1rgTRhiS8//sR6OYchuNBED6RmrwAs?=
 =?us-ascii?Q?W8EGLob6Q8AdHKil2HQ58HAjdMPLbylac6KpLf48rH66PPPMWJ2uqzVO2NiK?=
 =?us-ascii?Q?G2uPbuQ1eiTwzeffLiZFl8GbQSM3dArmmKmxu4Rhw8RAhl0JcpQwNLAMadzx?=
 =?us-ascii?Q?fi7KXqK4LBwLvptEG1px0LwPjvqqhRcScqMMs9/hoaLFQsh0H0FpiEb62YAu?=
 =?us-ascii?Q?/L6W4fGlWSp2n9lOvkmA8cjLtk+P+qP9NTY/HnehdjhEukdzIa6RdXQi4koS?=
 =?us-ascii?Q?rYvgLsoVzScwjgjesxbCig9lAbVPZayQ4QuKCHfNhJwOmadAGRoq5lVJAo6L?=
 =?us-ascii?Q?6NvDpxEhZwR4TMV8Obi0Ijze5aKKc2odvfjkS+IAzxtE/D1gVQS4wtxVYP8s?=
 =?us-ascii?Q?Mmn5HESx9UDJK4YR3jtdtCWVuUb0MQru+iu8eyt3quNaISSFkWuL4k9BH2CJ?=
 =?us-ascii?Q?Bw0wHlR5OCK8tqZ4NxkvtmdPuwKYJ4/zt3vdpL/52imemjB1sbywR8p1prWP?=
 =?us-ascii?Q?8VTZqyh0ysCh8YCnemvYAqbp2LzxB2jeptm+2cCh2u+vXqk3EmBTT9ado8AD?=
 =?us-ascii?Q?naoGIGL3TTcZb/MgkZ+IYvf7MfxneIUlTNQg0mcfQ/GDZ1wqb9bQNrK4FtYW?=
 =?us-ascii?Q?QtnzgzR1lsLOALTDgjnoGEr3B4p8rQAdUmA/0rcw4KNunTUIO1xrCPGSOQu4?=
 =?us-ascii?Q?p/4Skg/NNkz/uD3m6we4U+Q+zAAi3gkwR/nbxHxBiiabuSAPti1ridgrO1iu?=
 =?us-ascii?Q?IFS8PXVieFvw3S49GsssF9oNoZQIv602hNImlK0xlMqjfRlyPDWGtR4cxPTN?=
 =?us-ascii?Q?pZVz6IXoIZbwsR7yJCeF16RPD6xgHQNyJV/TaoDu3c9V2giwNNtffHJQooUT?=
 =?us-ascii?Q?0U8FyMPa8tHLwZ7K1bqv3SGA9A+0OV+sDeBKD0vNBKFVSdLjavfY/qZx3830?=
 =?us-ascii?Q?j7y0l65qHDe3BW1gAwWTaZuElPNnNxhe2XtMUYFt1mLyd8rTPjqfzPrsvQeU?=
 =?us-ascii?Q?oKnxWh6nURuFLzFmsyXeVb7F2sCd1ySJdREht/CZPcw6GUqkKeAA3rWuqJmC?=
 =?us-ascii?Q?WAilv8k7+okB851/YzV9V5T5xVGRI6f9mpw9xNSDW2T2MakdDqFsDueJBMaq?=
 =?us-ascii?Q?vjvdw/Y8ShlkX038IrA67Ly405DdDHwOFw/28Xk52pUjN/QsgYa7SvXorGOt?=
 =?us-ascii?Q?AMEV135VnJ4GtTymRdR7MBqxQO26Q7vwQArKVhdnwx6Su9EIljxzaqHAZRNH?=
 =?us-ascii?Q?PXrxkiN26dhnzFIjRoq8lICdtfGUxXldu00PkSiHwbwwJYahxwuxoVCOVM3L?=
 =?us-ascii?Q?Lj9kd8F+o+j67fHzEjvgBHAUMKg3trPbUj35afgkWoerYOhpDRTwqCM9A+Po?=
 =?us-ascii?Q?kubtOT90zwDfKK18oq79CnOoTYJ+Nyneerg5ZGPdCD62TykuuAaT6PluJMEn?=
 =?us-ascii?Q?uYNVZbvE2wiXZlaZ3V5ETvpnj/TEw67qD/BDGbGIa35ZLI+a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c2e946-47e7-4bc6-5ece-08de7b67dae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 10:05:11.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGJrqz7axoX5ktP3G4jxuuyE6OKSQpsgQRzzaBDXKmB5p0hd5w8+QpevxIbgXWnTj6FVMw933SGzlKv4jXcRcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7468
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 5BC1C21E749
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-264723-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,linux.intel.com,lists.osuosl.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of N=
ikolay Aleksandrov via Intel-wired-lan
> Sent: 13 February 2026 14:19
> To: netdev@vger.kernel.org
> Cc: David Ahern <dsahern@kernel.org>; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lun=
n <andrew+netdev@lunn.ch>; davem@davemloft.net; Eric Dumazet <edumazet@goog=
le.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;=
 Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Greenwalt, Paul <pau=
l.greenwalt@intel.com>; Daniel Zahka <daniel.zahka@gmail.com>; Michal Swiat=
kowski <michal.swiatkowski@linux.intel.com>; Ertman, David M <david.m.ertma=
n@intel.com>; Mustafa Ismail <mustafa.ismail@intel.com>; Shiraz Saleem <shi=
raz.saleem@intel.com>; Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>; =
intel-wired-lan@lists.osuosl.org; Nikolay Aleksandrov <nikolay@nvidia.com>
> Subject: [Intel-wired-lan] [PATCH net] drivers: net: ice: fix devlink par=
ameters get without irdma
>
> If CONFIG_IRDMA isn't enabled but there are ice NICs in the system, the d=
river will prevent full devlink dev param show dump because its rdma get ca=
llbacks return ENODEV and stop the dump. For example:
> $ devlink dev param show
> pci/0000:82:00.0:
>   name msix_vec_per_pf_max type generic
>     values:
>       cmode driverinit value 2
>   name msix_vec_per_pf_min type generic
>     values:
>       cmode driverinit value 2
> kernel answers: No such device
>
> Returning EOPNOTSUPP allows the dump to continue so we can see all device=
s'
> devlink parameters.
>
> Fixes: c24a65b6a27c ("iidc/ice/irdma: Update IDC to support multiple cons=
umers")
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> ---
> drivers/net/ethernet/intel/ice/devlink/devlink.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

