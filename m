Return-Path: <netdev+bounces-160150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914AAA18868
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 00:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D3F16ABE1
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144F2199223;
	Tue, 21 Jan 2025 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LikZuHTP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251F26ACB;
	Tue, 21 Jan 2025 23:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737502554; cv=fail; b=lWtTvRAslLBzuPM5z1WYws23v2vqFPAuafhlSc4f5b9ckMEAFDtBGIB1UdYBKKsTM/5WQxGXPKQf3ScWqvvXg95Wsmzthf065VrI5wdM5EeAmSIY8DQbDwIYc8cKIfBY5tyJsFOQO7R/VnFCzhG6Mybkknp+xHDvIgM3s+aLBZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737502554; c=relaxed/simple;
	bh=SuWceLhAnTuQ4racgQPoPQXvXr3hUYC/HXUn9czzVcQ=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F15RXvRxpetjK1ADgkf+ykPTMwuv0Ih7XDkuHWINBtt1r/1I0usouteOu6YHufmFNGjZK7dW5+0KivdpOnhvz1/NwZXT5Fg5TQIGgp16JQH+rsJKxjUwBxtBQNB75D4A/+KajiUTEcKdyctXHiJpjzqpJJuXGfUPeUJpEjF2qWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LikZuHTP; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737502551; x=1769038551;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=SuWceLhAnTuQ4racgQPoPQXvXr3hUYC/HXUn9czzVcQ=;
  b=LikZuHTP/dNJ7oINEKYUPASNbM6xIvO88DNzLIWWQwI52JYc8fv06+Aw
   kB+CyPkdOeXWmFROpTsNyZ8vVGPcEk/dDVlY2MgUf+RhbIgBc9dMdQXc+
   otLJZRq5EFYrMJoeNiikYcLodmv6F3IDDU613liRhvVjZtpYgP3babpip
   t9tiMPWRkRnIPgS4aik47RnvCmH1W/cjyLW2wUroOkoFRLxQmTPTgiFDx
   x6ned7o+baND/JG/nZnyjrnzJUhCc+ZRDBPC3sQRO2dnqmVs9DPOwNK2U
   mZRxAQ2/T5uR+XqQsrlHHATd2bRPB14Uf63rzq3+ip6FyFeodfTUKJi8G
   A==;
X-CSE-ConnectionGUID: 0F6c49XdShaF9BCvoQvm/g==
X-CSE-MsgGUID: 85cjIcJQTh2w4ObGKuvSgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="63298484"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="63298484"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 15:35:44 -0800
X-CSE-ConnectionGUID: Uu1YQkxCTuGVkVhtM0vmfg==
X-CSE-MsgGUID: ztJ3BV2oRYSMEzTN3ZYPuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="137777448"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2025 15:35:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 15:35:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 15:35:44 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 15:35:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orpKKDD5Lav1BmVv6fHRxn+wK6EzMFqp80hSfEFnVljqrZ9w823mskJ2NcKdUxge1F9JGD+d6OpGI6aN905OZaYLM3qEyUFbWjmJRXvlHO2qe5lHrs32FWQ2VOp1yT1h7eoLkTcOsLbHxg4PPI86zk0qVdKxhUlIWfIIW4VfMx2p3ctw+JKE/ZLOMv/bemM8MBsgYw9VSyRpN5Hx9bRnstwUlhba68Zf1QDxgtsrNH9EQAtefG8TT9CZp1LDLi33IvKYhbaNFEwiKyG0yPQzDVYxQ/rBnfVHdDEl8i1KHxlzo1WSkxyStivEPEzg5Ch+YrvXYWrawATn3rZfmkqj4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+ePVS3hi0iQLbgHhMBrCrmuKDTipNPKY9T1Cui8bF8=;
 b=LQzzh2gaao8zMDyTu5529KAgTalisp+M5/U3n4nxlYtyytH7rUlLHlfMKXzT4CT03w+x3rHcnZcW2EzuwPhsLJC/9teKVDpE1pM1EWAoOJ2olbbLYrxq3aPONU79T8k9XRiHMiMPokfqocDpPn3cEqsDxw9DFZXYb7K0UyG7rnvIeK6JFcVXaNEuNsTOQxzj0ISaO6jynWs2qpip2IJbjgZ2uY5Okmw/v/sVAGiouH+F+yGO8z54SFHIjS3MNmuKyizT3OmHGzXNpdE3v5/H/L7CBnDLobG+2uGoAAHfGoNeHh3vfqIDkTNEBClDs3/DxX4A45WTdI2ArbGSaijHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SA2PR11MB5116.namprd11.prod.outlook.com (2603:10b6:806:fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 23:35:41 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8356.017; Tue, 21 Jan 2025
 23:35:39 +0000
Date: Tue, 21 Jan 2025 15:35:36 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v9 15/27] cxl: define a driver interface for HPA free
 space enumeration
Message-ID: <67902f4858ba1_20fa29464@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-16-alejandro.lucero-palau@amd.com>
 <678b19bdc3d8d_20fa2944e@dwillia2-xfh.jf.intel.com.notmuch>
 <80dca432-6308-26f5-99c3-47dd15858259@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <80dca432-6308-26f5-99c3-47dd15858259@amd.com>
X-ClientProxiedBy: MW4PR04CA0110.namprd04.prod.outlook.com
 (2603:10b6:303:83::25) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SA2PR11MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: c8984bb0-2949-4380-a57d-08dd3a745006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F3YTjfrkU9LK7OTqS2PYOJq6l48dwWfoWQDphY+k6pfLRaAEpLoLgNMJ6nWw?=
 =?us-ascii?Q?2M92wEZ6FJVMjo2Cye2Bis0a1iKx9tJayuqiMn5JHnBGJlXCjKZhN7EHso1P?=
 =?us-ascii?Q?2K2GVHpD9lVaS6T0boAsxmtWKfeNPv3/EeS/dZhxq4QhYuC/Q+YqcPCdCD/B?=
 =?us-ascii?Q?7MgatI1EuREAbFPo6ImUGu9CXHBTWfNTZ4sRai86cWMmXHn6hVi8VDsnV6kU?=
 =?us-ascii?Q?6ZLHkSmqTxUYOwXfaRT5Sqbtjg8XzVl/7o9JjnJpXJD2jdZh9du5JMkhOvcZ?=
 =?us-ascii?Q?21AK7mpu62Q2ZNNt72230PrrPfbop9wzoSUXMx71TxGuOQv0MjYok7Byb6kh?=
 =?us-ascii?Q?be2WFmmsqeMCSm3Q7eufGpJhnUuSSboufOH2+2fpbGvy1unF28EI8mfyKBFh?=
 =?us-ascii?Q?6N+UAxlc7AJXpP/e06eKo5No3NAx/bxOQj3Pk7Zjbk/F8h/aMT1islQazwZ/?=
 =?us-ascii?Q?E2DCfIKcfU5GkLyPMGXQLpMj9EISW82MWUsinSvQmUGAdqbG4kdNc1pdKQiD?=
 =?us-ascii?Q?Jhpvwoxd72LIoVeMgsjo5jECmQFOag66OpxrXTsgpU5pvtPNjnUCNAhOJNkI?=
 =?us-ascii?Q?CLd8jKMTJWmRhxZKIoe55CXuRAEtQyyVzWMQSqdSxKYotkAxIFg5yFDnox6c?=
 =?us-ascii?Q?jM+xIBHp1y0uPsO2dgjm5ak1j99uhV1YzzABvy6WMdC3PdSsQxrj1m3e0Nk2?=
 =?us-ascii?Q?vvRsIaE75xsPIEJvDQgJvfsB2o41Sjrk5XhFn/BwY0kWMCfU6jJJ9JctqpVy?=
 =?us-ascii?Q?lm2S24nXu64ak6UaiEJuexBfuCTtAfe9thNnTgGcwLvNw77ariQVwt4ujaa9?=
 =?us-ascii?Q?dX1zyWxunzfebyumrZRJJSJUrKzxFZaz+LctSyXAo/4SwsnggFPDPAIckdkS?=
 =?us-ascii?Q?RieragxAKnftIB2AUMY5BDUxa/sJ5fC6mDnwwlWKVYfaea/jE+/m8GN/x/0k?=
 =?us-ascii?Q?rjRs0iHcEamX7MPXA+I7hhk2+MBBwSgyNURtkE9x/OfLZPZO4GA8k3nlDrH5?=
 =?us-ascii?Q?HR7IU4mcnufn3WSebpf8nRQcra7AHLjHjir4o6vkd2yztpXlY9RzEkgVweG9?=
 =?us-ascii?Q?Kj6hgThuT9dgFyjhpsGOPK2Uo+q9ipCR+QC9nXVbbxdfTuLN0kB4Ag13tjIr?=
 =?us-ascii?Q?l+srx0kbhRF1XWW/+jIDxzHfLYhcH+Tj0JWO2eckFSsz+3VrZZy8cMotOhEu?=
 =?us-ascii?Q?h6euKm5I46IiH4HapaasMkdBnF+ZYzobhEIQtu+SwUPPVzOK5GzBpaBi2Oru?=
 =?us-ascii?Q?BFEjYTDaZ2gOJ4uyU8+FRQGvAT2zQyGmSzucp0uocC2f8lvDwJOkVo6UKScx?=
 =?us-ascii?Q?iCv6U9lC5+RFH4Y+hh6yMymKtl2h8XA0r7S06HqbGPp6i8S95ZuNUS0Gr9kR?=
 =?us-ascii?Q?zMeI97xN7zIxiOpHPMirAC+wBE53?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hJke1jzP1nRrIpgwb78Nn9Y9JAZ/uNX5QDbFN7tnu/4qybC57NQZNPHs2vzK?=
 =?us-ascii?Q?xlJ71+d/zSHp2DTaBOccVAWe6zeRo2vK/ekvPq1aIthBEiV3hjLYyTva+S9O?=
 =?us-ascii?Q?lbPSv3fiLLha0vz1yvlzomPHjYxu320SyRzdHHu1zrLfFEh2alHSkrZTZXX5?=
 =?us-ascii?Q?QyCUT7Zs1GdFuOejlGcTdDWnAgWHzl+fGHbQuLMzrJ4VyakyZx5vBGtNE/EV?=
 =?us-ascii?Q?g1TeUA9gC9M/3Fq7vBwQgJmqZNPrvGyyS2aPI2Rmtj+HjtZ0G2N8hfBHIwA6?=
 =?us-ascii?Q?ju2rmh0Y5KVEAnRXjcqr1JaLb2uRPxzU20+pvRkUKNCx/NqpyVvZ/zJivajl?=
 =?us-ascii?Q?9DMH7AVIErQz3na45GU8atP+8m78iLyGD004xQKC6zWBlRlFKDMsnxDbgoEo?=
 =?us-ascii?Q?FXKhdG9e+HyKIy87ci8/RRHqzCQRFT2KwjxGyva3s6uGmzCqMbmtEP4fkvVy?=
 =?us-ascii?Q?CYpQil0E5JDGMOWF1bMHPSvTZjgQmtEkEgdu2REb0FuMxJ0bShdeTzqEwQER?=
 =?us-ascii?Q?fOkUFTv9vHWRReS2AvKDZBlewlvqE4GPS7NAUmaG6Sxnr7gk9iRN4gyfNPJl?=
 =?us-ascii?Q?bLrD+sXlHqWXtl25MmR37X+LKK2twWcodNnb2f3WuB6BlFRmS7r17EDk8pvW?=
 =?us-ascii?Q?c1qvzCrVwXOrhgD/mARPUgIfAE2yDqoUJ94na/Hh5JqvKOLegsFJV1nekjDV?=
 =?us-ascii?Q?Y8hxd11fPEDv4hjJ16BnGh3qNSHibdrfBMGOpa9s6skhC7BKmxR4tqjs3Fp/?=
 =?us-ascii?Q?/dknoFOeEju12vslVKwef8UoPV88Fg45Dv1Is+VexS9a/v7YIjONxygZI+xV?=
 =?us-ascii?Q?RTk8KluW6oG7bzr8CpitqzphlgsdAoVBQO6TJfx7ay7fIhsGLgRj5ggTUCyk?=
 =?us-ascii?Q?toaOfrOl4GZvfUM/4PegPSu8vd2mYg4YbqZUugAEKFzB1ZAM2w+vn8lAqOo5?=
 =?us-ascii?Q?XWJVY6/XADzCLdJLLblzU8EzeeWBnBza6XP8nBTtPTB6BgMHYYt0ANj+kiuU?=
 =?us-ascii?Q?Pyc+AM24mVPBUtht5MePHYp5ii8Uf6VtfNkYyekRfOOdJ76bo4waY2+hegnM?=
 =?us-ascii?Q?Ruh09i2oTHxJlCvyFYLt2W7Y4U/IvhLzuqNZVYJWG0M8GG08zeEI0nfDnGlg?=
 =?us-ascii?Q?eWrlhHhV/nZmOHCzwNj/i3UQUlp9CuOUE9Gy81vZULchyb6ynKpJIbBKjcWg?=
 =?us-ascii?Q?SuL4y8U4I7IoI2Wgf0IEWFMZBExVZnvpyTawUSLrL4n2pWBjH8+R+3MoZ9vt?=
 =?us-ascii?Q?VV2t6ldXp0AFV0zk9yJeulGLEQEj35zrSC/FaBZiZASP0ogBNadNIUXGHYcK?=
 =?us-ascii?Q?QSbIG5+k3OMZe1Lc0rpjRSisdjb+vjx7doS0CWCqLPxcMbEnKcpkQ0Mf7tcj?=
 =?us-ascii?Q?1jkXBM+frxV99G7nBbQCAWW2Kbg+aW0KvyN8/5eNpo3OiTzVWUr1Dy79wgkZ?=
 =?us-ascii?Q?karHGAeL+1ND4UTGt4b04fIcBXZ7uGNeI3BhwVepbHYVWazgyCHGmgB8CqBK?=
 =?us-ascii?Q?vrPk/JJEM3Ipva+aJD1Wq8pIZfqrlBBwt6envybA1uhf186HnOm0K48AiBpn?=
 =?us-ascii?Q?BY4osHfX2tA/KmWxeCniKfP4GQVO3mqVyWaRWj9+gcEpR6ScS4nD6NFFpzaD?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8984bb0-2949-4380-a57d-08dd3a745006
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 23:35:39.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFIuxv5I5VY+4ttytcOoc3UtBcI6/bGXP2FEOQkb03hxAOrs2HFeE25AwdSle/YHYLZKjpjlmms7ff+8Cy26eT3uunBpXGtQEf0YwZTl8Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5116
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/18/25 03:02, Dan Williams wrote:
> > alejandro.lucero-palau@ wrote:
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> CXL region creation involves allocating capacity from device DPA
> >> (device-physical-address space) and assigning it to decode a given HPA
> >> (host-physical-address space). Before determining how much DPA to
> >> allocate the amount of available HPA must be determined. Also, not all
> >> HPA is created equal, some specifically targets RAM, some target PMEM,
> >> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> >> is host-only (HDM-H).
> >>
> >> Wrap all of those concerns into an API that retrieves a root decoder
> >> (platform CXL window) that fits the specified constraints and the
> >> capacity available for a new region.
> >>
> >> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
[..]
> >> +/**
> >> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> >> + * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
> >> + *	    decoder
> >> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
> >> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> >> + *		      returned decoder
> >> + *
> >> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> >> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> >> + * caller goes to use this root decoder's capacity the capacity is reduced then
> >> + * caller needs to loop and retry.
> >> + *
> >> + * The returned root decoder has an elevated reference count that needs to be
> >> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
> >> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
> >> + * does not race.
> >> + */
> >> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> >> +					       unsigned long flags,
> >> +					       resource_size_t *max_avail_contig)
> > I don't understand the rationale throwing away the ability to search
> > root decoders by additional constraints.
> 
> Not sure I follow you here. I think the constraints, set by the caller, 
> is something to check for sure.

This is the original proposal:

struct cxl_root_decoder *cxl_hpa_freespace(struct cxl_port *endpoint,
					   struct device *const *host_bridges,
					   int interleave_ways,
					   unsigned long flags,
					   resource_size_t *max)

...it includes support for selecting a CXL window that might be
interleaved. The support for checking interleaved vs non-interleaved
windows is trivial. The support for PMEM region assembly requires
interleaved capacity search even if accelerators do not, so it is worth
including that small incremental support from day one.

