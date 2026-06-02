Return-Path: <netdev+bounces-294143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJEQAU6xHmr7JAAAu9opvQ
	(envelope-from <netdev+bounces-294143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:32:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B27062C9DF
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74CF33027DB6
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 10:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA753D5670;
	Tue,  2 Jun 2026 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQ4c62C1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA436F8F0
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396345; cv=fail; b=dxDz8g6FwBDCfYQ8FMqCOMc+Z4QQJievBfmPageF4HRQJjrN5+f71bnj05gn0RtuSw0TH6lLTan1fEhizsdPi56jWhmreqLlKbao+DjjMxiMmQ0dihEVH0ai0K5Eszv5ejEkyTVfiUfCEwPyJZzVuWDaSKAmygiNRRzVLb72XDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396345; c=relaxed/simple;
	bh=dctboe37gp4qv3cIwEQ5c+T/qNFLQJsDcE7pviPusVE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XZbNveNEq6Z99ZDo2u5pZpumx5d2il9UTeOH+WKanEyJJV9btnmQWXLqfOBEg26nKVWllmOh8hnbCl/ZsgJg2JHkjrjxU1Cp2Ws2gUCWCOwjk2S0LThWpoSPWd6iuHQHZshx7MMafLdAFE0tq9riFF84TgCXBdsb1pudRxAf1FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQ4c62C1; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780396343; x=1811932343;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dctboe37gp4qv3cIwEQ5c+T/qNFLQJsDcE7pviPusVE=;
  b=iQ4c62C1g1xyPUCzQmP8BBvxguQWgA7QIo8G8oqmmxxTRUTPvtxPBnju
   t0NjG3zZlQrj1vHeVBoSUQSUXzrlammU4hL+KRyzpE8UIpEjSwR/qc2So
   Ye+JsJwZN0ydu9jcWFb3I8pElTxrj3QzRlMLRs3zDnOnStwajGJn6lydJ
   DGHPlzOZuhIl9wdBYlxy0mzz7qvyTOgyGBAmz881qqk7mb/BctkdKds8r
   ILf+jngzo6I0L32Xhg6MyZLIHPH7zYqmxeEz9UqVWIAHRYqCyibtRem8H
   4hFrMNXaXaldA8Nr8chSFCdrCMpzd+8iyPo/HK5o93Nn/5tf/Iq3wceDD
   A==;
X-CSE-ConnectionGUID: R4Tjh19tQjqkVWCsU+juBQ==
X-CSE-MsgGUID: vrqcs3RQRRGAggOp7qiSdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="91485060"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="91485060"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:32:23 -0700
X-CSE-ConnectionGUID: 9FFCVU4nQ+qb9ieZp81IPw==
X-CSE-MsgGUID: QbBLH4wyR1SCqH5bLP1XbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="239703005"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:32:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 03:32:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 03:32:21 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 03:32:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wySftgiWmBrMdZG3fBi6MEAXmYcl8GKjCy3exYzb8HNd0ddY7xMThwxaG+iBDf2Oy15B0qNJU8JVctNHsYyZVexYdsI1rQ7zIGFIuL4BiOB32+uMVmo1WermZAibo0SaQqJyoGZVnmiEj5XmgJoUNI6PurJYTfcOumc7kf8yt991n/OArF6HgCxbGYviF4KbYhmnIDtRjBhABZ6zG1Ey7JGAovA7tZUF0f2SWvCkCWtzI2vbyZayJjO+4tRvwtG5JBCX1IoNifD55EmBCgv++aCk+L8fw3XyO8fXL4uTfZDuJ8brSJFs3fEFN5iusD40YTeabL+Yyr/xpLmCD1kuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1h3S1bWov5DQ4PVBGOaFARdYo8czyw29Agy7vC17OU=;
 b=eOy27PTdx6Vj+qJRzljMoD47rJl5bog/+qwfyqUOtXk7ATtjmNNPotubTov+NMEA1nLnJQCimuI7Phr8SFQ9JRmMQEIcbG8iU2lPAxEhjQyuaWbw8K+aktTOhf4SraKoAYn5w+9ePdCFEolh2kTE884v4ahf2nxb5QzA6AMnvgj/yIB2kFeib4aIxtH7wQ4f5gkRnAz7yOuOD8L96RnoZjplpYWba6pVReAJqMmAYrnUprPxyyAJ+rtEWyrn+ifWWx9kKMUREXQ4RHqtikmlpOa9d3Y/09qeneTP3UFIm2IFbHYHaXJW+RZSX6I5GldNZ1gZm4ScEm2iyeoXcQ9Bsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB8082.namprd11.prod.outlook.com (2603:10b6:8:157::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 10:32:19 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 10:32:18 +0000
Date: Tue, 2 Jun 2026 12:32:06 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <netdev@vger.kernel.org>, Mengyuan Lou <mengyuanlou@net-swift.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>, Jacob
 Keller <jacob.e.keller@intel.com>, "Michal Swiatkowski"
	<michal.swiatkowski@linux.intel.com>, Simon Horman <horms@kernel.org>, Kees
 Cook <kees@kernel.org>, Ingo Molnar <mingo@kernel.org>, Joe Damato
	<joe@dama.to>, Breno Leitao <leitao@debian.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Uwe
 =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Johannes Berg <johannes@sipsolutions.net>,
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH net-next v4 2/5] net: wangxun: add Tx timeout process
Message-ID: <ah6xJgZjplSbVKvl@soc-5CG4396X81.clients.intel.com>
References: <20260601072221.2952-1-jiawenwu@trustnetic.com>
 <20260601072221.2952-3-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601072221.2952-3-jiawenwu@trustnetic.com>
X-ClientProxiedBy: VI1PR07CA0127.eurprd07.prod.outlook.com
 (2603:10a6:802:16::14) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bccfef2-3fc5-46cf-6c7d-08dec09238ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|22082099003|18002099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: AaOkbTt4zlcMwQ1qTkUDrBAcfh7pL4nIHQo251mPv3xZD0lEgDLs6el8jMI/HOlTOlXSMssPnSB8W0A63xGQNYZFi8RAs5zjf/kAwHAaDsFD+pkzGdu2q/Yr7JsmCj2nVcNcTDNItK0d8oIg+Mp7GJZwyI1lOhec6SMvVkXk83NcHRgClew6F5y8T3GEHFsms5w9nGO+x9EM1n+kMl/DOD85ntGDHWJdOLsR5W0ly+dqbi7bGVIXXbNxTC4kB5uya/73k5FYx71Y1+KLd02WkiGdY+eDdachTL3wMcmDqNWUqrGRSYZ1HYJe0BadVD8prAl9pTpuEHh1VN51CyJ9WIw+K9vx6iNL3xm6kUUREoQ6aCvlSSkXw0Tro7ej/PIqTzLtcYW/IPMJC1q1EiO7XRQqV/BYJtfarb/okxp/xVzkRC+5Cv89qqQLBClU3nTT1Ggg5ClFPFw7tuQ3MLVgETRwCiuSZrRvSjWDv6KgDUg183WXOySnOGC25Ghc9qPCIP0T0lsjSM6b3YvjKpYBr0DaP9pPJiHckszxu8pvLSD82iD4W4UTbA7aU0qJtsYTOYVX8amVZeV78hIZhYIlsAeZfWd25FRsa4DyRAN6ddrdxKgLj4TXQnIRInJVmxJsPAm0/hVG2iJli3ZrvnHtgNBfAr1xVVysRLu/eWgRLTnQeLoylVBDbDX5N2qfgKFM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LjoHpMqTLcj7T5WDD1AeXZvqOG4+DO6Xs8cIo8FNtkDdaiwAxRxdySJP1MUV?=
 =?us-ascii?Q?QufxqbHfggvlZiNumExFYTiY6pAIwG053RHxYpu5IZWjkooi9WUPVfZslmJI?=
 =?us-ascii?Q?/qHiQpFRtHAllJCrkvikcagfOeTd12qS37ImK9VZr41HlPo0Nc95CTtp6I5W?=
 =?us-ascii?Q?ING1e2/eiy7ZScNUp5505UT/2ow00LxrcN9PkWTfNF16DO0wn89bRfHhGylu?=
 =?us-ascii?Q?Y4sC0rmri7eDM1Yt+xwEAmz7Wr7NHiKqYCguaELclzL6VdU1uV1MjZ/rP7pu?=
 =?us-ascii?Q?2iOTy8lUGxxkVXdoqfuOBJw7zHCOO/AhC3DENxecMziGrobDQYAMR0K49e7l?=
 =?us-ascii?Q?WwVo5GUpkVvae/cn8k2uD0hzJdlrpe8cflPaLpYzn1z3zvxoRBbN4qPxeCOZ?=
 =?us-ascii?Q?AuVqdQrOD1qFkLoe+z57e71PSjzGjLhfo5uf0NX4SF/pvx0xpFwdezBykscg?=
 =?us-ascii?Q?CkPvMZNkJMJK2MTr6CUqoj/BM/3SJlZ3p3uqYj1rpjkIt3qTboOPOO1H09k0?=
 =?us-ascii?Q?IolvAgGejE9YWTqrzkfwufZNSH2Rurypo4O0/SUEoinmvBELdUKNR+HWUAVj?=
 =?us-ascii?Q?vrPHM0nnlHMMFgRjV3L9/CzPPF76cluu3bqnjU20+hER2yOyi/it4zvfe7lB?=
 =?us-ascii?Q?Yz9/tNF532vjh4EGwE2D5R2ME+TlyAZe3ZIH2GtX9ehPvIybbpJwpm1P97Jr?=
 =?us-ascii?Q?ppYYA6/K9SigYIXgm56J74fb03/iwBwrg+NYzx2iM7ZygIwCdiFNHd7w48+0?=
 =?us-ascii?Q?Dk3fN2NVCm9hIq1x9KidTYLxxmfT6uAXjGbFuD9aRuqgHnlKpHJ5oQoAh1Yu?=
 =?us-ascii?Q?Fqn7lk7RWgiYB9XfL5zx42AD/a4A0oA6eHyBPwBumEQVhq3r5PUJ3i5nzmYt?=
 =?us-ascii?Q?WhHusf73zqkX1akTdJoy0YCole5s8bKYNF2KMfZMAkF3VagJ5doN3Cbac/6L?=
 =?us-ascii?Q?ijQ7YYqmUMrsNnUIeNnK8FuRYMtTHPAX0PVXpvN1UddJJQpGrihHIRYC6UX6?=
 =?us-ascii?Q?eCoBzpBdl/wuwGBNgFH0AVI74Jd6VL5TK+vEmIlzknvqJ3Ekv9Jn5RhZFVj0?=
 =?us-ascii?Q?U3VD8A8TL9gDbYbWsaBO6lplTrPjv5Qa1xhpoyJUrfcJqfsw73t9ZrQYpat6?=
 =?us-ascii?Q?a/Yn3RIeBeGQhhSgRSNqr+J2GA1ntLJrt9GZx7xUHAeWxvjsRAiZi5d+vHn4?=
 =?us-ascii?Q?jKZaDqNlBkfdVCb2CHiaGx2e5tKZoijMSWSgbQGGdkO65xe3zY3IZEOZqGYV?=
 =?us-ascii?Q?2KTJzFIooXl0bBZtlLHISedV+yVn50JU+bvEOwYQ8xkn9ePfgkWW8t4gXNFm?=
 =?us-ascii?Q?VqM+F+33Dt8P+g2D+YONHtVKQiOoBaAzb5cq/ATpb0sqoDMZ+fEw9dl0ZIje?=
 =?us-ascii?Q?kL97x7bx8n2M88FnrqKq2crEVNJhVBOjs/X+GMe44Nl3xLRojM50XEah8KvY?=
 =?us-ascii?Q?or7JnGQmBOFPidlqSo+w6l2ZCdiQzQNR1y9hrI4EorZSn06auGOY+99XbgQC?=
 =?us-ascii?Q?POrh4Qn4SYIAirYaF4SuvLHaIiy13JLx7IvTd8vfA72+inw8Ve8ueXjUD1P1?=
 =?us-ascii?Q?U5M6HuMGcZz37Umz6Ot3uHEL0ylqdJl5ZQpbVWRi/xjuCRyHvFGLgmYqc8/E?=
 =?us-ascii?Q?tCqSK6gKYX6mo0J4CkG80X54mujeez3L57lKEoJFYK5MrMbRtUcQxWb6stEj?=
 =?us-ascii?Q?TircTgdyjrGaoVXy7FRJJjpC0hR39K/Sy49/HajP2uQGNCyZvB8Swu4DH3oY?=
 =?us-ascii?Q?sT5YORA/oNsuHnVCn53dBAv/wRKliuS57PcoahBwjUW5IBfLyo+RMclDFY4k?=
X-MS-Exchange-AntiSpam-MessageData-1: d952gjThtTiVE3u0c6kYHvNaIiZ3Va+PZko=
X-Exchange-RoutingPolicyChecked: We2R/lqR88kSwYg1OW468oAg/LSFN3C1AY+b/g4WSlQpUBa2NQEUiP/W7ahu7c16usWY3CTLEnenepD6mhK8Bb91QiJTJ78sERypg8viO94tEFyrqWqxgSXOrmRk0111K7UsHRA7UOoDrPBPHOChWWF2IYTtxcyfm6Jc3nAxVtvJA5NcyrlEBXmHqAlQk9vSoRG18zmOWreS8SfwkO6oYZxGDvYTScyur/9CuPq7Kw65c0Rr4YAVwhexeay2fVxXxh5ylM0BBureSVUeBuQRrObDwrX++j/gSzp+Wahl8Grr+MLRqIiI41gjvy87MpFMMxC+nkh7WbYPa1EWbihF+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bccfef2-3fc5-46cf-6c7d-08dec09238ca
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:32:18.7001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqHVWtpZqu/HkBYigb8kOq34BSxmAFi/CVmxQWsUbBwIoLul2C9wVTp1NFMCLhgyqrGgvtMx3lmXdu+CFdrZfEqdwop0h4fo4XFAykaulys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8082
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 8B27062C9DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-294143-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,sipsolutions.net];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,trustnetic.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Mon, Jun 01, 2026 at 03:22:18PM +0800, Jiawen Wu wrote:
> Implement .ndo_tx_timeout to handle Tx side timeout event. When a Tx
> timeout event occur, it will trigger driver into reset process.
> 
> The WX_HANG_CHECK_ARMED bit is set to indicate a potential hang. It will
> be cleared if a pause frame is received to avoid false hang detection
> caused by pause frames.

In general, logic seems sound, below 1 small nit.
There is also a seemingly sensible comment from Sashiko (pasted below), which I 
agree with. If you not schedule NAPI every time to check for hang, then without 
Rx you are relying on dev_watchdog anyway, so maybe internal hang detection is 
not that necessary?

> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
>  drivers/net/ethernet/wangxun/libwx/wx_err.c   | 170 ++++++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_err.h   |  16 ++
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  37 ++++
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  19 +-
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  14 ++
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  14 ++
>  8 files changed, 284 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
>  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
> index a71b0ad77de3..c8724bb129aa 100644
> --- a/drivers/net/ethernet/wangxun/libwx/Makefile
> +++ b/drivers/net/ethernet/wangxun/libwx/Makefile
> @@ -4,5 +4,5 @@
>  
>  obj-$(CONFIG_LIBWX) += libwx.o
>  
> -libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o
> +libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o wx_err.o
>  libwx-objs += wx_vf.o wx_vf_lib.o wx_vf_common.o
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> new file mode 100644
> index 000000000000..982a438d009e
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2015 - 2026 Beijing WangXun Technology Co., Ltd. */
> +/* Copyright (c) 1999 - 2026 Intel Corporation. */
> +
> +#include <linux/netdevice.h>
> +#include <linux/pci.h>
> +
> +#include "wx_type.h"
> +#include "wx_lib.h"
> +#include "wx_err.h"
> +
> +static void wx_pf_reset_subtask(struct wx *wx)
> +{
> +	if (!test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
> +		return;
> +
> +	wx_warn(wx, "Reset adapter.\n");
> +	if (wx->do_reset)
> +		wx->do_reset(wx->netdev);
> +}
> +
> +static void wx_reset_task(struct work_struct *work)
> +{
> +	struct wx *wx = container_of(work, struct wx, reset_task);
> +
> +	rtnl_lock();
> +
> +	if (test_bit(WX_STATE_DOWN, wx->state) ||
> +	    test_bit(WX_STATE_RESETTING, wx->state))
> +		goto out;
> +
> +	wx_pf_reset_subtask(wx);
> +
> +out:
> +	rtnl_unlock();
> +}
> +
> +void wx_check_err_subtask(struct wx *wx)
> +{
> +	if (test_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
> +		queue_work(wx->reset_wq, &wx->reset_task);
> +}
> +EXPORT_SYMBOL(wx_check_err_subtask);
> +
> +int wx_init_err_task(struct wx *wx)
> +{
> +	wx->reset_wq = alloc_workqueue("wx_reset_wq", WQ_UNBOUND | WQ_HIGHPRI, 1);
> +	if (!wx->reset_wq) {
> +		pr_err("Failed to create wx_reset_wq workqueue\n");

This driver does not generally use pr_err().

> +		return -ENOMEM;
> +	}
> +
> +	INIT_WORK(&wx->reset_task, wx_reset_task);
> +	return 0;
> +}
> +EXPORT_SYMBOL(wx_init_err_task);
> +
> +static bool wx_ring_tx_pending(struct wx *wx)
> +{
> +	int i;
> +
> +	for (i = 0; i < wx->num_tx_queues; i++) {
> +		struct wx_ring *tx_ring = wx->tx_ring[i];
> +
> +		if (tx_ring->next_to_use != tx_ring->next_to_clean)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool wx_vf_tx_pending(struct wx *wx)
> +{
> +	struct wx_ring_feature *vmdq = &wx->ring_feature[RING_F_VMDQ];
> +	u32 q_per_pool = __ALIGN_MASK(1, ~vmdq->mask);
> +	u32 i, j;
> +
> +	if (!wx->num_vfs)
> +		return false;
> +
> +	for (i = 0; i < wx->num_vfs; i++) {
> +		for (j = 0; j < q_per_pool; j++) {
> +			u32 h, t;
> +
> +			h = rd32(wx, WX_PX_TR_RP_PV(q_per_pool, i, j));
> +			t = rd32(wx, WX_PX_TR_WP_PV(q_per_pool, i, j));
> +
> +			if (h != t)
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static void wx_watchdog_flush_tx(struct wx *wx)
> +{
> +	if (!netif_running(wx->netdev))
> +		return;
> +	if (netif_carrier_ok(wx->netdev))
> +		return;
> +
> +	if (wx_ring_tx_pending(wx) || wx_vf_tx_pending(wx)) {
> +		/* We've lost link, so the controller stops DMA,
> +		 * but we've got queued Tx work that's never going
> +		 * to get done, so reset controller to flush Tx.
> +		 * (Do the reset outside of interrupt context).
> +		 */
> +		wx_warn(wx, "initiating reset due to lost link with pending Tx work\n");
> +		set_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> +	}
> +}
> +
> +static void wx_check_tx_hang(struct wx *wx)
> +{
> +	int i;
> +
> +	/* If we're down or resetting, just bail */
> +	if (!netif_running(wx->netdev) ||
> +	    test_bit(WX_STATE_RESETTING, wx->state))
> +		return;
> +
> +	/* Force detection of hung controller */
> +	if (netif_carrier_ok(wx->netdev)) {
> +		for (i = 0; i < wx->num_tx_queues; i++)
> +			set_bit(WX_TX_DETECT_HANG, wx->tx_ring[i]->state);

Sashiko says:

If a software interrupt is not triggered, wouldn't the evaluation of this
flag in wx_clean_tx_irq() fail to run unless incoming Rx traffic happens
to arrive on the same interrupt vector?

> +	}
> +}
> +
> +void wx_check_tx_hang_subtask(struct wx *wx)
> +{
> +	wx_watchdog_flush_tx(wx);
> +	wx_check_tx_hang(wx);
> +}
> +EXPORT_SYMBOL(wx_check_tx_hang_subtask);
> +
> +static void wx_tx_timeout_reset(struct wx *wx)
> +{
> +	if (test_bit(WX_STATE_DOWN, wx->state))
> +		return;
> +
> +	set_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> +	wx_warn(wx, "initiating reset due to tx timeout\n");
> +	wx_service_event_schedule(wx);
> +}
> +
> +void wx_tx_timeout(struct net_device *netdev, unsigned int __always_unused txqueue)
> +{
> +	struct wx *wx = netdev_priv(netdev);
> +
> +	wx_tx_timeout_reset(wx);
> +}
> +EXPORT_SYMBOL(wx_tx_timeout);
> +
> +void wx_handle_tx_hang(struct wx_ring *tx_ring, unsigned int next)
> +{
> +	struct wx *wx = netdev_priv(tx_ring->netdev);
> +
> +	wx_warn(wx,
> +		"Detected Tx Unit Hang: Queue %d, TDH %x, TDT %x, ntu %x, ntc %x, ntc.time_stamp %lx, jiffies %lx\n",
> +		tx_ring->queue_index,
> +		rd32(wx, WX_PX_TR_RP(tx_ring->reg_idx)),
> +		rd32(wx, WX_PX_TR_WP(tx_ring->reg_idx)),
> +		tx_ring->next_to_use, next,
> +		tx_ring->tx_buffer_info[next].time_stamp, jiffies);
> +
> +	netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
> +
> +	wx_tx_timeout_reset(wx);
> +}

[...]

