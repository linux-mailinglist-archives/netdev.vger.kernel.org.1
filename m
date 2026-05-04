Return-Path: <netdev+bounces-283849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDHyNnyf+GnlxAIAu9opvQ
	(envelope-from <netdev+bounces-283849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 15:30:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3F84BDE82
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 15:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA26830166D2
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0ED3D8108;
	Mon,  4 May 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/IIgq3D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FED3DBD47;
	Mon,  4 May 2026 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777901232; cv=fail; b=JO7c8glm8tR2yNLYc8CSKRpkCTGGVsUVbJutIM7HjJfeg+O5na9j74gOiEJP1m4rwmZ1BL3fMNsgJw+rac/Rm/DUhGpW5NqOnYJq/NFcSMewq7yhs0YKKVgmNHGWlI60GCNfzjaDi/x9Ipl6JHdItkdLXsAPuTr2oAE3i5V9bI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777901232; c=relaxed/simple;
	bh=iE8Dat1MVu8SLRgwFO2vPh6DuadlN72B9QJlyU+0rro=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W8LrV0pNrcIwHdaQSDLjlAZqzdHWMwd7t6MOpjQJQEnwyGgjsaVKxpb+Xerrb/h1lcSzGVtaRrrcK5EH1++eWLM5bajYtXV8iRz/YjI80I5IQZkKcV3StfZP1kcWKcBZVH6PBFYnC/nnhrG+hGsrBouZ+d1b+Wpu6K4vXBTK4ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/IIgq3D; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777901227; x=1809437227;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iE8Dat1MVu8SLRgwFO2vPh6DuadlN72B9QJlyU+0rro=;
  b=e/IIgq3DP9ZXcNkyfq5EJG/SkdfZvxSZuspJLtNGL1E4sVQBJ/PdOXCN
   5c0oj/SAvg97NUg5nmerFIODz9Zk6gMszWCkwxlExCroDCYaYYsoLjiLP
   3Z6kKdv4U3Pa2kDE3U7EJ4V2FaZtlt7ElKw+4/qxSUk84n5IXlvtchoZj
   a5+a+gDoJorHVmaPhPs4QYXSxIp5PXnijufuYdDz9jM4WGSPhgOrEhAzu
   NiX5XpFYtMmwXp3rQT9SwKfTKDGPo7KM6E0UwkqyjEFJjXW9XzLZk5vYK
   CRSsdEW1mfYngz+c7zgmkaUXb7u4vEED7GBKUf2fWPvUObxLp9BsooWA1
   Q==;
X-CSE-ConnectionGUID: IesLIiklTxmC40JgSOJgow==
X-CSE-MsgGUID: kVFcCodySRiT8nC1WxpEEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="82605292"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="82605292"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 06:27:05 -0700
X-CSE-ConnectionGUID: s7fgqNWpRE2YnkjkI8FuCA==
X-CSE-MsgGUID: Ty28PwSXQWOzUYDWfv5SbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="230926057"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 06:27:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 06:27:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 06:27:04 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 06:27:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQB/NvJvx2DmOcBZnXvH6GV0B1nBOGe7QviDxD+xylDoASx9wDBFg0oye+66Lv8ngoB46CpnTvZp/hJe+8+Dmc6r0WEvwBNT1SoC3Ck4IOgV+YAzI9SOwlJeN9YvsCDehXGYki62aLhcqvDhchmNTzL9cPHLI358O0hc6LItQX9KVZOlXGeNSE/MJoxnaLy+xs4gqaDkq/yUs1Ji09IP2hsxy4XXLV08aW7ty1SwIY6jQBTDj1lSZEjS0Ojgyf6XMlsRZHD51wVAOI7t1rCk54LVnTWGtq8zLRa4sXrvNqgETO0Ai5GO09I5y6uyJSYAF8k/cucfCh3q/PG1ngvQCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaQxipK9C6EvDpo2509CPeR36yjC97SZVwUwzFW2x6M=;
 b=W3E/DN2JVukBLq74/qOyZd9broBW22oKJzkRbGFCKwsiTCfSTtv1sgXZwRcV+QTZLRVatUBEjwKiTL5I7QpqctqmMk3PoeAEDlE9Hh3TodInAiQtyvYP2UiyqNvwlUKm5kXD9Kvm4//2m1mpi58GHDUsspXzARaLT1mQhjYVv2Rth7NeNJliMfxjuPyCYrt5dL4WAk1ycPjk1T/akTMQNuAFd43nWFHz0iQwDM+HUw+fZP5Zuz2gQBOEGKP3ayO1nbN6AK00xdlYXiXxM2mUy1wTcpDOk4XCYUL7+UeVena/4/6AeMM8b4nXseKMHzEl56TilkwigPAWu0aAwJr90A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB6545.namprd11.prod.outlook.com (2603:10b6:510:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:27:00 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 13:27:00 +0000
Date: Mon, 4 May 2026 15:26:51 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joshua Hay
	<joshua.a.hay@intel.com>, Willem de Bruijn <willemb@google.com>, "Alice
 Michael" <alice.michael@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH iwl-net] idpf: fix RSS LUT memcpy size
Message-ID: <afiem5uwBus61bLb@soc-5CG4396X81.clients.intel.com>
References: <20260429074232.180528-1-larysa.zaremba@intel.com>
 <dfa0c54b-393a-4671-8531-13cb454b872e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dfa0c54b-393a-4671-8531-13cb454b872e@intel.com>
X-ClientProxiedBy: VI1PR0102CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::25) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e8e7f8-74fa-45f7-fdba-08dea9e0d200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2WM5TNAZvDzphJg9vT6EJf6eTdKIFO377RTjHk2klUt1aklSxa6og8Qgo3TEv6BTb/MA3sAzpHe7LkIVjqOJ/JkANvjKSM+hwehN7N34QQPMbB6TuZcB/X81l3THai3WB/HdCwnIDF/T/0fo5lcbJG57ELwH8MMcM3cty8MSKtDRx3b/90tT5fNKbbgzCIrh6VjzBvxbm04zr7YJ+tp153e65gLWSfM43hO9d8qclvQx/QMJMGfdaKZcHIl8sV+F6luJAVoEaD3sPGo75qcstvQhQ9fBf+OweXV1P9Kxhcy2YLRFghsBE0IDwA06cpScxu4eBjigk2N+SF2yC2mShJ6pHelUxDIw1q/jqaA3FH5oJHZq34uSrld1utk9Cty8Gu9m80AEFm+1jZeC5l0QwuAHFZU7z6bRU1TWgTTh0e2f9FKB5RBssnGoeLROf1R06WhrHlp6c3gBVGru03SzzNvFDyHOMJB08vhBp5MhFXJPnF+08DL2mu0qtQKN9OsxIG7eep03cZt2E7KCbkPuIlsSugH+W1o195IqJqgglgeuJeyJluHXYb12NvhnfSc+UXO0n+jLalG8b9WADcOi1uImYqODDQszuhg+ME/6MlyRWUY8KwoKroNcp6Vurb0VSfnv5qP7A7499LGEiQ/VCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qhL9iR2gbzY6VW5LdtpWqzwcNoWkHpZStOVxWzhcFU7/Y/ua3k4z4UgjjZGn?=
 =?us-ascii?Q?V9ioRH1cBGB9v8tm1b/Ea9qMDfRg5WGB+GVksY2H6XETBvC0y+3s8lU1is6+?=
 =?us-ascii?Q?3NdO9YWCG3gAsg/hhs7WyA2291MOl/YdMWqNJjpJq4hmmcQZr+ZgLr7hnwVF?=
 =?us-ascii?Q?HFifNnAo8FcKQJbqHHyFsCSzNhdHinsX7xhMY/VYrlzDKOwF6sD8QEzqkzV5?=
 =?us-ascii?Q?+EvmyrLKMEYnjvGoExNoVFKLINZMFNsqCIU1KS3FGLjXPX3x8kSgKVyIssPn?=
 =?us-ascii?Q?qGi19GnKjDnkqSnRyk4PoE4xFPAgu4WAd8+NfxKMr/A0F6OEIio+ehU8pj4N?=
 =?us-ascii?Q?4uEdfgoIgeO9WFuw3IFSQAn7KR2MCTOG5i8tlmJ0INTDzsSGf5sFUGzgX/ML?=
 =?us-ascii?Q?aIGR3PA7pUtSWmCVC9aKdjyA0fbcygP6/9KWgJDHhe4mcsJWXq8nFaVLM4s7?=
 =?us-ascii?Q?cc06tn4hQIdR26eTD2ZKJHf9Bsmu4Ud8NPCpxSuIf9MQm+CLAIB4BK/0UqpH?=
 =?us-ascii?Q?vAKncbNq+0M8bG79Lgh9rIg8L+ippVNUtmyyccehSBa6eE3oPQIx5sgw8JAE?=
 =?us-ascii?Q?D+HJhPNm1FApduoD6FKDeKSZbclXgF5eGftnT/eU0JUkFDvDfbpcdHLXQ86R?=
 =?us-ascii?Q?OgumSQThWfZl5edTFaxEEa1GHm9EvHsa1NydGmOBmyeJPJXZMGOMy9Dv/wTN?=
 =?us-ascii?Q?EbhogQvI+Q45ILWLd2eJ15EM9AZFMqx8OdgCnwBN274QjNfiWqVoDb4ADskz?=
 =?us-ascii?Q?gsUc8ERN612uk1lrmgPszrBI/dFTJcOElCvf3v/tY1KO1KB5BeBWs5gc4n+M?=
 =?us-ascii?Q?BiSsluFg9eslac3kS/kp30z6pdbHuRZqvEvEcPtDu5Po9RSYRUb69tbRZM7z?=
 =?us-ascii?Q?Up6+lQl8Pz2/CstAnxg6tPiVQRgZ0m0j49spSEjIJstkuxjnop72silVa7Ye?=
 =?us-ascii?Q?oT7uq+1Jpw2WFlAZKT7Puam28tNGGAQvznlqh75KjHYJRQ/eeLNrXSbSbYml?=
 =?us-ascii?Q?WIPgoP/m014PVL5CIES7bKb0YG7CN1+u8eP5qyPFCIr2g8bzhjewEAotXTn7?=
 =?us-ascii?Q?4ULMzzwpSbTt4FNCaPI5tWGYXmW8gGedQlniK1pGmGHVRFEbbpHkJ3BhgFEu?=
 =?us-ascii?Q?zxcVZD9sV3LFtNjh+/tRLXPdobg37u5EGf01zSJP3wH8EbgJfo1nSSFvNfJC?=
 =?us-ascii?Q?BLVWYRaGZveKS1ydD5fm3+/K8bx+KpPhYpPhAAxpExc9S9CdkAonL1CXKmq1?=
 =?us-ascii?Q?9PuqQCSIgDOwJcbjexXNUXrNHDKM3t56HBjhMgwkXtHSwJAXosKlp9LV6lCH?=
 =?us-ascii?Q?f6TSY85VIHQndsMLbL7KCHG8jKpK+KMDKXcsPBZepy1haGsvMZPXEvm4p3/8?=
 =?us-ascii?Q?O8rxA+dmb0hETvmErb3jOR1dUAiG4PbpHtDBJQ+cc+75ZijXnRqztkuz1C1G?=
 =?us-ascii?Q?Ofvv9HmZxl32noSJIqKauqI7wgLjKlEehH+5NJXChG89emcJGX/EL/ZVh+pD?=
 =?us-ascii?Q?Mv43JmkmZRI7/Ps1v8Ed2F06CiqW2aqbJEBgsG6EH6fikPWelmNj+OdXWkH4?=
 =?us-ascii?Q?Kl8EdNlIPBC9fB+ITfWC1m3JZ8Ea0isILeyCWXEdD8S3BgoxECNFKMkKducd?=
 =?us-ascii?Q?g1vP9FL8DOrLxWJ5f2pb4W4BN4FZNwAgL5CcCqpSQ4bnWCzf3sV+LQyCDh5e?=
 =?us-ascii?Q?PPjdH8rfwx6PHjWCqMckkhbROwtrRjgkSLKq8i+WoFwqi67o8zogv3s+ZJNq?=
 =?us-ascii?Q?GqYBIr+VgPlYRpxypmFjjAE91AguqbxhMfma0+I4W/n4vop5S9cOgztp/Obl?=
X-MS-Exchange-AntiSpam-MessageData-1: e2vVYTqgDuQ39YJABHVnDo0nt+KgYiI4aN8=
X-Exchange-RoutingPolicyChecked: QhQvcn1vQ37i/vtpZggQFIqHkC2Zf7c4VD93fpYjrXrurbzOUau76d1RrLOVIxXWsmCYjlWnFfKMDg4G0y9pH9goR72Va8QUF5PZnl77mGhahaolilKQgoKTQGRDFOfQVVHHPcpjsXDwTGd989cpeQgYohFg+Qo7YqPXU9gQv/vHvrkM7MrxgRG3I4RyBgppIoH8BN5BM7AHkMfzNzVhLwXmObSgUtBKFUagzK6WhwTFhoBWWzN0PjFRTuC0aUVNlqPxI0s2CmqZztLE4Q9rgoH7UQokgW/1mGjfTOf8AnLZMNqdKAcIpTkVcHf8wxlhutPVPBeRMMQlEOrfrPf+mg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e8e7f8-74fa-45f7-fdba-08dea9e0d200
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:26:59.8698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLDnVzPmGo63QiB2q5uDqwFfIolxNPULWTEjc5kz/sNjSbcwXzoyAAEade/UwG3zrSthPhyIh2pUsTG5AyTb+M76UNjAlH2nkpwrJVM4QdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6545
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 4A3F84BDE82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283849-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,soc-5CG4396X81.clients.intel.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On Thu, Apr 30, 2026 at 09:38:44AM -0700, Jacob Keller wrote:
> On 4/29/2026 12:42 AM, Larysa Zaremba wrote:
> > Based on the following feedback from Sashiko (received for iXD phase 1
> > patchset, but valid for the net tree):
> > 
> >  "Is the bounds check xn_params.recv_mem.iov_len < lut_buf_size sufficient?
> >   Since lut_buf_size only represents the size of the array elements, should
> >   this check instead verify that the payload is at least
> >   sizeof(struct virtchnl2_rss_lut) + lut_buf_size?
> > 
> >   [...]
> > 
> >   Does memcpy copy the correct amount of data here? rss_lut_size stores the
> >   number of 32-bit entries, not the size in bytes. Should it use
> >   lut_buf_size or rss_data->rss_lut_size * sizeof(u32) instead?"
> > 
> > After inspecting the code, it was concluded that RSS memcpy size is in fact
> > 4 times smaller than it has to be, since a single array entry in a u32, and
> > rss_data->rss_lut_size is clearly used as an array size. Required Rx buffer
> > size is also too small, but this is a common issue in the idpf code.
> > 
> > Use a full buffer size (lut_buf_size) instead of the array length
> > (rss_data->rss_lut_size) when doing memcpy of RSS lookup table.
> > While at it, increase required Rx buffer size to a whole flex-array
> > containing structure instead of just the array.
> > 
> > Link: https://sashiko.dev/#/patchset/20260323174052.5355-1-larysa.zaremba%40intel.com?part=8
> > Fixes: 95af467d9a4e ("idpf: configure resources for RX queues")
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > index be66f9b2e101..a97d2e9b54d4 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > @@ -2916,7 +2916,7 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
> >  		return -EIO;
> >  
> >  	lut_buf_size = le16_to_cpu(recv_rl->lut_entries) * sizeof(u32);
> > -	if (reply_sz < lut_buf_size)
> > +	if (reply_sz < lut_buf_size + sizeof(struct virtchnl2_rss_lut))
> 
> This feels like it should be using struct_size or flex_array_size...
> 

struct_size() does not really fit here, as lut_buf_size is needed later for 
flex-array-only memcpy, but flex_array_size() I can use.

> >  		return -EIO;
> >  
> >  	/* size didn't change, we can reuse existing lut buf */
> > @@ -2933,7 +2933,7 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
> >  	}
> >  
> >  do_memcpy:
> > -	memcpy(rss_data->rss_lut, recv_rl->lut, rss_data->rss_lut_size);
> > +	memcpy(rss_data->rss_lut, recv_rl->lut, lut_buf_size);
> >  
> >  	return 0;
> >  }
> 

