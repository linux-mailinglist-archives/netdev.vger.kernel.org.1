Return-Path: <netdev+bounces-262579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEf4LXxWpWnR9AUAu9opvQ
	(envelope-from <netdev+bounces-262579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:21:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D331D5741
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32BBB300696C
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 09:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99AB379EC0;
	Mon,  2 Mar 2026 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNDnJNwQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B667F430BA2;
	Mon,  2 Mar 2026 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772443105; cv=fail; b=iNO0mK1rprcym/SOSMzwE3No1ii1WMGErndzOOYXVfoCQr9rz+QG77XRD363v/4Cw9g6cbKYXcz9eaenTH4CUGEVnSFgjCIUJgvztaUSqYIXSJQBzT3CEjNXXQ9g0XaB7eptTrg0J7MxpFUPBZrOWTjlpE6IMBsHnG9UFI8VcRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772443105; c=relaxed/simple;
	bh=cHksX/26Cg7cHkdGQGgOP2pbYrNKkFCTKmsK6poAslg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tN9OL2UcxWI0mP4hdb69NFitObtPD3LcixmWRM1g7HasCDw1cJycwoSuT3ywCpIYQnX/rEcojCu6TEix+WDHw3zMHa5ZCDvwMxfMq/MS/I1MoCD4Ufd93d2e0SQMeMeIj1kT+iXh6Ywmhs52vQuFsXdT9js3XMSZ18tkeCErWKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNDnJNwQ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772443104; x=1803979104;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cHksX/26Cg7cHkdGQGgOP2pbYrNKkFCTKmsK6poAslg=;
  b=DNDnJNwQx8t9Fz/y0cvf0CtMWyjrFxAvmw01DQjn5xsNuy2Z6APdm1/a
   nXb3juXbZCf9SRnP4EociSkrb5ZfMdQqQBFe0o0PBnzP6yVc5VxiGX6hY
   +hJptdO/fZ1UNMZBVun/bfiSIMDEfaQAU6qE4+WSI4sgPv+AmDa0Wy73f
   kifQqSbBoT6YSKkGokZN7tIvqcx7+XEBPqafGl0kbtglL0uUYZSmPelxs
   3Gmuq7GXtf7MoZDuBh59N68bXZD7x3InqJdGF6mwBVxyJ+wQMANWDsJbD
   rm8m/ztQR8xT0gsqmXJxnQD8hO6D1fKBuBCCJxYCRVI+VS1ruB8LFv49E
   Q==;
X-CSE-ConnectionGUID: OfH967wdRNyyq/Zh3FsLcA==
X-CSE-MsgGUID: KZtSsgXuSz+CaPxUqGUjNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="76047969"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="76047969"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:18:23 -0800
X-CSE-ConnectionGUID: cnRYCKhyRE+yw1+9lGWS5Q==
X-CSE-MsgGUID: JtZEO4HyT1imdjdUTLyKCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="216730244"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:18:22 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 01:18:21 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 01:18:21 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 01:18:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4hOkn/oan1An45G+/XYHYAWLSiHer5NZkhdpXHbEm7Yhdy1fXl0B7Hi6afFg1ZM4Cfo6i1ZkdvviG7zSJXVvEIKSAMK/ld/EW4Z3joY59/GdUgaoeAgnj9L8/84MQMU4pn4Tok3LpSGDMTUBIIKXrXDnRcx4B5QVeGRUkJo65K5moFr/v0kC+FIcdB04EnFoGKhdP2jB6RSrfO+ogdoMTdl0fEwn+I9+0s41wdH0meqOrOg/1ud48L4Pgjp18t+bfU4CF1GHuKp/SR8tPYgtEj6iuWT+QYDg+kTjJbo/SsO2hSYMMQsKip1cvppsLAAOALjvMdlDQfRasefbVOGHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A11GN4nyAhE18GKLe+ifsY+YOIjA8+krpHjkOXJ+E7Y=;
 b=PY0I9UsPYjhdKs6lVGkFVoyVpkfHZ6Wn+wNMFZf5QElc3KRpffg+AJITQxq+joNvBNyJrQeg4Ij9PFrDZGx8lL6bgkM0mHJ0iOdMcaVwQfQGdgpEKDRasyfSQwoB1oNXM4NZOI1o3pMkGp7rHFQlVyTirxO35035FrZm9+il5p7kQgnkCatMS59cEJOjFlpnnDULScSdWEm1Z+tMAM2Uv+P5cJ+wHeRiBd268xLjrkmSdNjwjEHTxgHo9FN5jlyyE+dWET68JAfgJiLDdqWSBLWqlQ3cxvqzVOmudRuqdYddhhRAIExH685x+fKnT4Qt6RKsMEMvL7uOpiOoOAgKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA1PR11MB6465.namprd11.prod.outlook.com (2603:10b6:208:3a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Mon, 2 Mar
 2026 09:18:18 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 09:18:18 +0000
Date: Mon, 2 Mar 2026 10:18:04 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <bpf@vger.kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, "Vladimir
 Oltean" <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Andrii
 Nakryiko" <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Simon Horman
	<horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, "Bastien Curutchet (eBPF Foundation)"
	<bastien.curutchet@bootlin.com>, Tushar Vyavahare
	<tushar.vyavahare@intel.com>, Jason Xing <kernelxing@tencent.com>, Ricardo
 =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>, Eelco Chaudron
	<echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, "Toke
 Hoiland-Jorgensen" <toke@redhat.com>, <imx@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kselftest@vger.kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: Re: [PATCH bpf v3 0/9] Address XDP frags having negative tailroom
Message-ID: <aaVVzBBsvqF1jSxq@soc-5CG4396X81.clients.intel.com>
References: <20260217132450.1936200-1-larysa.zaremba@intel.com>
 <aaG4z7ZIARBAzueO@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aaG4z7ZIARBAzueO@boxer>
X-ClientProxiedBy: VI1PR0502CA0033.eurprd05.prod.outlook.com
 (2603:10a6:803:1::46) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA1PR11MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0a04dd-bc0a-4ee1-d211-08de783ca45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info: fepSxQesPP6S14mLeUEMaTopQYAD1ehMikQ50StSlsxE+x7eWa54V2P14fMKUrp+OG2IstFHuDRAiKM6U6XB9NU1pjPK3Gs4WZCmf/NXjaN343/iHlai3vgbqlUvC+CLw83tubCBgCwRSxSrXgOrRzRAGj7trvqM/ICEMKI6hxTVANjQlrVtdMhPk5iCr44zUs6jpNxVpRTOW6mSsaTfyczo058rdZzzaFbznNvKIrJ+kNJdI1SqeKk4CuLUXQ9IHl2G0P3HwItvRsR6Ju8hPAMr0OLLv+GBiZDgxQPO0iZb7VRRvb5L3HmU/BTGNGSXJFDNPlb3IIDGmlTxSUuJM1i48Whcw/90RM446FrsLAoT4PFjtTsqo5e0MXKNW2eTPkG2QRgIGIdloXKFqpfOelYQIiWGAOTINMjyaJd7PsevpTsdpj9akKyGG3/TsLkFkpc9TeavAeCov7BeTS1/y/fgm+1aUXNDYLPdTc4oY4VR6sam3uk3su4HvQfSKIqTP0XAR84C/ctUduoaDIq/LJQrgsteKMT0Z0gID0CmHGu3wZbFJVgv/vAEsc+GpXhLjqT3UiVt4QO970W8lKKdJIO0I2Y3kvAHDbesV1mDmhvAjmgGsZoETEkYkxxO+d33YB1NFuOgxJVJcFkTfLpIPuVFZLLLuV7wnAbMPTnSloTsHNnVz3CKTkO93zfAU5z6rYPVBco6AyfO293WUcAB+V0QO5RQi4a9HM0pRu0zeL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rPthbJHYEJC5Iq4iSRIrYA+6JerXH6gsLyomflXvgATDFPWONqsq6+YfiPQG?=
 =?us-ascii?Q?3lkscGoaQvlx9SDtCS+Kva1sFRgRA6XfcKH5+VTw1t2P4gLsICZrkXhnhhMA?=
 =?us-ascii?Q?D5M+4BCwEu/NqlVA7T7d4cT10J2SmGRIqbrDqfr1SAsWCbAm3uCV7Q1hirKS?=
 =?us-ascii?Q?Dx7pemEsKQkJY1DrgnRlbSFbVpW6VtT7ipQHTAuj/r1Y8f/ZWIgNmKyNJT/o?=
 =?us-ascii?Q?mFKe2XriQtPe5XwVVe5eAvH6bT0U+iYhh37LfuCmC+4L6Y+0O4qArEhFfvF9?=
 =?us-ascii?Q?fSOcvGDdjCYN64eWVeqr/DNT0FO1XSt9oY8O4UL7kwSMqf1CmX2laKXU8Cxy?=
 =?us-ascii?Q?DObv23s8NU3BrZbBajvuPsj0QQXO9NUMfKDYuxlWu7PCvWReU8RzkLF6tAUH?=
 =?us-ascii?Q?qHWIh0wZNeLkNCNorPZgH5ggRZ7FDB8dsbCGSY2viKeKaSdcppvHMKx4/XHU?=
 =?us-ascii?Q?w2nuQftIcVyq7BOvwf+0St2hUvpGzvEyIxpnh2wGc2pHZsae6V4/qk7uzdgp?=
 =?us-ascii?Q?k90hx1lsnxtU0T3+DfFsEddm+oESf+gmQWoFkUeRJuE47DXTRPIsnTixnI8Z?=
 =?us-ascii?Q?jTXfqTm40tr4lGoG1nwKx5tC6sU2jQy2ltGTUMc3No+1DmM5uJZuyK5p9toL?=
 =?us-ascii?Q?+uuv4NA9Z9WXG/gey+olcHc2CjCjXuh564HOsd0BhUTxd4qUl2y0g/jr3chG?=
 =?us-ascii?Q?XorUpnV/MmP01xaSuyMBlLh9X2zmpfDTMUU2yw22OkLubfBDy6g5h3imFOvp?=
 =?us-ascii?Q?Y6pKO7bh8KtWhIXjRy7MvFl2hnPFE6rHGY1HDFehuTC1GL42AdMHCuj19/0W?=
 =?us-ascii?Q?WCDTJNJQv1HsTeo5JC/fElrC1wbvx0TPkzLo15SRHW83xw9D1S4aSyU6QDdk?=
 =?us-ascii?Q?0U7WHgI6y8y4Q52YqSh0EsJ5aRBZV5bhr/FiteJ3IwxC6eaY8RDbSsnC6R0V?=
 =?us-ascii?Q?v0s/X/ngO9fpW3f/Od7tGU/QlHbI+XyZ/EwVOwMVnuzQfuAbRhYqkLuU2Jfk?=
 =?us-ascii?Q?jYJ/3fU4hQ9x7zGgToRIOKBXGTcUs/I4WcFipGFBLYk1/r3hUFGWORqmTGHA?=
 =?us-ascii?Q?+lNJO29sFTv3RsAg/eKo8kYkjdPbTs2uIlOGo9hx7HmidE6GvfIOh1kWOG3S?=
 =?us-ascii?Q?5FWQ1B1R8x57s8jW/h3ezc0IJWkNx4Zng4d5EiRHg+2rTd5+hgE3W/DMnUI4?=
 =?us-ascii?Q?wfzM4NmUQSRNno5E1THI1WK2BGZpG42aZXqeZq7YaekZsVNTKijCG04L6NX7?=
 =?us-ascii?Q?DSwrwmdp8q3ClHM+8LIYHBvQUE7xEhRwwrP40x2f8zYudOPwoRFHu8+WCfLZ?=
 =?us-ascii?Q?M28xQ4gaeninQjAIApIeWXjjZ5F1JOyXzYe6KfBwW5TjtehvbX/NBwpkqf/F?=
 =?us-ascii?Q?L6dhY2ZEYtQqIQ/5iaHsh/pozb5mESisBFa+sggnr8FixIujbG47zZ6xuW7s?=
 =?us-ascii?Q?q6LOLj2J7GQw3DsgwYfLyN/H2AggGcrSPCh5gbXce7AtCIFCnidSg9od6Wk1?=
 =?us-ascii?Q?87dVM4RIo5XMGLBySZWqKinwgTfTupLSQIsjgxUKapdxGi9ingNaRPJ/bjI3?=
 =?us-ascii?Q?+MLh0iDkhh7w/ascyQ6BNxqjFGrMW6h+udK2JdzXMB3+ZRD+9l4vdEhb7eA5?=
 =?us-ascii?Q?kGW7Cf+dgXzSW+xvhIdK8g0ZI8ZgqLsrtiy19tuH3HyGYnd1qqjqUV8uQTRo?=
 =?us-ascii?Q?ernzLD/TL75A4b4GpOng4Gweho5tbnf43GqaJizpbY5Hby+6xnuffh8a0B3g?=
 =?us-ascii?Q?YIT2Vp+3MYdBzCUJrC1ygH3ZGHJfC/abEo6F1VCAEcBHH+fw8BUjw3Di5kzc?=
X-MS-Exchange-AntiSpam-MessageData-1: mGfe5MCG/WcvMliI16hqsaUJlLg4fos13lE=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0a04dd-bc0a-4ee1-d211-08de783ca45a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 09:18:18.5503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/p2JlUTlIhfhoNihF9XpC7cfuDBmKph5LmiuYspgPxepPp6Um09Um0awpuE4owLaBP1Ld3qamDVczbxLVD3xhnNgM7Jmzd/bKmOqOYmVlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6465
X-OriginatorOrg: intel.com
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
	RCPT_COUNT_TWELVE(0.00)[43];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262579-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[soc-5CG4396X81.clients.intel.com:mid,test_xsk.sh:url,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 19D331D5741
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 04:31:27PM +0100, Maciej Fijalkowski wrote:
> On Tue, Feb 17, 2026 at 02:24:38PM +0100, Larysa Zaremba wrote:
> > Aside from the issue described below, tailroom calculation does not account
> > for pages being split between frags, e.g. in i40e, enetc and
> > AF_XDP ZC with smaller chunks. These series address the problem by
> > calculating modulo (skb_frag_off() % rxq->frag_size) in order to get
> > data offset within a smaller block of memory. Please note, xskxceiver
> > tail grow test passes without modulo e.g. in xdpdrv mode on i40e,
> > because there is not enough descriptors to get to flipped buffers.
> > 
> > Many ethernet drivers report xdp Rx queue frag size as being the same as
> > DMA write size. However, the only user of this field, namely
> > bpf_xdp_frags_increase_tail(), clearly expects a truesize.
> > 
> > Such difference leads to unspecific memory corruption issues under certain
> > circumstances, e.g. in ixgbevf maximum DMA write size is 3 KB, so when
> > running xskxceiver's XDP_ADJUST_TAIL_GROW_MULTI_BUFF, 6K packet fully uses
> > all DMA-writable space in 2 buffers. This would be fine, if only
> > rxq->frag_size was properly set to 4K, but value of 3K results in a
> > negative tailroom, because there is a non-zero page offset.
> > 
> > We are supposed to return -EINVAL and be done with it in such case,
> > but due to tailroom being stored as an unsigned int, it is reported to be
> > somewhere near UINT_MAX, resulting in a tail being grown, even if the
> > requested offset is too much(it is around 2K in the abovementioned test).
> > This later leads to all kinds of unspecific calltraces.
> > 
> > [ 7340.337579] xskxceiver[1440]: segfault at 1da718 ip 00007f4161aeac9d sp 00007f41615a6a00 error 6
> > [ 7340.338040] xskxceiver[1441]: segfault at 7f410000000b ip 00000000004042b5 sp 00007f415bffecf0 error 4
> > [ 7340.338179]  in libc.so.6[61c9d,7f4161aaf000+160000]
> > [ 7340.339230]  in xskxceiver[42b5,400000+69000]
> > [ 7340.340300]  likely on CPU 6 (core 0, socket 6)
> > [ 7340.340302] Code: ff ff 01 e9 f4 fe ff ff 0f 1f 44 00 00 4c 39 f0 74 73 31 c0 ba 01 00 00 00 f0 0f b1 17 0f 85 ba 00 00 00 49 8b 87 88 00 00 00 <4c> 89 70 08 eb cc 0f 1f 44 00 00 48 8d bd f0 fe ff ff 89 85 ec fe
> > [ 7340.340888]  likely on CPU 3 (core 0, socket 3)
> > [ 7340.345088] Code: 00 00 00 ba 00 00 00 00 be 00 00 00 00 89 c7 e8 31 ca ff ff 89 45 ec 8b 45 ec 85 c0 78 07 b8 00 00 00 00 eb 46 e8 0b c8 ff ff <8b> 00 83 f8 69 74 24 e8 ff c7 ff ff 8b 00 83 f8 0b 74 18 e8 f3 c7
> > [ 7340.404334] Oops: general protection fault, probably for non-canonical address 0x6d255010bdffc: 0000 [#1] SMP NOPTI
> > [ 7340.405972] CPU: 7 UID: 0 PID: 1439 Comm: xskxceiver Not tainted 6.19.0-rc1+ #21 PREEMPT(lazy)
> > [ 7340.408006] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-5.fc42 04/01/2014
> > [ 7340.409716] RIP: 0010:lookup_swap_cgroup_id+0x44/0x80
> > [ 7340.410455] Code: 83 f8 1c 73 39 48 ba ff ff ff ff ff ff ff 03 48 8b 04 c5 20 55 fa bd 48 21 d1 48 89 ca 83 e1 01 48 d1 ea c1 e1 04 48 8d 04 90 <8b> 00 48 83 c4 10 d3 e8 c3 cc cc cc cc 31 c0 e9 98 b7 dd 00 48 89
> > [ 7340.412787] RSP: 0018:ffffcc5c04f7f6d0 EFLAGS: 00010202
> > [ 7340.413494] RAX: 0006d255010bdffc RBX: ffff891f477895a8 RCX: 0000000000000010
> > [ 7340.414431] RDX: 0001c17e3fffffff RSI: 00fa070000000000 RDI: 000382fc7fffffff
> > [ 7340.415354] RBP: 00fa070000000000 R08: ffffcc5c04f7f8f8 R09: ffffcc5c04f7f7d0
> > [ 7340.416283] R10: ffff891f4c1a7000 R11: ffffcc5c04f7f9c8 R12: ffffcc5c04f7f7d0
> > [ 7340.417218] R13: 03ffffffffffffff R14: 00fa06fffffffe00 R15: ffff891f47789500
> > [ 7340.418229] FS:  0000000000000000(0000) GS:ffff891ffdfaa000(0000) knlGS:0000000000000000
> > [ 7340.419489] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 7340.420286] CR2: 00007f415bfffd58 CR3: 0000000103f03002 CR4: 0000000000772ef0
> > [ 7340.421237] PKRU: 55555554
> > [ 7340.421623] Call Trace:
> > [ 7340.421987]  <TASK>
> > [ 7340.422309]  ? softleaf_from_pte+0x77/0xa0
> > [ 7340.422855]  swap_pte_batch+0xa7/0x290
> > [ 7340.423363]  zap_nonpresent_ptes.constprop.0.isra.0+0xd1/0x270
> > [ 7340.424102]  zap_pte_range+0x281/0x580
> > [ 7340.424607]  zap_pmd_range.isra.0+0xc9/0x240
> > [ 7340.425177]  unmap_page_range+0x24d/0x420
> > [ 7340.425714]  unmap_vmas+0xa1/0x180
> > [ 7340.426185]  exit_mmap+0xe1/0x3b0
> > [ 7340.426644]  __mmput+0x41/0x150
> > [ 7340.427098]  exit_mm+0xb1/0x110
> > [ 7340.427539]  do_exit+0x1b2/0x460
> > [ 7340.427992]  do_group_exit+0x2d/0xc0
> > [ 7340.428477]  get_signal+0x79d/0x7e0
> > [ 7340.428957]  arch_do_signal_or_restart+0x34/0x100
> > [ 7340.429571]  exit_to_user_mode_loop+0x8e/0x4c0
> > [ 7340.430159]  do_syscall_64+0x188/0x6b0
> > [ 7340.430672]  ? __do_sys_clone3+0xd9/0x120
> > [ 7340.431212]  ? switch_fpu_return+0x4e/0xd0
> > [ 7340.431761]  ? arch_exit_to_user_mode_prepare.isra.0+0xa1/0xc0
> > [ 7340.432498]  ? do_syscall_64+0xbb/0x6b0
> > [ 7340.433015]  ? __handle_mm_fault+0x445/0x690
> > [ 7340.433582]  ? count_memcg_events+0xd6/0x210
> > [ 7340.434151]  ? handle_mm_fault+0x212/0x340
> > [ 7340.434697]  ? do_user_addr_fault+0x2b4/0x7b0
> > [ 7340.435271]  ? clear_bhb_loop+0x30/0x80
> > [ 7340.435788]  ? clear_bhb_loop+0x30/0x80
> > [ 7340.436299]  ? clear_bhb_loop+0x30/0x80
> > [ 7340.436812]  ? clear_bhb_loop+0x30/0x80
> > [ 7340.437323]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [ 7340.437973] RIP: 0033:0x7f4161b14169
> > [ 7340.438468] Code: Unable to access opcode bytes at 0x7f4161b1413f.
> > [ 7340.439242] RSP: 002b:00007ffc6ebfa770 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> > [ 7340.440173] RAX: fffffffffffffe00 RBX: 00000000000005a1 RCX: 00007f4161b14169
> > [ 7340.441061] RDX: 00000000000005a1 RSI: 0000000000000109 RDI: 00007f415bfff990
> > [ 7340.441943] RBP: 00007ffc6ebfa7a0 R08: 0000000000000000 R09: 00000000ffffffff
> > [ 7340.442824] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > [ 7340.443707] R13: 0000000000000000 R14: 00007f415bfff990 R15: 00007f415bfff6c0
> > [ 7340.444586]  </TASK>
> > [ 7340.444922] Modules linked in: rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency_common skx_edac_common nfit libnvdimm kvm_intel vfat fat kvm snd_pcm irqbypass rapl iTCO_wdt snd_timer intel_pmc_bxt iTCO_vendor_support snd ixgbevf virtio_net soundcore i2c_i801 pcspkr libeth_xdp net_failover i2c_smbus lpc_ich failover libeth virtio_balloon joydev 9p fuse loop zram lz4hc_compress lz4_compress 9pnet_virtio 9pnet netfs ghash_clmulni_intel serio_raw qemu_fw_cfg
> > [ 7340.449650] ---[ end trace 0000000000000000 ]---
> > 
> > The issue can be fixed in all in-tree drivers, but we cannot just trust OOT
> > drivers to not do this. Therefore, make tailroom a signed int and produce a
> > warning when it is negative to prevent such mistakes in the future.
> > 
> > The issue can also be easily reproduced with ice driver, by applying
> > the following diff to xskxceiver and enjoying a kernel panic in xdpdrv mode:
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > index 5af28f359cfd..042d587fa7ef 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > @@ -2541,8 +2541,8 @@ int testapp_adjust_tail_grow_mb(struct test_spec *test)
> >  {
> >         test->mtu = MAX_ETH_JUMBO_SIZE;
> >         /* Grow by (frag_size - last_frag_Size) - 1 to stay inside the last fragment */
> > -       return testapp_adjust_tail(test, (XSK_UMEM__MAX_FRAME_SIZE / 2) - 1,
> > -                                  XSK_UMEM__LARGE_FRAME_SIZE * 2);
> > +       return testapp_adjust_tail(test, XSK_UMEM__MAX_FRAME_SIZE * 100,
> > +                                  6912);
> >  }
> > 
> >  int testapp_tx_queue_consumer(struct test_spec *test)
> > 
> > If we print out the values involved in the tailroom calculation:
> > 
> > tailroom = rxq->frag_size - skb_frag_size(frag) - skb_frag_off(frag);
> > 
> > 4294967040 = 3456 - 3456 - 256
> > 
> > I personally reproduced and verified the issue in ice and i40e,
> > aside from WiP ixgbevf implementation.
> 
> May I ask what was the testing approach against ice on your side?  When I
> run test_xsk.sh against tree with your series applied, I get a panic shown
> below [1]. This comes from a test that modifies descriptor count on rings
> and the trick is that it might be passing when running as a standalone
> test but in the test suite it causes problems. It comes from a fact that
> we copy xdp_rxq between old and new ice_rx_ring, core sees the xdp_rxq
> already registered, does unregister by itself but it bails out on
> page_pool pointer being invalid (as these two xdp_rxqs pointed to same pp
> and it got destroyed). So small diff below [0] allows me to go through
> xskxceiver test suite executed from test_xsk.sh.
>

Thanks for looking into this. I usually do skip non-CI tests (considering how 
skb mode is now), and additionally run 9K + tail growing tests, so I did 
(perhaps wrongfully) skip ring size tests.

Your fix seems like the best option for now, though I would add 
xdp_rxq_info_detach_mem_model() before the unreg too, to minimize potential side 
effects from ring duplication.

Will add this to v4, and run the full xskxceiver suite.

> Thanks,
> MF
> 
> [0]:
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 969d4f8f9c02..06986adb2005 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3328,6 +3328,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
>  		rx_rings[i].cached_phctime = pf->ptp.cached_phc_time;
>  		rx_rings[i].desc = NULL;
>  		rx_rings[i].xdp_buf = NULL;
> +		xdp_rxq_info_unreg(&rx_rings[i].xdp_rxq);
>  
>  		/* this is to allow wr32 to have something to write to
>  		 * during early allocation of Rx buffers
> 
> [1]:
> [ 2596.560462] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [ 2596.568466] #PF: supervisor read access in kernel mode
> [ 2596.574686] #PF: error_code(0x0000) - not-present page
> [ 2596.580942] PGD 118694067 P4D 0
> [ 2596.585322] Oops: Oops: 0000 [#1] SMP NOPTI
> [ 2596.590694] CPU: 2 UID: 0 PID: 5117 Comm: xskxceiver Tainted: G    B   W  O        6.19.0+ #198 PREEMPT(full)
> [ 2596.602065] Tainted: [B]=BAD_PAGE, [W]=WARN, [O]=OOT_MODULE
> [ 2596.609049] Hardware name: Intel Corporation M50CYP2SBSTD/M50CYP2SBSTD, BIOS SE5C620.86B.01.01.0004.2110190142 10/19/2021
> [ 2596.621632] RIP: 0010:xdp_unreg_mem_model+0x86/0xc0
> [ 2596.628195] Code: 0f 44 d7 f6 c2 01 75 37 41 0f b7 4c 24 16 48 89 ce 48 f7 de 3b 5c 32 04 75 1d 48 89 d3 48 29 cb 48 85 d2 74 2f e8 9a 9e 4c ff <48> 8b 7b 08 5b 5d 41 5c e9 6d eb 00 00 48 8b 12 f6 c2 01 74 d5 48
> [ 2596.650847] RSP: 0018:ffa000001ffe3a90 EFLAGS: 00010246
> [ 2596.658128] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ff1100808e308ea1
> [ 2596.667403] RDX: ff1100808e308ea1 RSI: 00000000000001cc RDI: ff11000130150000
> [ 2596.676719] RBP: 0000000000000000 R08: 0000000000001000 R09: 0000000000000001
> [ 2596.686060] R10: ff1100011084a2c0 R11: 0000000000000000 R12: ff1100011541ce40
> [ 2596.695445] R13: 0000000000001000 R14: 0000000000000000 R15: 0000000000000000
> [ 2596.704866] FS:  00007f6044013c40(0000) GS:ff11007efbb1b000(0000) knlGS:0000000000000000
> [ 2596.715336] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2596.723510] CR2: 0000000000000008 CR3: 00000001e9052004 CR4: 0000000000773ef0
> [ 2596.733162] PKRU: 55555554
> [ 2596.738407] Call Trace:
> [ 2596.743398]  <TASK>
> [ 2596.748045]  __xdp_rxq_info_reg+0xb7/0xf0
> [ 2596.755108]  ice_vsi_cfg_rxq+0x668/0x6b0 [ice]
> [ 2596.762499]  ice_vsi_cfg_rxqs+0x29/0x80 [ice]
> [ 2596.769555]  ice_up+0xe/0x30 [ice]
> [ 2596.775673]  ice_set_ringparam+0x662/0x7e0 [ice]
> [ 2596.783066]  ethtool_set_ringparam+0xb3/0x110
> [ 2596.790189]  __dev_ethtool+0x1200/0x2d90
> [ 2596.796916]  ? update_se+0xc1/0x120
> [ 2596.803224]  ? update_load_avg+0x73/0x220
> [ 2596.810079]  ? xas_load+0x9/0xc0
> [ 2596.816172]  ? xa_load+0x71/0xb0
> [ 2596.822273]  ? avc_has_extended_perms+0xcf/0x4a0
> [ 2596.829822]  ? __kmalloc_cache_noprof+0x11a/0x400
> [ 2596.837493]  dev_ethtool+0xa6/0x170
> [ 2596.843976]  dev_ioctl+0x2d9/0x510
> [ 2596.850388]  sock_do_ioctl+0xa8/0x110
> [ 2596.857078]  sock_ioctl+0x234/0x320
> [ 2596.863614]  __x64_sys_ioctl+0x92/0xe0
> [ 2596.870444]  do_syscall_64+0xa4/0xc80
> [ 2596.877212]  entry_SYSCALL_64_after_hwframe+0x71/0x79
> [ 2596.885426] RIP: 0033:0x7f6043f24e1d
> [ 2596.892186] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> [ 2596.917864] RSP: 002b:00007ffd329f5e50 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [ 2596.929028] RAX: ffffffffffffffda RBX: 00007ffd329f6208 RCX: 00007f6043f24e1d
> [ 2596.939757] RDX: 00007ffd329f5ed0 RSI: 0000000000008946 RDI: 0000000000000013
> [ 2596.950460] RBP: 00007ffd329f5ea0 R08: 0000000000000000 R09: 0000000000000007
> [ 2596.961597] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
> [ 2596.972256] R13: 0000000000000000 R14: 000055a88e016338 R15: 00007f6044100000
> [ 2596.982917]  </TASK>
> [ 2596.988534] Modules linked in: ice(O) ipmi_ssif 8021q garp stp mrp llc intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp nls_iso8859_1 kvm_intel kvm irqbypass mei_me ioatdma mei wmi dca ipmi_si ipmi_msghandler acpi_power_meter acpi_pad input_leds hid_generic ghash_clmulni_intel idpf i40e libeth_xdp libeth ahci libie libie_fwlog libie_adminq libahci aesni_intel gf128mul [last unloaded: irdma]
> [ 2597.040161] CR2: 0000000000000008
> [ 2597.046911] ---[ end trace 0000000000000000 ]---
> [ 2597.117161] RIP: 0010:xdp_unreg_mem_model+0x86/0xc0
> [ 2597.125432] Code: 0f 44 d7 f6 c2 01 75 37 41 0f b7 4c 24 16 48 89 ce 48 f7 de 3b 5c 32 04 75 1d 48 89 d3 48 29 cb 48 85 d2 74 2f e8 9a 9e 4c ff <48> 8b 7b 08 5b 5d 41 5c e9 6d eb 00 00 48 8b 12 f6 c2 01 74 d5 48
> [ 2597.151379] RSP: 0018:ffa000001ffe3a90 EFLAGS: 00010246
> [ 2597.160243] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ff1100808e308ea1
> [ 2597.171798] RDX: ff1100808e308ea1 RSI: 00000000000001cc RDI: ff11000130150000
> [ 2597.182587] RBP: 0000000000000000 R08: 0000000000001000 R09: 0000000000000001
> [ 2597.193333] R10: ff1100011084a2c0 R11: 0000000000000000 R12: ff1100011541ce40
> [ 2597.204055] R13: 0000000000001000 R14: 0000000000000000 R15: 0000000000000000
> [ 2597.214732] FS:  00007f6044013c40(0000) GS:ff11007efbb1b000(0000) knlGS:0000000000000000
> [ 2597.226440] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2597.235842] CR2: 0000000000000008 CR3: 00000001e9052004 CR4: 0000000000773ef0
> [ 2597.246692] PKRU: 55555554
> [ 2597.253088] note: xskxceiver[5117] exited with irqs disabled
> 
> > 
> > v3->v2:
> > * unregister XDP RxQ info for subfunction in ice
> > * remove rx_buf_len variable in ice
> > * add missing ifdefed empty definition xsk_pool_get_rx_frag_step()
> > * move xsk_pool_get_rx_frag_step() call from idpf to libeth
> > * simplify conditions when determining frag_size in idpf
> > * correctly init xdp_frame_sz for non-main VSI in i40e
> > 
> > v1->v2:
> > * add modulo to calculate offset within chunk
> > * add helper for AF_XDP ZC queues
> > * fix the problem in ZC mode in i40e, ice and idpf
> > * verify solution in i40e
> > * fix RxQ info registering in i40e
> > * fix splitq handling in idpf
> > * do not use word truesize unless the value used is named trusize
> > 
> > Larysa Zaremba (9):
> >   xdp: use modulo operation to calculate XDP frag tailroom
> >   xsk: introduce helper to determine rxq->frag_size
> >   ice: fix rxq info registering in mbuf packets
> >   ice: change XDP RxQ frag_size from DMA write length to xdp.frame_sz
> >   i40e: fix registering XDP RxQ info
> >   i40e: use xdp.frame_sz as XDP RxQ info frag_size
> >   libeth, idpf: use truesize as XDP RxQ info frag_size
> >   net: enetc: use truesize as XDP RxQ info frag_size
> >   xdp: produce a warning when calculated tailroom is negative
> > 
> >  drivers/net/ethernet/freescale/enetc/enetc.c |  2 +-
> >  drivers/net/ethernet/intel/i40e/i40e_main.c  | 40 +++++++++++---------
> >  drivers/net/ethernet/intel/i40e/i40e_txrx.c  |  5 ++-
> >  drivers/net/ethernet/intel/ice/ice_base.c    | 33 +++++-----------
> >  drivers/net/ethernet/intel/ice/ice_txrx.c    |  3 +-
> >  drivers/net/ethernet/intel/ice/ice_xsk.c     |  3 ++
> >  drivers/net/ethernet/intel/idpf/xdp.c        |  6 ++-
> >  drivers/net/ethernet/intel/idpf/xsk.c        |  1 +
> >  drivers/net/ethernet/intel/libeth/xsk.c      |  1 +
> >  include/net/libeth/xsk.h                     |  3 ++
> >  include/net/xdp_sock_drv.h                   | 10 +++++
> >  net/core/filter.c                            |  6 ++-
> >  12 files changed, 66 insertions(+), 47 deletions(-)
> > 
> > -- 
> > 2.52.0
> > 

