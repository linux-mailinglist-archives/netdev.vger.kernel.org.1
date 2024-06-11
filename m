Return-Path: <netdev+bounces-102682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA590440D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2241C20A06
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C1678C8D;
	Tue, 11 Jun 2024 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNO37K+u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF96D1D7
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131995; cv=fail; b=pcjX8Q/s4mclTrO9nWuh0gajOYP5os8xfkU8FTS1kOpp4N1DcdIKZc/KAZojasAppjpvrxJkFTszX0SL3bm/xBWCb6lCCh01BN+NxcM6TPlQCR/jh56fBpYbSLoT+rwl0Z+BPsWNtdYmeosFvaccg4w6Wb714RTWvj/gKWihcw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131995; c=relaxed/simple;
	bh=dAVgSPynXSPyO2FgV9zoiPFyKujAEZKm4z9KkqizJuw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PgKyQXs46A5u79cToqFPMPsCNUPRbZ0OPJZeUGlvUBPC3rkAvBhuQm8OHGxfCty+SvKtSTKzBuBrYrwP8Nmu48WCYiVO6zgmUGsIemX6lQnG9RZfnFqJaMLGbFVNV+HPPvf2pc8xVjpkq9Kd9P7mQ7NtmXR6OjVbdd0QkeEzDgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNO37K+u; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718131994; x=1749667994;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dAVgSPynXSPyO2FgV9zoiPFyKujAEZKm4z9KkqizJuw=;
  b=XNO37K+uy/Bm1RA9WTtLYwE3ybnPa19UwoV7eO4D+xeVT2MBkSdhugRo
   vjoHzgHpvANh9B0zmfPUXzshtcXghxp4H2VqBKMP0fbUO5ZbKKN4BhwoP
   VRUQlnDM6jYhbiVkFpwQPgQD6LIyrlvcR+h2nOQMEatEksFfGZEXNS9mP
   0Owr9IOuT1WIwsllpPZ0wJpZ3cctC6i8t2e8ny3GgipJJqCczEgEyiGTg
   S0m5CeX7Qqy0aH1jJMJ4jKNvZQNm/dlYHqpR0FSZERKLUhfQ1o8QPJH8x
   OSRgUCZXveGq5nivHVDPm7KBlaGpfBOwQs26/OSs3Grbo7nLl1woRqkqQ
   w==;
X-CSE-ConnectionGUID: pkJQaoipRgWyFSy40QRrjQ==
X-CSE-MsgGUID: DrtXpxhCQFeEvVgrxNqIWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="26281844"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="26281844"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 11:53:13 -0700
X-CSE-ConnectionGUID: z84LZwdZRWWl9inA6Qj0MA==
X-CSE-MsgGUID: DXQ2vMzQRXO4RVlweA5BeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="44482014"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 11:53:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 11:53:13 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 11:53:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 11:53:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 11:53:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGPR7oCTzHLdXnD5h4gD7FER2Op37PmymNiwagMv9WFhSe8Io6q0AUwFl5jFCxok6DC4iAhj7K2WuK1zmM7tdAw7HeUbdFsBJ1wjYuFZzIiGvugFlGEXyOOM0XEPs+9QheUtsN8kMXDEs8S1s4iccQG+fu9d04v43JLxw8JRwCJYYdRzMfiOiUTltR5KRL+3MSmChRCqXApjXkqGfbgmy1wdKCDn7+2DjDu4C/Rdt7Z/y8UJtfjkNznKYq60JkxyEX6Qqt92ZQrfRabO8+u/CIZMEbZzyE5LL3r+WM7HhqohW7ac2SaTRXYWZSvpXLqpUcheBWlQklmULOofiyarwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fineW5wY8dYTm7oit9yE2UTz8pRoWoLUjgf9QqJpvg=;
 b=jvhSvoIXDf8rllb1emz8nzqbpzp8TJlQKV/qsrQQMWKKmIE3dMSCorJdFAiiP0DPp7s13LO61OjFu+nLLj1lbPQ8r6QFwzW9pg7bSz4sqsCH20eWWHwIk+r69oXEknZqD7cr8PnvKvwtwje5aPb7yUfbLXsZb0nJicPyuK+2qeVah6Fv6rJyDGxTAVyoEIX9RyMj3rXw45Qchci4a0hjg/sSqZF1JKQyFX5LpTFDtapI10q0IChpyiPFXijoBX4g6KBTQE9bu3Xx80cyI4MdC8Zp36BSjr8IIF6ytd2kStXn2svTHCSP64tHmeXgTuxd5dBmV+ceEOTREZtleGW3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by SN7PR11MB6922.namprd11.prod.outlook.com (2603:10b6:806:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 11 Jun
 2024 18:53:10 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 18:53:10 +0000
Date: Tue, 11 Jun 2024 20:52:57 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>, David Miller
	<davem@davemloft.net>, netdev <netdev@vger.kernel.org>, Wojciech Drewek
	<wojciech.drewek@intel.com>, George Kuruvinakunnel
	<george.kuruvinakunnel@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net 4/8] i40e: Fix XDP program unloading while removing
 the driver
Message-ID: <ZmidCSuzHvV/b5B8@localhost.localdomain>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
 <20240528-net-2024-05-28-intel-net-fixes-v1-4-dc8593d2bbc6@intel.com>
 <20240529185428.2fd13cd7@kernel.org>
 <778c9deb-1dc9-4eb6-88d6-eb28a3d0ebbd@intel.com>
 <ZmB9ctqbqSMdl5Qu@localhost.localdomain>
 <20240605122957.6b961023@kernel.org>
 <ZmGJM1hHOX/dvSYY@localhost.localdomain>
 <20240606064328.70878e5f@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606064328.70878e5f@kernel.org>
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|SN7PR11MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c1b6ff-650a-47cb-1f56-08dc8a47bd72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oZOKqjPWUGqtymzYOfsSl0VjtP15FzC99roLynU7G5+m24lRASsupbN275EY?=
 =?us-ascii?Q?PL2sgNB9YOi1zgFeME3ksH0e0y7+QojL9zpTx61k7GYrDeqGQeppOYKXyFmu?=
 =?us-ascii?Q?Y/6eumDgDN8pOadPd7bVf6RJqOjwkWgsCv9vFh097KQHLGISVRAKCI32FPlL?=
 =?us-ascii?Q?sl+VbCoIlJydI8CtDugKchaizBSO9VxL24//B5RzjdUwvrGiUMSgKg+f09oF?=
 =?us-ascii?Q?41YZ1joKi5sbidH4JNJeP4dj/tNCH2FWr9mKAvzpz+CZT+tBJRap02xrYc3Z?=
 =?us-ascii?Q?6nwacMWx20TdkqPQW4dgJvO4JB20pf292HBnY5GsFrQacWWSBXO5q6qxP9EK?=
 =?us-ascii?Q?5g4UBFrjCetnxCrDYgsn53mYXMyDKGK0ohsED49rnEXATLPNotD4LZryzw5U?=
 =?us-ascii?Q?M8RPKnBj4L6jLKIxFiMnl9F/UjxdTw9SGmu+rcdbEEcShzd2r1MoQMyD0Kke?=
 =?us-ascii?Q?x3PLls6xeQjJ5pWdVweBK659SXrQR3K/2K3mGYNTarTCXOwYvi/Y/HNkmoHp?=
 =?us-ascii?Q?6dIv80igN+OUX8YMTaii0IGHV8w1zwofHURup8ABrfJ1XbuCH0APAZqKikg7?=
 =?us-ascii?Q?zuVmAousUWiWn65WKL73gUyNFqIvCrMcnD4i/7bd/G8UDUkhjCQvNWsFixpa?=
 =?us-ascii?Q?R5Ol6wUDCEo4R6OTz2Duoin+E2dS/YCPK0KC9NPkfbuVl3vDw0qGDqbXyaht?=
 =?us-ascii?Q?SjSDytsWpygcOtgtrsEVmx+ZgVkQtQIiTjKawlzo9L27sb36NFHumWd9D+4w?=
 =?us-ascii?Q?n99R5qeLjqH2o767PLNyhmJOLyP5Qc+Vs7Lxx1o0RZNrB6G+8iag/NkjuupZ?=
 =?us-ascii?Q?rwDnnb1gQ8a1fObsQY2fIXlUzIfuDeEBt/IflQ5rdclyn3IT+0IqH92SQZOd?=
 =?us-ascii?Q?qC2NaDJHV6xWQ7jmeyfr2Kvag9zgL4R6TRIvOevRdjqOL3+uFzUaxLuxap8s?=
 =?us-ascii?Q?d8b/933t/fUgNo7Dd8ZEpRqyBfmNg+DPUAPJ58prxooLYL6/sQZgRHbzzERs?=
 =?us-ascii?Q?0zpvhWSWgu7yMMi11tLQMBEeRhjshYcMnSdKk9ldu9nSSaC4lpZXSsYrxTBo?=
 =?us-ascii?Q?v1bFVVfxXXuEs9p+SXjKqMcYc3j3lvlW9sCcakKMHLyWeoJgehBA4UiEz2Yd?=
 =?us-ascii?Q?931nKtxIaiZb+sWyLg6/PkwmAWVyrQfG8SzIDR7DKRegxrE0g+cD5rxBSp2J?=
 =?us-ascii?Q?dh9/lrkmjAJMRtvtyv2hU1IAtBmtc6Ljh+zIRuLLbKlo950o8t1/Q80TmO4D?=
 =?us-ascii?Q?LryK4Jv9NtE+hF46ADWPvUFgUHkPKFgj64a7zfGcCl+tDav6GqaDCF8+I0jF?=
 =?us-ascii?Q?b6maQDzBvDt+zgpaaCS3iLSo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+m2BjT2Rn4LqM9vbFiMDBdVn6PCvJjWhRq3tgSkQmyGIROFuuDuPWUre0wcT?=
 =?us-ascii?Q?kc5f5q+iPzPOw9vImb+1Yi5U6xm5DOIHKNVILMg6J1CLAYhZRvL+BECkBTvZ?=
 =?us-ascii?Q?3pXq8lts2+gJHBMvZVqFytC3UdihS4pb1MPEf/4U1Zx9PDOtfEeeVWEU/7ig?=
 =?us-ascii?Q?RMdzaSm1eRwQMx1+uHSOGh65P3a6B95zGm703SfN3PWz3pBO2FpMulKpSz2i?=
 =?us-ascii?Q?q48bd9ZCmmgrGiYM2G++0/0aY5INinjbOflgR+r3Nh26GAddnwLqsIsDezn2?=
 =?us-ascii?Q?WLWesMxmkCKp1lt5itz0/i4qBFPiOjUVbTXn97apx5iNxvMonaWIY9VPyo9R?=
 =?us-ascii?Q?H+6s2/uQS052fsnBId5NhcsXReVuFZSqvKtvqwH8N1WXfanJGHn6vAqPRxIW?=
 =?us-ascii?Q?OyAOC2HDOMgdWXNYMQbumF0CYrnJEaZkI4ENGfr9vBg34APohopAE/k10wyT?=
 =?us-ascii?Q?6cPxyXnkOz/b5XqE9uK+ag5qk5+D8Oj7Vmkc7IjvTGndVT4JZzliLgVxg1Xt?=
 =?us-ascii?Q?0uPx50IQ3RncsElVvnJp6iLFVbJ/L7Sy1gkfrmhuufSzUVwPazjb291T4GO/?=
 =?us-ascii?Q?nk2yy8tNZ3FVFkrzaEIS/q4v0uY2Qth9PXQPTdbe6QGXbQCGbAdPOTTtJIDc?=
 =?us-ascii?Q?oSOhl1xdUjWkpLdCNt/R1He7jVblE2uATfjd0vM7We81FXGNPFn9JMRJJh/T?=
 =?us-ascii?Q?PfK14B27LweRtiwJYfcajfQRfFYaKKIdnEmHK71SFeGLnGRoyqC1/To+GGF+?=
 =?us-ascii?Q?09YpUmcdQEyZ5avZTIgiB5OYF6XA/1TRRK60yCiusqHCO0uviW9wwKiRMMH/?=
 =?us-ascii?Q?UrzXF1uhlM8WXxGjTM+VYx6XXRQZVV8R+FXAkUXmj5/Hplxv8bOR0Y04EzUy?=
 =?us-ascii?Q?+efAvePdUrq+wmJqX+CaZa9ZvQj5mS/mb1C8wN0Tn30S3XZjoFidJEE2T1TW?=
 =?us-ascii?Q?VoXnC5OnUNb5IEbXH8WeQN5S+YyfswVmGsEoApCxe+ymKN7B//ZV0FOr0umd?=
 =?us-ascii?Q?sfQWWQRBv2ISKMYayFaK96Hzn+9BKAtm3ynegPxGN2ZX4EgIq9pU7JOgnBEv?=
 =?us-ascii?Q?sf4o8VercbuOEEi1dpMgbxoJ4MUSvw8lGyY69mqikVq2yi/j1dtp24gnD+PY?=
 =?us-ascii?Q?yfywHh1HY4OmmtpzI6w5NonhKPoPvoj5burM9Zazydoyhh/sBJ92lL0GggIE?=
 =?us-ascii?Q?K6ZsJox52XeOYMD/DUO5sKOQCL8Vus0DONQ5R39Ug2d/GBlTMgO1A/nQNVcv?=
 =?us-ascii?Q?MFweA+v37DEpqGzIeE3F4RDMCVp+RXls9pGQ4SSIEcyyW0FNngBn8sWK3MTP?=
 =?us-ascii?Q?01qRJdDxTkmqvBqpQ/tEOdf/DKnW/6ot1SNVrOYXJA+1nm8RCpjwn8BT1Yvx?=
 =?us-ascii?Q?lQwDAPecmJ+MOQJ9R8jwTmSpTY9H9CU5YvZ9DwrGGxv99GQrM+9tZfxtdLKM?=
 =?us-ascii?Q?sOJdff3biAPzev8yJ3I46PYLZA20UPayyWoIh58GjdxpsjTSWwdPT+6hFlZJ?=
 =?us-ascii?Q?+vNNdCJ490fJPbG9LTDX+2zpA7gEiADKFNPtslMnoGRHyu7+3Q+G1xelgxT2?=
 =?us-ascii?Q?l1hQAo8C3EcgViEaM4Pb2tKaYpu8ucaVOIQG/8I5WxYkqC7iRHzPLijrAnJd?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c1b6ff-650a-47cb-1f56-08dc8a47bd72
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:53:10.6936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNzTQjzHWC2fgnIGGz8d2rikkNeHsolVC4geEH+8SyYGkSlZLlO1OcqQ+siaIs0LEkMnFfF1KwwxbwB5+zNlLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6922
X-OriginatorOrg: intel.com

On Thu, Jun 06, 2024 at 06:43:28AM -0700, Jakub Kicinski wrote:
> On Thu, 6 Jun 2024 12:02:27 +0200 Michal Kubiak wrote:
> > > Apologizes for asking a question which can be answered by studying 
> > > the code longer, but why do you need to rebuild internal data
> > > structures for a device which is *down*. Unregistering or not.  
> > 
> > Excuse me, but I don't understand why we should assume that a device is
> > *down* when that callback is being called?
> > Maybe I didn't make it clear, but the ndo_bpf can be called every time
> > when the userspace application wants to load or unload the XDP program.
> > It can happen when a device is *up* and also when the link is *up*.
> 
> The patch was adding a special case for NETREG_UNREGISTERING,
> at that point the device will be closed. Calling ndo_close is one
> of the first things core does during unregistering.
> Simplifying the handling for when the device is closed would be
> better.

I think I'm getting your point but moving the code for
NETREG_UNREGISTERING to ndo_stop wouldn't be enough and it seems to be
against the current design of 'unregister_netdevice_many_notify()'.

In 'unregister_netdevice_many_notify()' we have the call to
'dev_close_many()' (which calls ndo_stop on i40e driver) and then
'dev_xdp_uninstall()' is called (where there is the call to ndo_bpf).

'dev_xdp_uninstall()' seems to be the right function where all
activities related to XDP program unloading during unregistering are
expected from the driver.

Anyway, I analyzed that code one more time and I agree that the special
case for NETREG_UNREGISTERING makes the code more complex and I can
implement it in a simpler way.
The root cause of the problem I'm trying to fix is that __I40E_IN_REMOVE
flag is handled in a wrong way.

I will post the v2 then.


Thanks,
Michal


