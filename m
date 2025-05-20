Return-Path: <netdev+bounces-191712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 212EAABCD5E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF16417B180
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BDC2566E7;
	Tue, 20 May 2025 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdsnkiKN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA08719EEBF;
	Tue, 20 May 2025 02:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747708967; cv=fail; b=WtbNWYUxHOrlGeFFZ3OukgXQvCeEBaeIg8d7DGvIN1jdrEBkbsiwUPv9M9BXlBjDSTtABdEUv453ApRLd3WCVGM+T+DFRL3CPC1KbjiPXMmAGUUcPCBdoIWeWf1iJfh5uFezz94+TJNPpdP83Wc14C+HIFptXP7t7Rx1YOAIODc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747708967; c=relaxed/simple;
	bh=GERwUK6xdviqxz0t2INNVQX+UGd+O/LvqQEQwJIPLZA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NU8jYCnVxc+exdz/8YAys7lOVLvPQRoO4L1xmrti8v7rSMXUQ4+YSKS5NcSQAPI2friIeuuHdhbESk6t7tWtJyhw+Lc1kjHq4vkKLv+Rz5fwXB5xx9YCiEin4pMkRSrj2/0D6P8QKJqR6ytSFo/eppdumzDY14f11426/FbKT64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BdsnkiKN; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747708966; x=1779244966;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GERwUK6xdviqxz0t2INNVQX+UGd+O/LvqQEQwJIPLZA=;
  b=BdsnkiKNWL9f8tJdkm1at4Hd25hwtVXzMOYMk1gvPZGKGq9XfB2JbOLT
   c6d0etbjknxcVjfMBRFn7SABTNlJA44Cezjo+y7T0ghSbZd9DJAbDINQA
   lUpG4ValCz5Ct1CUlVI5tc7HJlwZL8mGidZdl4MPzkEYR/lG8aEQVSD4h
   bL6FDmg54YobJ+twBK5U69RIw7PjgpDo9LHOVbnxaiCdmGB8Qc/W6gOwQ
   EW7KA9AXZFzcucYoOIILlTjrIWKbu+s1fQaTKSG3tV3w1XK6zWgoWRN8a
   FrbcCxkhojREGWvwcbnyuffE90jeD43I6mZknNvsReD3boLrvT9FefVEX
   w==;
X-CSE-ConnectionGUID: G7I8Ig97RIyoL+OivmcaqA==
X-CSE-MsgGUID: 84kz6rDFSCOI9Sb5OEOpLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="67179780"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="67179780"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:42:45 -0700
X-CSE-ConnectionGUID: smPWhPgQTbmKHisqMVrOIg==
X-CSE-MsgGUID: ssdtf23rQiCQ5feI9Jfz0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="176668335"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:42:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 19:42:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 19:42:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 19:42:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADo+aDxiQZoHHWWbe8dd2upOiH53G8tBPC/TsndrNjsVRoN7sACY+ldmKasq9VMnPcG4HntMNc40ohkiMiYe6SshSreH6AJ7I8Rw+zfQUYbGXPm0TQsP8AgrXRHzk0XAdGBVI3wM8XRuuvfu2p0Hi0/HnL+vBuUkdnAq17sfKIhDhtvCtrHuE4+ztAqaL44jpuYqRpKJVt3SRNQi04XXcTd7F/fGVSIGcB+9Xk0InkAyBZ9xjRC0Q+vmsJfTu5Ik4TjqCHPVQRD8bD8Sk444tsWMPIMKQlaHzux7Qqtac5+gALH+fzVxp/22QQWYWrmaO8EaaNme/uLR5EM1QMShlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pTzvQmf6wPhmpyjOnVpAhUrwuEnBkSzHKWIiUK9CvM=;
 b=Ui/kOylWb/5kwadoU8tI2AMzjwiV6eedbOaxN19bUJ5Mttw606uwlT0TwVEJpkpUIJMVvj7fqRj4ay9o1WBm48CaAYOAOdVHHPsiW52PX/qTgbwHZhSOB7keBJEBDby9qlW9g+MSq1MoB5z8+RrsAmoxp6OvWd/G5L7t7EpQDqSLJND3CSvCUghr3Ph8MOnOItVglt3/mXASGvK13hJJH2OKeoWMjBE34DVoOzzRIpSdV9x7EAhAqQV9D9F4ZRvz+geBnE5KoDDtkcNEcgFt93KAZrMrvQBHWytdhcj1WYdXAI27u2NKZCgCQGAA0BrGAMsA8Cu45cGeg3tLZqouLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 02:42:41 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 02:42:41 +0000
Date: Mon, 19 May 2025 19:42:37 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 03/22] cxl: Move pci generic code
Message-ID: <aCvsHR8a0AFL9UMH@aschofie-mobl2.lan>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-4-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::9) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DM4PR11MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: fc128c30-a1a1-40ee-939a-08dd9747fd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HwU0HkObmTJVOXCddTr4zboSVfwRI8/Uck0N1a9g1SG0kybTZisf/fdvEBAk?=
 =?us-ascii?Q?sqwzhyMZKxVXt7/oBns4DFCrjmGe4La8jOcjPmsAePIpuyCI2AW4mlsbdX+K?=
 =?us-ascii?Q?Xb1CpsCZAb93tF+Bov8OllAKQnpEqTlKVGqC6SL6gxiA/fZhYXs48rTqT4iN?=
 =?us-ascii?Q?qkFsrVoUw5B1pqQ3K7Sh8FYVNXPS0OlUSq/W4AvyA+OjgzVrsFj8gmXayJZC?=
 =?us-ascii?Q?fm5qOhh0S6Bzs0Se6Czn1L4g5Z+mLn7dCzJOzGjSw2dCZyaiHx7Zi1fMbDky?=
 =?us-ascii?Q?18dAQQe38Ovf8G/gEmfNhf9RLx0Es4CezeFUBCmjh0FEYlZQjcr+K78P4l+U?=
 =?us-ascii?Q?9Ht3yP9bdkq5d91A7EtYtJbiFy3rcttgo7arcTxRHYpllVFJvg7nMFPGvO6Q?=
 =?us-ascii?Q?EJEg7A0CEt3ongNgrX0XmVTOTM2n4P0jIVO1AFe2ij0Nr7+swUVApKxq2b++?=
 =?us-ascii?Q?KzWT6QV1Un2FZhqCSHL9H6G4XMF0BA2R6fkdARgPPydVtL1x13qD9uOvnO57?=
 =?us-ascii?Q?a53LF7n8qtcfgxmOwxsb2PyN0MPstKe9+vz4qiPJbTldiX5nTOcP9DpO9UnX?=
 =?us-ascii?Q?/s8x3Fnr4k52ncOD4HELHW/UWE0Phtfur5jE72t859N1gXg+tnLiP5DM5jz3?=
 =?us-ascii?Q?Vy6WZIYbRvtPfzc4tyWlDuGKD7MpyPD21sK/6jBTQFwOoZwdWCebAFEl4rB2?=
 =?us-ascii?Q?BXBJ6+f1ncqeZgnre7eCbpXlMJgy4rzmV18QP+W1015jVQHFzKg1PqTBKbPa?=
 =?us-ascii?Q?ClPtLON6LqL1CF82WTJa+e2dwWATj838Koe86AQbKlqhV+ZX/JBGvJQtLE9y?=
 =?us-ascii?Q?P1iIP8WzkL/4ZnDgKOI/BbZ1V5PpjWCRflX4oTTrAqqnT5n7rjDUrDe/hxc+?=
 =?us-ascii?Q?28CQYpU5zmnBj/MS/8CcJKYwxys4Zz5i7EJO3jc9fNueZPCLECxN3IkQ3qLV?=
 =?us-ascii?Q?LZgrJ3/bYFYx3DP28Hq4HoIASyPMcXFQdw85EjE1gbV6BbowMZfPKcZlNJGZ?=
 =?us-ascii?Q?OqlMIPfDXzkkX7ip9eUy68Bfy4fjRzNJHehh8fegS8/s+ZulOdeUlPxXw7Df?=
 =?us-ascii?Q?b4IkEpmkJZjyuHNqCo8JCjekxirAu7KFmcdx29A68/G5jXVjXCZ6IaRtQhsc?=
 =?us-ascii?Q?SIy6gCjKG3Y9sIBD2zSJske6AFbpwstXTKwPisDOhtxENeAh5hIwDIFrD/RH?=
 =?us-ascii?Q?5k8CbZTCcRUaf3kg2TqcMRDOmz7B7qcN/jorK/h4GnhQzuVcBVJ1UKm/0HS2?=
 =?us-ascii?Q?zwrbqtAQvV6YELEE2DyUfnT6wD2oZSBAIXGcMLEFe1wzDQF9q2cyaR7zNUMk?=
 =?us-ascii?Q?mKhZiJ9SoPX2myTyTd50rD14kgev6V+q2KKb/pcn3o2m0TChz3ywgTudjGry?=
 =?us-ascii?Q?K2/qaj9LCpHvMPipro37kgpw6J0de8+QoCUj7jrfJ/KpEN6X9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UF8ZvGb181AGuH6GH2PERFOwOHR8r+F0H4CdXkM3iajebu1jC5mUleJD5YCx?=
 =?us-ascii?Q?AnTmJNohOxMlcJSBcpZa+XPJc8xTeOm0462rYoVlzBapfPDborz5b/EoCKej?=
 =?us-ascii?Q?W07d2i+TCYmDVxKgNDUi1xlOHPs1zJ/lE8dfOX5mY9yddK8+mgkDyg4RZWlB?=
 =?us-ascii?Q?WqyF6ubtHPrQw57kBeAwJT8fLuGYmx7E6zlPlCXPXEBlNWq/9tEhKw8HjeQQ?=
 =?us-ascii?Q?jixxpRQEKsabUVC3AbZ/IciuGRc/kaUKC9sLkiugWdBfI9c2zYT68b5G9F1b?=
 =?us-ascii?Q?SrhSDht+h41a1+MIqnTMMd/tY2egiwFFahHzTalpq5ym5EzRLOfi6dUOeulE?=
 =?us-ascii?Q?PZ2YO+l+s7b/4mF6T6Zsj/bkBKpwGMyLsjGUFzfm+ns5luB9rktAC9thrbta?=
 =?us-ascii?Q?hfWcBdRB4KJ0d2ZxGkaMCAiqxeRg2G8w5vQ/D7P3ePWvWHT+I/SVmkwnyBii?=
 =?us-ascii?Q?HFtLVwHyngdYbO6t0QcvcVnWpf4rPWqVEiMrhV7mOHwqDYxuaTwAEhx6h3/g?=
 =?us-ascii?Q?pZAhcUKEDxir0NxSvyYqfOkOj8/MWkp+kt8HLzak/4lFwnlMGhVaMckJmiNS?=
 =?us-ascii?Q?BkHtgoF4TC/0XvlgTCusm4Ibb21gLSv3epDlYxkynCqCBLJZmCHy5r46f7vN?=
 =?us-ascii?Q?NB/MJQc9Muup/31olCvTh43DCvu+lJ4TCzkHL8RDxm8/AK3tQG1od299XlU3?=
 =?us-ascii?Q?JtQvaKov5Me2qE+m2xEJHFzRpIAls58lsgDnO9+KDEvG+6P+kBYHpcWiZy0Y?=
 =?us-ascii?Q?R32OHAInX8uX6fq4g/eL8h55B2pJu21pSy+DvrrgIAW40oh1UTyPykRLxD6d?=
 =?us-ascii?Q?JH361S4SJnvyyBOjOBT1b+Ep4BDMTfD3VF6UmZUtgq9yE3Bhv1GxzP6lhX/k?=
 =?us-ascii?Q?g2GienjXSQhEZ7zcJtu6P0IM05jxBHIBxoDD27Kc2AoqLtnHpJ7l66c9NeDb?=
 =?us-ascii?Q?udknIADRiIY+0BiLwuyiSE0+Hlx30B40Cf991YIwysIBuAi3TKaBCaE8pGtG?=
 =?us-ascii?Q?7h6dYlD6GfP4PoCijhLnPqxxyLIBqPDi/BuvznBPTLspWS3jutjnEnKuTvS0?=
 =?us-ascii?Q?ZUGuOTZxYNQeTzl8ThqO1kg5CbXlnX7BlK8CH2AjZiTBs+OIviePvdv89K5R?=
 =?us-ascii?Q?E3iB2QSogtLiB5X/6jz1gg9DkUz4kVOwz/hkutE4bZ6s4+Y7yoJ4SaPsRA2X?=
 =?us-ascii?Q?rz9TKu/FcQ1mqz/Tdm7Z3AEYC4tTVt+6cqbJlseG94VUDN+zjOn6rnxwF1vH?=
 =?us-ascii?Q?HXxZRtpWHczCsKF+iUzwKzoVftO2RUXwpxam7VUmZGoTuqqXTlST/fJBpVUY?=
 =?us-ascii?Q?D+c7jJaV/dCHai9ZNLznU9G9Km0QpLbfCT1FkUYPNVfBWF6rzPqlVi03B9pP?=
 =?us-ascii?Q?GQ70eO3XRTM44uSkWTl6PdCvKQTorRSEGvmeAo/wG2O8yWYxWzI4NlbY5xEL?=
 =?us-ascii?Q?GLbt4qAn3tuhCAPmC8rYIeJhrgywVuvJwEexynbjZ3Lg+pkTJHEcocOBKGZU?=
 =?us-ascii?Q?PiFVAA4kRnsMtVFxPDfKwCoJKShJWzBxk/7btROgf+mo7EwQSX0zQfaO6upL?=
 =?us-ascii?Q?kupsgAp+a6iWstakM7DHzXBBt2E1vFkvUIZGAxTC+s7SlsJT/5eMg7DBZqO6?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc128c30-a1a1-40ee-939a-08dd9747fd78
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 02:42:40.9711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmF0vtOcMQcsKLArdtrNMKoU4Sz7wITTBKTTpMIZ9kTvfYQ3SrG/8dFxFsUkEBPGpUgsTU7iyYzg29wilVkQKo67yMa/+ALIq44GJPkwyAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 02:27:24PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci.c implements the functionality for a Type3 device
> initialization.
> 
> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
> exported and shared with CXL Type2 device initialization.
> 
> Fix cxl mock tests affected by the code move.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

