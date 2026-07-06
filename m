Return-Path: <netdev+bounces-304979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XkXaL5OTS2pTVwEAu9opvQ
	(envelope-from <netdev+bounces-304979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:37:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B88370FF2E
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:37:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Z5dYJjyL;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304979-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304979-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B2E430285ED
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 11:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7223A6F1A;
	Mon,  6 Jul 2026 11:05:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B9C34BA33;
	Mon,  6 Jul 2026 11:05:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335911; cv=fail; b=JYg5Qx0rxR/JQQstgNPlsMLgPH2fcEgd8CkJn+uuqbaJhsO6veg+Jsf8vVWmXMu+F84oOdiyCjhAhBkSQSV1X2ovEqXeNnUBuDYxqWEYzpjHNBF66j/bs460npsnUwHjEXOao8fJKcasLePcSx8ThpJ/7wBEbgLfhKOTitrsoAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335911; c=relaxed/simple;
	bh=Vea9aKfgtIdJDBHoVJ0/hbV60MhqfMyd5usDnLAHHIQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hgj/fSMF3ptZq4tI1iU9VHyNQQwNPYZR+cueAIQR5fiP0l5+0JvB9QM8vRzgmkL5NFTmROx3zRFLPcBe6ZC6WsT7uY/LZyLw1IGiKte8HGIfw+iDJvb1zcIM2wB95gMtpHx4Y/3V4/qtTSqcTDxKd5424gUIONQtqycmC30ahjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5dYJjyL; arc=fail smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783335909; x=1814871909;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Vea9aKfgtIdJDBHoVJ0/hbV60MhqfMyd5usDnLAHHIQ=;
  b=Z5dYJjyL5c8Ea41PAQwLysHh66D0NvZgJi9L1XKKBdseTpZl+6wTceEg
   Bvzb3c0CNnf2G8gJ60ECsJW6UnKgstm7/kuDrdktbevShk54ERvUAX+N/
   5uTaxz4VZugVky20lhaa7Ar+D73mr/VBbJ+ahV6tZ/wPoehJIEirJt3kE
   OtY4bx8IjOAVNDawXuCdTpyf43OBhb6ShYi70PJ+bmy+d4/cOk9BUPOTT
   i3SfkFyrmCXkzR/XVr/LDls73jCFoRfzL3jUnhASgLfuYB9Vdg/bCeRf5
   KKr5nU/gFKgYHdckUNSccDtJ1ZZm0ooVAKZbY2qrfNjyvKuYqhtfT+UdU
   g==;
X-CSE-ConnectionGUID: KdmAb7FVScWc+Pz111eYLg==
X-CSE-MsgGUID: AR9VCrAVTf+258IoA9dzhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83739899"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83739899"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 04:05:08 -0700
X-CSE-ConnectionGUID: yOUggHXiSailNPkufWL9Sg==
X-CSE-MsgGUID: jqLHyJ0iT7CMsdmgQ+XQUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="251940539"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 04:05:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 04:05:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 04:05:08 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 04:05:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcJyGyaeioZvYCkdUTG+52X5sVbPbfeCp5ah0LQYcY6E7o2Q1RRCI1FXWCmtipH35dI1v5QjEahq641swhRNKjw9pNzti+To/2mvwhHv46Fwh7KwO/3nsPhK3Js86SY8Lqd2iIrxCELXbYosuqveiBcCwISeGJ2QGwc7Glq/uuItJmpa6jTVcFwG+1vkR3VHGuAdXXP3bsS9nEnw4CuFIsH2bqlgGucjWtqLEWGpIHGJQyaWsyg/ftwbfgdZWxwqq9ld9hGcnPm83cieSlta/9tMhsqj4ECWrrJDUmOc013wKu5wMRV+LMq46yFCnrJXr58Y4lc/MKMuhSX1MJlL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epa0vJJidq0ww5QhtViOImDVlOSy+3BH6YJkYdTe8n4=;
 b=jtvkO64wJbD7Cx4ujoojvuSQA01mmdKc7gETvxrIbXZv1YPbPWOFoiGvrI2cghV7YT5N2iTIGcHyTrlqkGjQd8IK5B5uC6wD5a+g8LmcOxmtK8t/hnpsaPRsSB3yoxju1QTqrrN/YiiHJu1cfDCNT/5qsjZG8Ufb1omDWOMSGritpOut0hWKBbbT/1Qpps4fMGieHlRHziu68GhjP5kb9TOkt+zEE8mrOzzcYJR4rXAxjldqMXQUSfwJmQNwq71ad7BF+aC4EqukZ+9NQJNwX7LqxN7QW0U8EZ39+/mMBT4sKKCZE11swSJ977iTs/ci5BuT9W32V1YrzhqR6XSwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 SN7PR11MB6653.namprd11.prod.outlook.com (2603:10b6:806:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Mon, 6 Jul 2026
 11:04:57 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 11:04:57 +0000
Date: Mon, 6 Jul 2026 13:04:44 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Johan Alvarado <contact@c127.dev>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>,
	<alexandre.torgue@foss.st.com>, <Jose.Abreu@synopsys.com>, <pavel@ucw.cz>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: stmmac: raise TX completion interrupt at the
 end of an xmit burst
Message-ID: <akuLzI9GVGn4eI1j@boxer>
References: <0100019f35ea26e0-42ad009c-01ab-4a8f-b126-fa65fbacae5c-000000@email.amazonses.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0100019f35ea26e0-42ad009c-01ab-4a8f-b126-fa65fbacae5c-000000@email.amazonses.com>
X-ClientProxiedBy: WA2P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::8) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|SN7PR11MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 05151773-3593-44aa-d10c-08dedb4e6a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|3023799007|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: Gn5XcbMshqc6wZ8EMZUrprV9f3baRWPjn3GRcutxjp3UJi2B3zdLdmWv/rihZSRsMJprIFZlsSisv5LoWYey8IoSrL6ZzKMADGgbyquE1Y1fYpXcRiwv2v64v+Xo3qgJIQw1ZWjwUC3EVlj37XbRXBDNQAmOecyuLgHhGkJV2P5x0sI/ugC2/4ENdoQsgJpRhR0Mw1MoyKYJ0hAzZzCFlCrEClOwEgdpoJXS+sL3kgcNXNH33DpADSZX+5MqUUPmoHfgQLrtwiGEdJJkF/+vIpPGWIh+UMF6wmC96gXf+jTVuBNUcKdHOzvoeeINs19U3agLZzlF5s28VK2kbszVpBUF3C/fs8fr6I1SXhra+lIXU+v2QY6bd5VoqLTDovRcFUZPWOec1wxUalFmSd6rSUG2P9TjKzKgoBZnvMzmjnlnUq9/T626knhWCWbTl1xlmGT5tmZ3SOXxReAk5jziO2D8btgdDJuYCQ+Idt3eWxPYMYyMkZ6EOtq2dqHDC0dJRbUZVcqQwi8QX/Elw8JTaowx+EWyIJevVSng/2lrI5dLgulG38RqaXP4COM1gR8Dvgu6Qci1CdrtJ2bF7o6Ef0SA7PO71bvjeFgBOgTpH+raXpfajE0RqnS6CmavRn3A+86wtqVTFBdfrEvteje5U6K/OaitDJWCTWhnKymH100=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(3023799007)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VMTzLuLLjH+q3I8JErtMAR3Hc5UibQmKj88aRXlrM9mgdm9CqTI0z/Mk91jK?=
 =?us-ascii?Q?x4hIWKiHakid/vUf5w/tKgnVJxQ5NbSUO/GfvzHd494OcJMrLa+I+Wr1gb+3?=
 =?us-ascii?Q?D+1DCxn1n3YWU18X3JXJLIVSgkDOLSwsnscDCOmvM3NFkj/HVBqM87JPAFo2?=
 =?us-ascii?Q?krYUDWFrQhN6g0SQsfyNRYzjDvFn34vDgRYjIR1uZKN4p37Dc3KXsCFjw4y7?=
 =?us-ascii?Q?/1E+lNt8bB60mfBhAQJjapFpxGQgcddBMMTZsbRymTRwNrOgpi6o8kAb9HTD?=
 =?us-ascii?Q?qpd+/1et+4R7W+D8326heNH/8PjbDNBNXvQOrV9KBgbAzP4YNawTb2IxDR1v?=
 =?us-ascii?Q?wHKHfnYxrhuqF2b34pPUhQuuE1WvPAKypYi329iWM+SnKYYBCLTuHcFwMveL?=
 =?us-ascii?Q?by7uG+f+qVAFcoa1s8u7BqpvK+BNSOn1id2qzggWaJaAktoGt1FFRSXxobo3?=
 =?us-ascii?Q?hEof/Vy1znV1egOVW0s/1eSlytdWzZ4Kch+weEAcHljVGm0+tAodJG/kS+w4?=
 =?us-ascii?Q?fjhi0lrLTcXaChEpQb0lRDnOys5N9wWHqV5WlitP5GOC4Fth2u2cc0Quo+Gv?=
 =?us-ascii?Q?Y2gIsfWlN3N9wlfwsTPYw4K8+t7sTYiZseiGd0jGhjD1xP4smNlr36qf6fah?=
 =?us-ascii?Q?8mIIeyWjHzpX1MJWVvxluyrJrhuPkw5L6Ia1y7JqHHJU31Ht2DYsFLZVapS/?=
 =?us-ascii?Q?z8aj9Mt4fpiU0qI/WUcluOBq3338GplTcTvIyFnJUIgrIn6CLwxPJzTmdhVL?=
 =?us-ascii?Q?21OrLhVF+NJ824OcrsmejS8BIDubBCxT9jeOMZVboSEVF1sYdj81shRvzXVi?=
 =?us-ascii?Q?8GhyP3cXF7GIjCmEqAGqJh/fYaIliRminNI7nN+PTXuIBuos8BBu49zib4XD?=
 =?us-ascii?Q?8f/aqJY8FRTHZ4jse7zUM4rxiq2zqh3BynAcWM/znYSxK5yvrqKqVkgO0zIg?=
 =?us-ascii?Q?toxWXGTAMRi0YccuemKndWFJYGeDfiprYf/9WJGwFgw2vZANL0lY9V64tXy3?=
 =?us-ascii?Q?KSzy6Vh1/Vazk+H11AHYY/8yH/OVAYT0RLcb9gLUGf8tc7+m8RBv56HUKZOl?=
 =?us-ascii?Q?T5tabak8UphtTJgTroO++WdpCC0vQW7H/JDa9kQNzyEAAnQqZNmxxms6cEgK?=
 =?us-ascii?Q?A5UR9g+B8rdcHNTIzfu8HNph8HA9SDS5l+r2Ar8ZTDLBoNPKwVK4jZVRALA5?=
 =?us-ascii?Q?UlQ4IN+IftNfjF/J39kuF8DAWfasGmHTHVvtsfN6gkwCA7EZ1OI+xKrM/glm?=
 =?us-ascii?Q?k/8Q8oJlcHwpmCLmDVDNUogmYDeTzF+V+aJfptluZWBVeBSQqBa7FFB3ZRby?=
 =?us-ascii?Q?Nr5kfpwuBAaKb03xOv8GT8lq7Kq+3eXvOLrPZ2mkW2w6RC0n0AKdYS7P6LB8?=
 =?us-ascii?Q?ZSBTNdZTiSSResGWcMKxQC41jMLW7n5hy474XtV8tJgoa57uqYBNPJenP7v4?=
 =?us-ascii?Q?jaofqKP5U/4pARAHskTwJV50TfD+t4058kqU4DmlawztWRXsmFjxVd8WnLm4?=
 =?us-ascii?Q?rkE3hXxM9/hb/w9h3e1xkVtLIVg3VcRJj9jXxO59jYuTwCzXSrFzVtXVuzpr?=
 =?us-ascii?Q?Az5OGsUNZ/ylymSClHhQHEPK/Jqdc5kLZlMAbCJdSGm22G62gTLEP4lfVpvv?=
 =?us-ascii?Q?xE8M4KttJnpmH94ZaeYOon5q2UdXfvroEt1m5UsfmlTowII/jP1PmSPm1Nk+?=
 =?us-ascii?Q?4i7yI+sOobXGXQ5ACbkTZpdXFRfgSONJvq4aWcVk9i6Bwi9OgXuLOcG6rbnQ?=
 =?us-ascii?Q?TlYDkpMkAopE5IVfeUMr43boDjU/Apc=3D?=
X-Exchange-RoutingPolicyChecked: BMcXMh3QixlNGzlUUga9MP3jlwunFjkOUDvb8pr3AB1/kxFqZOf1+G1dhkgFASjogK97GDng5xM6PMTdLLGpI760EKXnZLY+GCbDklsQOZe1OJzQKtk93XgCQ3EfftzwtUJ0uxa5xuY86Md0sz+wCR5Px6ZrzQ66jw7kT7XLGbR+mqDv/62dbnIwfG/iuqwASNgNpXphS2KmGAmRctkL3HxzYYDFHIkwlRIeFBCD8EzszK4rAbzs26fGj9quZCdh9RF82rtpYbWo8jaOBtSIc+AqrEBxudhA3ZpzN9fa5/qMUn2oi5kUTXkcLJhOwM47cc5YPcIlWzb3VwarDiPqJA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 05151773-3593-44aa-d10c-08dedb4e6a58
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 11:04:57.2088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C36HxHYe7dt9ct1kfSKzxjBF+bs4ILYd8wH7MI0paksppCmj9tjzP8J1fOUWHnJNaVyR+KDsRQr72EYEFT+pplXtA/gOTA0jEXOB6STujFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6653
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:contact@c127.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:Jose.Abreu@synopsys.com,m:pavel@ucw.cz,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304979-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[c127.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:dkim,boxer:mid];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,synopsys.com,ucw.cz,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B88370FF2E

On Mon, Jul 06, 2026 at 05:32:45AM +0000, Johan Alvarado wrote:
> The TX mitigation logic only sets the Interrupt on Completion bit once
> every tx_coal_frames descriptors (STMMAC_TX_FRAMES = 25), with the
> tx_coal_timer hrtimer (STMMAC_COAL_TX_TIMER = 5000 us) as the only
> fallback. TX skbs are freed exclusively from the TX completion path,
> so any flow that keeps fewer than 25 frames in flight has all of its
> skbs held for up to 5 ms after transmission.
> 
> Paced flows never queue enough frames to reach the frame threshold:
> TCP Small Queues caps the amount of unfreed data at roughly two pacing
> intervals worth, which at moderate pacing rates is only a couple of
> packets. Every small burst then stalls until the coalesce timer fires,
> and throughput collapses to approximately tsq_limit / tx_coal_timer
> regardless of link capacity.
> 
> This is easily reproducible with BBR, which paces its output and thus
> keeps only a few frames in flight at a time. On a YT6801
> (dwmac-motorcomm) equipped Orange Pi 5 Pro, a BBR upload over a ~23 ms
> RTT path is capped at 5.24 Mbit/s, while CUBIC reaches 207 Mbit/s on
> the same path. BBR measures the stalled send rate as the path
> bandwidth and locks its estimate near the floor, so the connection
> never recovers. Lowering the coalesce settings with ethtool -C
> (tx-usecs 100 tx-frames 1) lifts the same transfer to 447 Mbit/s,
> confirming the mechanism.
> 
> Fix this by setting the IC bit on the last descriptor of every xmit
> burst, i.e. whenever netdev_xmit_more() reports that no further frames
> are pending in the current dequeue batch. Frame-based coalescing still
> applies within a burst, bulk traffic keeps batching through qdisc bulk
> dequeue and NAPI polling, and the coalesce timer becomes a pure
> fallback instead of the primary completion mechanism for lightly
> queued flows.
> 
> tx-frames 0 keeps its meaning of timer-based mitigation only.
> 
> Fixes: da2024510031 ("net: stmmac: Tune-up default coalesce settings")
> Signed-off-by: Johan Alvarado <contact@c127.dev>
> ---
> Notes for reviewers (not for the changelog):
> 
> Tested on an Orange Pi 5 Pro (RK3588, Motorcomm YT6801 PCIe GbE via
> dwmac-motorcomm), iperf3 upload to a public server over a ~23 ms RTT
> path, coalesce settings left at their shipped values (tx-usecs 5000,
> tx-frames 25):
> 
>   before, BBR:    5.24 Mbit/s (cwnd pinned, bw estimate ~6 Mbit/s)
>   before, CUBIC:  207 Mbit/s
>   after,  BBR:    447 Mbit/s
> 
> Interrupt overhead stays sane: ~3.3k NIC IRQs/s total at 447 Mbit/s
> (~38 kpps), i.e. roughly 12 packets per interrupt, since qdisc bulk
> dequeue plus NAPI polling still coalesce within bursts.
> 
> The 5000 us STMMAC_COAL_TX_TIMER value postdates the tagged commit
> (it was 1000 us back then); the stall mechanism is the same, only the
> throughput ceiling differs, hence the Fixes tag on the frame-count
> change.
> 
> The XSK/XDP TX paths keep their frame-count-only IC logic: there is
> no skb/TSQ backpressure on those paths, and netdev_xmit_more() is not
> meaningful outside ndo_start_xmit.
> 
> The same completion starvation was reported by Pavel Machek in 2016
> (UDP burst pauses, back then a 40 ms low-res timer):
> https://lore.kernel.org/netdev/20161123105125.GA26394@amd/
> His patch disabling TX coalescing entirely was rejected in favour of
> "a real solution":
> https://lore.kernel.org/netdev/20161205122711.GA30774@amd/

Very messy thread. To reiterate - does tx coalescing do any good in this
driver?

I did some digging and seems there was a rework of coalescing in 2018 and
then some more polishing happened in 2023 (net: stmmac: improve TX timer
arm logic).

> The subsequent hrtimer conversion fixed the timer resolution but kept
> the timer as the only completion mechanism for lightly queued flows;

Wouldn't your change imply that tx coalescing could be dropped altogether?
I do agree that each single batch of tx descs should be signalled with ic
bit at the end.


> this patch adds the missing burst-end interrupt.
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 2a0d7eff88d3..ddf4ac03538d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4626,6 +4626,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  		set_ic = true;
>  	else if (!priv->tx_coal_frames[queue])
>  		set_ic = false;
> +	else if (!netdev_xmit_more())
> +		set_ic = true;
>  	else if (tx_packets > priv->tx_coal_frames[queue])
>  		set_ic = true;
>  	else if ((tx_q->tx_count_frames %
> @@ -4910,6 +4912,8 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  		set_ic = true;
>  	else if (!priv->tx_coal_frames[queue])
>  		set_ic = false;
> +	else if (!netdev_xmit_more())
> +		set_ic = true;
>  	else if (tx_packets > priv->tx_coal_frames[queue])
>  		set_ic = true;
>  	else if ((tx_q->tx_count_frames %
> -- 
> 2.55.0
> 
> 

