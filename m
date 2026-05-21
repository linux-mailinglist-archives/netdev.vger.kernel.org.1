Return-Path: <netdev+bounces-290377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HcKF8b2DmoSDwYAu9opvQ
	(envelope-from <netdev+bounces-290377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:12:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2BA5A498C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D640302FA12
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B9B3C76A2;
	Thu, 21 May 2026 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbN4ZN/J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0A93C5DA6;
	Thu, 21 May 2026 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365153; cv=fail; b=ntyqYMK35q0XxsHEDLDahpgGC4QlW4dtdlSVuvzwW5PvCNgfLlVVq6cCvPwsHvmfNEGBvdNUg0FBn83E1uVOirjnsy3LCfG4+qnC5YGXmIBD/1odJh13tWIkJASt/DNgTfSbImLqR9Gja8K67iPGzTsPSmMd9E6rAGr0vSxl9pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365153; c=relaxed/simple;
	bh=cb6YwGroEdcwKeDvk5TciGy4JSUI4zROC1gN2Wf3350=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uhJ7eFKb8E6j4oolJg3vQ+3gxGfcH6t2iguMIpj6maPMBIFb+r/ZZzLJEjYWPD2oUSg1l9XCIDmix5Pt6WIG8ewRgUeL5f/rbOOkIZ4k/ed4W0s9xisB7wYgXA8c4xCs+2iC8p7aeFSmaZVTUC/rEZetQMNp9fRCXLeUsyBE/B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbN4ZN/J; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779365151; x=1810901151;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cb6YwGroEdcwKeDvk5TciGy4JSUI4zROC1gN2Wf3350=;
  b=QbN4ZN/JNne81TCaXrLW8jBDH1uMOs+mqaupt/YLWmnH/py+w8IOpx0C
   1j1wOXW1MyOPBw9hd1Z7aoHo+oatwV5Yf04tyY5llBtplFozEOYI9wI1J
   BhuTf+TroXU2qf2L1+rMPSja54pDFxcNype1Klo5ktt7+Icu6EmXDECI4
   HXfv0JavOSqconbhyzWoB+DMvCW+uxlWByF14nVHDjhBQBjl+Xd6OdAHH
   Q6DvCJbOk7/6CVo8GYtPcZ0eYjxSZCqyBH/QOqP6cWVsazJcfXXi8ni6x
   n17NFUoPqalu6a1b683gbvdF8dYjRrz1CJ9CAojH+vmYIyUC44KzqFdKA
   w==;
X-CSE-ConnectionGUID: OVG/Yd+gQC2KBjBe5JHVhw==
X-CSE-MsgGUID: WbCfoSCvQ2yVJVkYfKsIGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="90855888"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="90855888"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:05:50 -0700
X-CSE-ConnectionGUID: j7/CxkH+SHeCXT8/qdcmgQ==
X-CSE-MsgGUID: IiLXljx+TtS+jbpucOD4aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="244501952"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:05:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 05:05:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 05:05:49 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 05:05:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbkVTn+zrM8tHMctQ9TMHRCArktHkomhlH7Z2+5tIIB11XbRyjESYc4chRy6ZYpZSUSLJafQxDPGxyiSBvdNDulaprTP0poCLARAczzrX6CmQ/N9Gk6pdWpAk9fIQ5ZBv6r+9eGXLKkkzhAVGJfu+7wCgGZgO2ct5hJNnqyVlkl6/utzDDX5cZEhInitBrVFf6Mm7oZw2GqP70GwfEOw8UukEL2mArsPp+FP1fq1MTGFwjnI6tFRsU1fQFnPHbd/+rRoIGsProD3wpve1DH5czR50dLQen4ec9uonludj59mH93kxg4W7ygiaPFUqNQri1EvgI6A+4UjiSEOfaaaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xgh3oPLQ2WamIwAhIT/xAK9+dqRkCv4dEzeHnwabPZ8=;
 b=jFsbIenjOC6vaQrmRl7KanRYK8lHkZEq3reb+evmc1nvfAQCfV3VrrB87sHzG4qiO/CJOSWRS/FBRJoRtHaVxwAL24XtjwlmdEphJDvYUp3ElDGfuTSRT98wf5kqkUteSrY4AVsTmNf3qQrgdd++PBJ607OvcNXhDeJLdw/Mh65zqPazulaZcDIzMPjqutVMYOtO7TUIeuLOrFLqF7o7jFF3D49jjYITGCOSSrcEybKMecBgH9+0RYZwL36C1rj2PyanHeLK39niVDZ2ld6Q2Yfhq5OvFkXtg5ikHtaPf0CTR13Maszw8z4rsaD0s95Ax3meAtG98R7CsXXHqTG/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV8PR11MB8769.namprd11.prod.outlook.com (2603:10b6:408:204::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 12:05:46 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 12:05:46 +0000
Date: Thu, 21 May 2026 14:05:39 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v4 2/5] xsk: fix buffer leak in xsk_drop_skb() for
 AF_XDP multi-buffer Tx
Message-ID: <ag71E39eTnzx2Npy@boxer>
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <20260520004244.55663-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520004244.55663-3-kerneljasonxing@gmail.com>
X-ClientProxiedBy: VI1PR07CA0161.eurprd07.prod.outlook.com
 (2603:10a6:802:16::48) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV8PR11MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9e8304-9e19-4322-d3b2-08deb7314a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|4143699003|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: gqVz+Fn74cjgTtFXOyKh8wrVnNCPxmU5y8K/XAkhn4+lp5SsS7866zaThYsGjbaZNi55z568GbYtipsL0iux4GgWrdXF7pOXWklnM1Eux7p+s2/apa2sL6JjMit3H/kyPEZWgrxp1U+fcxKR2Ug3z6WAdIGmATJC59lzRSkvk6ufSYj6iT12SvgG2nV6rQrCWUBb7avt15G9hnFFaPnbrm3xoF6ERXCDuJ40bHox0+w4d9p3n7qYcS1DZ2pSvRcLIpFmLIF0MnJQjTg0IexrtDxJy1qLWQ9joUobM+OyjgloVXyqpbnIYPtZvpPJkDqzD6uNz3NYqmn+OjEtBaoxkMsN5Cebj2+DvXtR/N8o4gKzjpWxcgfCG9T+RtfzrkQRqPB4sCZW23hNi6c/dcc/xspgSkJthaKoqg9QdZ+rHaxnNPUs88rxg+tL0IRRNES3yBTZlhCuB6SGJkJEUVM7+TRFeGYF6tsKCxmgzr7I3vWxp2AuAKdszqJsqrAVfIaOQM3YglNN7M09JRp+PKVmUaeJaXOrtLDkPrjYyLsh4wMXaIgdBsKQdjmx9DzdCu527tP0ksz4p5AkLf52adUtqAnVhbihWZNE7sSD5Tc0n8GcjecrJv+pFBvdOMNdQ/Mi9KGeWI1ACSNEMUZhmGHxmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hf8HM/mIMOZ6FHn9Yu65AnyLJ3PxOBEdvvAOAyxKwOqXmXqc/USOs+RoqTyD?=
 =?us-ascii?Q?fhUrX4X1N+VmiXdrkkJqIH7PpHMdZzIsxDllue1jibXkYCUJtEkjibWoH7sY?=
 =?us-ascii?Q?7DMlPZtqKPtWNyBq+isjV+ldF+t4RkHHMj2lGCowOv2RaWn0n5N8cuJ1aZzA?=
 =?us-ascii?Q?FJptzNjW4eEGFIw9ZDbE89xmroN8OfUdVNH9tXWNIZDo8pJujeVUXLyVP5wP?=
 =?us-ascii?Q?jE13cYOWKPoYR5Cxe9/S5BaGI1gQnfBZGO7wHpej1XnUSPt5F93uY9REx6WZ?=
 =?us-ascii?Q?W4yvJXNOaUiJ5x87TPPC6NQQ0cVp8AhivOszOIokWlHF4qj9zf5nBsx6AVbT?=
 =?us-ascii?Q?lyORRi9xdAvi9gC7HClDZVNj2j7m4KAd4wAI+ixhWXTe2Tc183GgKq3BQQPm?=
 =?us-ascii?Q?LiLsri6uv2cj4Lauyf7Bu6xbfFVtf4QZK9k7vsERb6xqEjrXH/+t9TlEeR1S?=
 =?us-ascii?Q?3BnakySzCUYdonkzVgkE/i5Ch0apHWYPJv+0vQoy06Oly8PQNEsEjn6WB5Iq?=
 =?us-ascii?Q?35un9BYufUsdpuln5SjpOV6hKmcRA5NoHe8OdM6Zuk2H9fLvKQlf0ZEpBpM6?=
 =?us-ascii?Q?17kTY3xAJog/tM4sTr/1gb8p/G5Q1w/o1wieWUlsriSjXUoMmPQcM/UJgX+7?=
 =?us-ascii?Q?1jfcezkn8YfHPHmwNmX5Z9oH3PVVDhhr4NuPZq+Sq8FC5yk0xAIlKsZHs6uR?=
 =?us-ascii?Q?N8CPslhKFzclNdH1zgdthAmyltEoz9SjerUy7+EqT3FJQS6lkNou65t57Dzc?=
 =?us-ascii?Q?+ANpd7liQbbVmNcmhhY84Zmw6HSivEMRahLE7qpCNLjsyNwN15kMFg/xR1l2?=
 =?us-ascii?Q?HP5FympzmzDk/gqWEA03Qhsj8yuWGLZ+ePI30vMCga4al8FoWZ7g8hOcnSGl?=
 =?us-ascii?Q?BjorRFv7R5TWGOPkf12YnU8mIirj4uaPbHPJLuWGoxOkGRWmRFw7yHqsncRl?=
 =?us-ascii?Q?+N+vxN4j//ILuuNyIY1ssQM9wad4z1a+MqXOZ55O8BYCGJ4isYpu98tAyr6I?=
 =?us-ascii?Q?ehfOFXRqfeGwwDQtEeEdgkmQ+DbNK77igqJ9GGQCRgRn743RgEfzB+w0OO79?=
 =?us-ascii?Q?eGXmKv5RcHjcFhtEOwZv7xSZaMJZzgXSaCbcVTI82HZXP0NPVny+oT5NXkOP?=
 =?us-ascii?Q?jqbaKNuNydEykJpwzDJ6D1swgvWI/hc/V+lcjvcqY87hWqX979FlcMUaqT7V?=
 =?us-ascii?Q?+Sn/42yYTDdmQuUlz6BhxB2DihF4BikRNMYhT35wl1YCnD5Ucz04UMZngkAx?=
 =?us-ascii?Q?vpMw/1VsSiv5ZxnDmKw7MErdnjYFScoEPZKFP0OAAo3NrDpIlLFIC5bT5jcL?=
 =?us-ascii?Q?oBOAT9ZhEx36mbZeIP6FovFgiApu0XnorEBV+q2IUBSzB7ACwCJSKM7ga8zA?=
 =?us-ascii?Q?V4BWPMFj1V6aOhYAlz4PUceO8iIhSd+/HRP46FDNn3vZInolPrakM5C5KmYu?=
 =?us-ascii?Q?FilpsExK325CYNI6MiD8B+myidfQZmyQ5V9iZUg8AYuG9S+93h3hNCBlYPU9?=
 =?us-ascii?Q?iwtmDBG5MnWOUyirK1cAFjh+S7tgBMCQBBmkGbWKKuCYQmrCr5XCTwFlbthY?=
 =?us-ascii?Q?bGJJIHm4jo9rxHTI3a7xAvrq0l6kuyFjtiMec/HEjnypjkVlGB9iL+/ksAaz?=
 =?us-ascii?Q?9VsxMVpcFx+YEfE1Kd8JFp13u15I4pvARBGoVoMkEAKABjqFRSE/9tUpbd88?=
 =?us-ascii?Q?Mx8A0sYmOrsvWyNMxdk1VousBn2FfdQjgz+uvqUkRMeX/Jzn4ctpRlv5G9+g?=
 =?us-ascii?Q?L8t6aqdwiBg12K8SALk9l4sJxLZQPik=3D?=
X-Exchange-RoutingPolicyChecked: nLbx98vNzsb2m6vufRCut3Awa3tq7ikPQXme6M1R0xXkOpDEvW89LlmkUd4W0v+4huMidc2dYItaWaMzomh/VfxS6IWJmujmRlkQYLeLmmBFKctWdX7RIUvX9RIV2XK+ZTgnjX15qIZWF/kz0A4UaXXBtaM0YWd05045Jou7yo1swIfB+H4VpRfdMtCu+8UkmHd79X1tuHPWN6kwZ2dZdddqdrZrnsz4o9ZWJRjgRMbwZh3izPjkkoV1pIUF2wmw63KXTL70tEfVkTpTGY7JIH9boH6KuKs1B4tbXdRqvtREUCr+5cH9gZFz4/qqpdlffr9QqWFa0jin8R7m2SAVBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9e8304-9e19-4322-d3b2-08deb7314a85
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 12:05:46.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcS6vYz0Jum1aJZYUhsHym/fopJLrad9rYbr/fpmO9WTOqZ/9I8Azr/u3nlKh93dC2ZabDMeFYRhdm80ex+7V1riw3TRaxDneMA5tCCiwDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8769
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290377-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tencent.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1F2BA5A498C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 08:42:41AM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch is inspired by the check[1] from sashiko. It says when
> overflow happens, the address of cq to be published is invalid.
> Actually the severer thing is the whole process of publishing the
> address of cq in this particular case is not right: it should truely
> publish the address and advance the cached_prod in cq as long as it
> reads descriptors from txq.
> 
> The following is the full analysis.
> xsk_drop_skb() is called in three places, which all discard a partially
> built multi-buffer skb:
> 1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_FRAGS
> 2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
>    the TX ring prevents the partial packet from completing
> 3) xsk_release(): socket close while xs->skb holds an incomplete packet
> 
> In all three cases, the TX descriptors for the already-processed frags
> have been consumed from the TX ring (xskq_cons_release), and CQ slots
> have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
> which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
> the buffer addresses never appear in the completion queue, userspace
> permanently loses track of these buffers.
> 
> Fix this by letting consume_skb() trigger the existing xsk_destruct_skb
> destructor, which already submits buffer addresses to the CQ via
> xsk_cq_submit_addr_locked().
> 
> Note that cancelling the descriptors back to the TX ring (via
> xskq_cons_cancel_n) is not a appropriate option because an oversized
> packet that always exceeds MAX_SKB_FRAGS would be retried indefinitely,
> which is an obviously deadlock bug in the TX path.
> 
> Also move the desc->addr assignment in xsk_build_skb() above the
> overflow check so that the current descriptor's address is recorded
> before a potential -EOVERFLOW jump to free_err, consistent with the
> zerocopy path in xsk_build_skb_zerocopy().
> 
> [1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> 
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Sorry for the noise, got lost in my inbox and replied on v3.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  net/xdp/xsk.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f8c8a8c9dfba..0a6203c42576 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -793,8 +793,11 @@ static void xsk_consume_skb(struct sk_buff *skb)
>  
>  static void xsk_drop_skb(struct sk_buff *skb)
>  {
> -	xdp_sk(skb->sk)->tx->invalid_descs += xsk_get_num_desc(skb);
> -	xsk_consume_skb(skb);
> +	struct xdp_sock *xs = xdp_sk(skb->sk);
> +
> +	xs->tx->invalid_descs += xsk_get_num_desc(skb);
> +	consume_skb(skb);
> +	xs->skb = NULL;
>  }
>  
>  static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> @@ -876,7 +879,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  			return ERR_PTR(-ENOMEM);
>  
>  		/* in case of -EOVERFLOW that could happen below,
> -		 * xsk_consume_skb() will release this node as whole skb
> +		 * xsk_drop_skb() will release this node as whole skb
>  		 * would be dropped, which implies freeing all list elements
>  		 */
>  		xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
> @@ -968,6 +971,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  				goto free_err;
>  			}
>  
> +			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
> +
>  			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
>  				err = -EOVERFLOW;
>  				goto free_err;
> @@ -985,8 +990,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  
>  			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
>  			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
> -
> -			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
>  		}
>  	}
>  
> -- 
> 2.43.7
> 

