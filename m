Return-Path: <netdev+bounces-259027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OORuGh1olGlFDgIAu9opvQ
	(envelope-from <netdev+bounces-259027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:07:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F160614C630
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ACE630396BB
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F415E3382DB;
	Tue, 17 Feb 2026 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEVNY9bq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E4C29AB15;
	Tue, 17 Feb 2026 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333404; cv=fail; b=WLBWSloPHx24gqVbm74YLploYokc7cxJXVagh3lhY82/yDDa32OkbqodEr/UBtkr24JHO9YLJi3yT8+L4HQxyJpmMxvnDyJkMJM5KaQteD/EkEh04i5fDXapLalcXpOQeI/oEUpX2+1NBdXfw7IQAWT5cGLKGgpw8RuB09zX/IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333404; c=relaxed/simple;
	bh=GblqocFWWCbBQo61ih/4u2YzrSlq9qzRsnblgzt/LHU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AxqBo46eulPka/cUQj4DY6tKMyPz302fZLIFPsr8SYN6GqJVRFlnt3Q9h6+MUMhb7d3mOQEEfjNgMFcz7AxiSjdoe8TO9ofhsvbmYaRw2l4iFVYQ2CN/OaYK0/7lTkgsWMtF5uvUpdox1aavW2miu57a1ym1XRmufEJmunkueiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEVNY9bq; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771333404; x=1802869404;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GblqocFWWCbBQo61ih/4u2YzrSlq9qzRsnblgzt/LHU=;
  b=ZEVNY9bqUKkVzBu4IHRngK0WQawQM/ZISIU6ZkQkRwVxrCMBAij6i6gh
   OyCvze+fyWSaABOQ5oMVII1ay1cVbr6cXoKwkhyUtHdfn234soDYBbKFf
   x3thOXj+w3JpypJJyCwJlPeKJQ7TUfAMLrsjsgJbGgjrJ9SfiRl2HqJLR
   qz8KfcPhgUxTqh5BTRT/LgXh4lVX6E5ENYurKavf/YPg1hkD2YTGxy3Wo
   r9qp4rJOQ6gc+cEiMO47jSPsdQK6Yx2R35alYnM3cxgmsLxOsKT7Pr3dn
   d4HMyNRaCalMckW0jCJlWFArwLR2gfz8+lerfF+XH9SRI2CABgv8EjoSs
   A==;
X-CSE-ConnectionGUID: I40RQcfmRjaLmI00fg+l/Q==
X-CSE-MsgGUID: lPy513OsTLGTghW0Bc0m0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72391204"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="72391204"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 05:03:23 -0800
X-CSE-ConnectionGUID: nWUAMib5R2uJFeI/iKGebw==
X-CSE-MsgGUID: 1HEhmCJ/Ry+JKw6zkHeemg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="218881709"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 05:03:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 05:03:23 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 05:03:23 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 05:03:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbmidR0XoRqkUuSTSEoGo89S3OoAxi7dTq+OrZsiM4MI0AUzlhIEsHXjO0OlOiurbIo83QEWMnStuxvrVlvaRv6X+FOMKH5eLkEGLAYvmih3hN34VWNwLjP8L+nQogNa4KaPA3tTpob9DLBNBzTTv5VT5zJP86U76XGHmp3aTFU81kYJFgY1pdShGTgB7iAmDLc2lbPKooWsY0y4bS1PX0Qp7Ai7/tN67A1kXXGfgxEOot3J1ikfVvNDBE0FsiaIwSIzvFdVBOIpAP4+Lh3UkHPMqJ8xC+m6kJKZ4fMyrfyV0SjJOZ9ohqfTp3/ggcy4JCrE8DXPguYZBxGG7u2zog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlV3HW1R62//0zQqq6T6vOHS0RdjLN1Fq2GPBKJ3bAQ=;
 b=RRzsDyfTiVm69G3vO60ZtIWeEyMaAw9od6nO/uwVgTPODZZEuQK1v8vCxe2Y+PGFKH+P9KPzkb0AVV3Q8g9fZatFw6Ehg9Tpi6/EtbI8SNYtZRjCf1Vk02hVxmOe6jsF3xtoONp+BYnjesBBS3uVsWt/0c1UQ3wpaydO6uHpIPCpBCoH7CJd8XKTeWfeufcZD4C8b+siQxBPwVItjqyS6OYaDky4HTbPsD08vJOvLyqMEr6/pvqwa5PaK7TOaeozIW5euDre4pkJXM5kCo4iksBEDpVbIWY04aU8DGV9sueDYTV99WB7pLPG1XGJIfA0dFSyG5waVLhtJKroPC4H5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB8320.namprd11.prod.outlook.com (2603:10b6:806:37c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.16; Tue, 17 Feb 2026 13:03:18 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 13:03:18 +0000
Date: Tue, 17 Feb 2026 14:03:08 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>
CC: <bpf@vger.kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: fix selftest/xsk single test selection
Message-ID: <aZRnDPYs7Xm6KjvK@boxer>
References: <20260217080326.50564-1-mahdifrmz@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260217080326.50564-1-mahdifrmz@gmail.com>
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b907f85-fce9-4121-4933-08de6e24eb78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H9VnWVJFwwLWWDGKy3Z6Mof8j4ameOf0KXfq0Dshe7bzDqPGM26eP/zJljJ5?=
 =?us-ascii?Q?9QJE4c7jTFE0SFt53xTFqIVMU2dIj/KYue+UfmyDqzBkDdNSQu6zixrncqaa?=
 =?us-ascii?Q?HrlynZmfVRP4RGZFvKEQQobeMZKxH89ycTKmsTOjdHGbWeCG31IhfmKgmsLh?=
 =?us-ascii?Q?ySN6loJZQNCJn8AsWC77AnfRL/ViO1MAluZHswyXhSysMlzD07xnSpRaWd/v?=
 =?us-ascii?Q?y5k81g32i4CUhuRm1gtuie5Y35v1Dvub5ieMqxz7xD8Px5ydm5AdMPckkldR?=
 =?us-ascii?Q?nWIRDrYCdBDtyKvz7JpNzo3ohuM9r5vBq1rNqGl2MRvdqXlDNLELl/TQVqjf?=
 =?us-ascii?Q?GoGsgAQbECiP0stcPuYs/hzIkVeTQAEBrFxBCp70QfqSfj8QQNd6qmylLkZb?=
 =?us-ascii?Q?IZvo1gnFG5y0IOg8MQvcBZvVRA79l1Ngd67acSeBsXFpHAc18bJtOwZUFfhh?=
 =?us-ascii?Q?GVkKW9V0C4/fsU4GsNPuol0M3pajZD42K5Z2KARvRy7swYYxJrEU7Wvr2CaZ?=
 =?us-ascii?Q?kdJkPswCOyCd/hnhAXiGOJtsyhh+3tIWHtxXEQphl/Ehqxt5C2OkFyspeUF/?=
 =?us-ascii?Q?/Lqa4foff+uMzrs741zp4mVbClvcCnZNAcVgMlZ/cAP4t4LqDO84wuPbAW+q?=
 =?us-ascii?Q?TEKuWEMiKlRZcLy95dLMiVAfDbJC23xHIQkCIilgqesQ+WCnvg4A02fpSrLl?=
 =?us-ascii?Q?cdw+3KPfBB3weBYJicDqN+5Q8AZtMFCbfSCdoLgx4iKMaS6CH7WtSCRhlJR0?=
 =?us-ascii?Q?Q3uy7QVcLRy/QfOB4GBhH9AgEimfb9UAJgxURJRkdMw8jUO52g+iEPdIpM1h?=
 =?us-ascii?Q?FOzJLMcKN4r9YJO5jjpCSJ/EGjuiSC/ZPDtUOaU4Uk2+oErW3vsK+nFWrvJp?=
 =?us-ascii?Q?km1YD4Y9e8BZmdkWyuoAMbf0NybRVtZpXWE5ovucGkrIGEbxIy7Z/32wtNVS?=
 =?us-ascii?Q?C2o0W0cCdtZHlAzZQ3yldt1dpg3qCw4j4JqnATHlu8EccjOY2u+N3TqRo/S/?=
 =?us-ascii?Q?osVl+sGzg/rsI179WA6fN/eSYm/lLlLNfoY5nf1v/aHOiaCHzAqdABGvBN7V?=
 =?us-ascii?Q?0WbhMNmOCN9xi0aiWBTWqNoRwy87oSkNxU9ty8MwDnHuRdDUuT5ij2m72Xzz?=
 =?us-ascii?Q?ZsWLD5MSToKfw6AfPMBYpKOvgG7lkzt/wBwEgeXJcUZ53Ml2BYhhbN4qFn59?=
 =?us-ascii?Q?R6cZxMz3Z+oRRXLH61IvhIiuecEufNThzrhWKAADIE2UFxPC2C8KXypG6UD0?=
 =?us-ascii?Q?UOKarULNxuU96/i7HxjQZ9tGr2Gue/Z3NQU6FSYF3YbeC4Kydmf+U68Xh4CU?=
 =?us-ascii?Q?hcWzWyHz6UugJmPu1uohLJtliF1X0kfZOZToNCpxFq++FWl0uwtdOGstIQ7G?=
 =?us-ascii?Q?Npgiyrzq1dBlwpdUlA6BE6jCeVFY9ilkKjm95fgBH/BgS7W/H5MFHGogVX95?=
 =?us-ascii?Q?gtLBjJuIlRiAzoa0wPhVLL8DfnxHNqP59useYnqFcpgNv1CFYwM1JTAeHOlP?=
 =?us-ascii?Q?Fpd5g5WcX6HeQdCUw2iFSvrQw8hS4Hciff0fLjN3Fgg+aphTUO94r+P8CZWr?=
 =?us-ascii?Q?H+Hq5TqLt4Jb5fXltY4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qLQlu3yAkW3BQurWaomXiU2Sxwj/UaZB3DvlfYcUd9zBggN9fn/lBNQoBMa/?=
 =?us-ascii?Q?n32MLuKVYcjZdpv0+txSVK3R5H1ZL1sF/ZQvYFYkNWnV1M2KDvDlOuZpkSM0?=
 =?us-ascii?Q?kh02h2SLlv7HTgSAANp9CEdQFMvYj5FN57EbTacR7q5umfku3RBpzFk6hiNv?=
 =?us-ascii?Q?EyYWMLdjdPcYPno7TjmDd569OzUw+IySBDQO8fH18zQb8G9zb1flSMBXtjj2?=
 =?us-ascii?Q?eHUaozEj8JUtHCxdpBBoI4NUpaVTHfMVYkx3yfV/yEgibH9jjzVTL6b2tMI9?=
 =?us-ascii?Q?qCC4F9Td7FycYcroIxyc4NtdqtlJJ9SD0ItaTxHHCMFrfNWZ2Jz9EjLOBNzm?=
 =?us-ascii?Q?vkx60+bSo1vdgbjZbGDmyVoTTFHn3zunCFDdh2N9/DfJFuiP9jy90q3opWx/?=
 =?us-ascii?Q?c1E0ND8VHe+CilgbDTWX9d+iKV92/gwIAF6twawg8pLFe3m/yfHjF/Ea9XqF?=
 =?us-ascii?Q?ZZuoqhRl5spNVYUIb7yrYNrqyxzg1e9/JWjhWVnYeopKzk2Tek3nIxPU1tfR?=
 =?us-ascii?Q?Tjp4fK/+SVeSr5v7IXyRklv9aA1iezUvFv0B1VvVbJirvluvaiaCFQapiIpP?=
 =?us-ascii?Q?g1qbIiu5Zx6kRVOEzag9Bh2uUIwVOLnGqkZwxV/x2c6oxrKursDOds1UuDdl?=
 =?us-ascii?Q?/7kUG0NiY9pa+T2LG1boVCsBegRhGh7jFCOiE5EmnnCU8mtO5ST+aJ3iifhz?=
 =?us-ascii?Q?J1Zvm+hxdPxFPWg8oc49B3x5dW82a07uGVYYJWU88nW0LaacbbwSjo+a0ke2?=
 =?us-ascii?Q?rBlQeEtWFn/bjKXRCeg8hDn9NgVQ6thxWM/gg/RGD386785WZ/tO72u5EJXI?=
 =?us-ascii?Q?a1SrYrUlCVaj7RZ7YRrP9jIRgtQu34q7c17rBkpjMqeCY3KfHaLmyabkik4I?=
 =?us-ascii?Q?cRNr59aHslGboNpznUXp5x3TLjFGbTCj809KGMO3zMhuAEwAyGCR5ml0Nwae?=
 =?us-ascii?Q?G56IhkVV3npbE+I3q43YAza39mhQO0vbOfAADLseBA7++1XWlUIFZ929zp2z?=
 =?us-ascii?Q?eVVEMAxN4CMWz9dCWYR5drx8DV2krpPw1Y3FBWpBZz7Bc7/y7Zvg+2NLNA5n?=
 =?us-ascii?Q?+5wP1yvheC1SYTv2DeRcuEku8ixqT4aw21do4ZoGIHMQJsRlH0u7O65e1lTs?=
 =?us-ascii?Q?+XeAVngbAYpObhDx9PPwIpoAbbjx/6AcbKQKtm/OxLUUS973A519ppHHvnKO?=
 =?us-ascii?Q?T26bAwI+ohgXumCIVR6kOxs3kRkNEcwp2SSxT3A6nuVYy/5GFaVmh8sDdyds?=
 =?us-ascii?Q?BQL2GEJen9qhV1ckksSdY1j66hjklQkl8CHyl/axYll74ER68oab0E+DYrAw?=
 =?us-ascii?Q?7JCqGeP/Ylvr3SPWN2FLjx2eegBza7AQ+cfzOLpBDT2uYe4RpGcNgQyj8y71?=
 =?us-ascii?Q?hUdssj6xD7PjfEl3LrluES834Mw+gnWWiA0T0N/yC8puFSwI+rrmNspMrep4?=
 =?us-ascii?Q?V7NdR6qOflX71z/Y8rLJM+vFqP5YPLLY4GL3801psgVOZ2vqvPjRAldi+A7c?=
 =?us-ascii?Q?XZJ/z7YrrAnxDtMCYTscpKkXTIV03mL6bYStHKSlesvvtdOKS5v/zRNs2gPm?=
 =?us-ascii?Q?VZt6oZjFB+VgCPOSfooIcChLNtxhVRS1ZphxwXPDbviCvq9jafCE4IjARG4t?=
 =?us-ascii?Q?1fl3FXjVpGlcgFJepOzbQBLrK6tWkY/FXyGPzDHgtYFreI4D8ZYGvebkRRUG?=
 =?us-ascii?Q?4qJoXOBElCCUQnny8ay8op5VyaQVdGHYoP2fmpxBy4NK8FT0HPsLVA2GhVtD?=
 =?us-ascii?Q?kYo4keE9KNk42U5ZZNHF9ZxVdbzmXlI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b907f85-fce9-4121-4933-08de6e24eb78
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 13:03:18.2782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfShC3bo/0jOds0BclfTDhzvBpsRJqDg0YDT7pRtnSiXT8o9xvGJWE6uuBXEHaGyITysXMli0LW3wtaYGQYR4f1QIOhlvMMtIXBft2Ve0Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8320
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259027-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[man7.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,fomichev.me,kernel.org,gmail.com,iogearbox.net,linux.dev,google.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: F160614C630
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:33:26AM +0330, Mahdi Faramarzpour wrote:
> From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> 
> This commit fixes the integer parsing of -t option. The cli parser
> only relies on errno to detect parsing errors. The manpage for
> strtol (https://man7.org/linux/man-pages/man3/strtol.3.html)
> states that the said function "MAY" set errno to EINVAL in case the
> conversion fails. Currently on some systems, this leads to a silent
> failure with return value not being exactly documented in the
> manpages (probably zero). The reliable way to validate the input is
> to check whether the endptr has been bumped all the way to the end
> of the string or not.
> 
> Signd-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> Fixes: 146e30554a53 ("selftests/xsk: add option to run single test")

Hi Mahdi, selftests related patches are supposed to be routed via
bpf-next tree. Also your SoB line should be last in the set of tags.

> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 05b3cebc5..f2d5c4dd2 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -247,9 +247,10 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
>  			opt_print_tests = true;
>  			break;
>  		case 't':
> +			char *eptr;
>  			errno = 0;
> -			opt_run_test = strtol(optarg, NULL, 0);
> -			if (errno)
> +			opt_run_test = strtol(optarg, &eptr, 0);
> +			if (errno || *eptr)
>  				print_usage(argv);
>  			break;
>  		case 'h':
> -- 
> 2.34.1
> 

