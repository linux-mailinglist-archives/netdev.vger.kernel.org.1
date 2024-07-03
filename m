Return-Path: <netdev+bounces-108956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C0B9265AB
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08691F22D83
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E13185E52;
	Wed,  3 Jul 2024 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBhIOtx6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A674B1850B1;
	Wed,  3 Jul 2024 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022949; cv=fail; b=MwmXmMLKmVG0JOm4ZwuM7mMpqU5nMMKpSYv328ciHUL6zJKzTFC2CEiCgo+EaCqBmgLVmq5mA1Qouq7bUFu4dyGGAeZReSyblUNQEdB+uSnHYg1bU9P6REJAvQCfHkxRtC803xAckPEVNsk6gGX6oaXC1Pg/Fi7Ug4+LuF+3QgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022949; c=relaxed/simple;
	bh=0Kuqk9Q63hrwR1qxUkkPrzGMKBhxMTCa5xM0K4qnxTQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cKD5svgVnBHxYD2YJSq/rlc0UDjV3WRJLIjrDb6DqyabCFYSiZBWo6gc6BttGr8iPbjMYJGgFvJ0j/d+aL00WoqvERSYcFFCsu+W0J0/G7HvH4rvWjqLla9lNRkG1NHkA/JCBvXhoZWoP52cZs6/1F2m5rUEwBSojdnnfdZpHCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBhIOtx6; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720022948; x=1751558948;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0Kuqk9Q63hrwR1qxUkkPrzGMKBhxMTCa5xM0K4qnxTQ=;
  b=jBhIOtx6AgxFLlJgNZp5CKWr9uQDHM6lCKFNkl9NVH7qcx7fFAkZqCKQ
   YvBF+/IKmq7H3hAgaww6h3y7kojf1OekP7hzVoRutGzW/q37tI8p08H7L
   kg3TWGWl5rCVAEKK1YIO5dHx6aOMDg0NvbQANtjOwZf0SDfPlpNVn4W/U
   fcX2zCJeSSMfmha1k9xyIuuWwLHUOfA+gxdE+OxPeB1Q7yAIgE4fMt+f/
   lWd7x1Ik0irJ82zKKz3iZesKi2mWeh+GJSDTzn62mlxTT81d5ERrnBwgf
   mq77PAD3NhxvuLQEfwxfsy/g5payh+oKQWMyxbwMiX7jchRltp535ND93
   A==;
X-CSE-ConnectionGUID: 5aUHHu0zThKWbIeBdhz69Q==
X-CSE-MsgGUID: OVs5/QhfTNiUxAmc1BnuOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16984987"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="16984987"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 09:09:07 -0700
X-CSE-ConnectionGUID: NIY6wZ6MQx2Z+15taFYUNw==
X-CSE-MsgGUID: gr1W3Z2QTWqaRvsXqCVFvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="77456460"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 09:09:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 09:09:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 09:09:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 09:09:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 09:09:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZN2LJ6QdxFSWToIZb63CNkcmBmyfsNad0NjDAq5INazBe/zrF0qm+aqMDGw5qYrVW+Mckv3yHim7FPMHFZLnSslc42OF3mpAZr6Fln8+GID392ES/G1Ia75mdl0eADQwUqu+0nzsyGg0u6B41yRnROCdPO672tCKsROiZSKjkrmRj48c6DofO9ZErVj7jxdx29Bj1VkrgOkgtY9Q4e79QZi5CXu4EeN6CpVucSDPm9F8/dVHrvg4NwSI8z0WRLP4L7cNOH4/tMxzW8umhJwd7mO3Ye7cseq3wkOIpVbeCS43YOlJWI+sCZm58nIkynMOlBAplokQY9l9cy97AWeuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvwRU1h493fXOCzQwIo7N7SN4nu7JWOWd6mwv7h/pXw=;
 b=HfBNfKjQFjNX5XvMuctT1iqjm15HCDWGjOG6YsPb8X90Gh9maQKOg/L+p1iM/XRFDnJnc3BKIrA1b2cjsg+8IO6U1aS2WRmDxcnwwHWUqnDR0vH35by88R+CTCaxlJJjzRfX8ioYBbMtjtQopXFNRUNiw+BjrsmXHcQoU2INwZy3BWoyBP0ky9e42wuTZbYV43oGRpopH6c+2AMDJrbt6Vsel/fL6BqZRCj2pya36G7mIrCEsUO6hmV2w69OL/GfyvEKZL3EQg9nqS5adn4OBDfasWlJoKou8h40YpM6eQPIor+i0RzUjYU1/v+OsQkwE+cFNwp2MOgOCQ7nGg0dMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by MW3PR11MB4554.namprd11.prod.outlook.com (2603:10b6:303:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 16:09:02 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Wed, 3 Jul 2024
 16:09:02 +0000
Date: Wed, 3 Jul 2024 18:08:53 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Christian Eggers <ceggers@arri.de>
CC: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Juergen Beisert
	<jbe@pengutronix.de>, Stefan Roese <sr@denx.de>, Juergen Borleis
	<kernel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] dsa: lan9303: consistent naming for PHY address
 parameter
Message-ID: <ZoV3ld1UI3lA2/pF@localhost.localdomain>
References: <20240703145718.19951-1-ceggers@arri.de>
 <20240703145718.19951-2-ceggers@arri.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240703145718.19951-2-ceggers@arri.de>
X-ClientProxiedBy: VE1PR08CA0011.eurprd08.prod.outlook.com
 (2603:10a6:803:104::24) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|MW3PR11MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8d36ee-e5e2-446a-02bf-08dc9b7a7466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3FOnqC8VLFQIf39NNlUyfQrrmhXxOirO7PVs2FJpb03qCjJcjS7Js98a50O/?=
 =?us-ascii?Q?lLaxIhCfkreSi2HcRYbws/tHxqT2bFoo0dtTOOb1e+ZxJxXLjjGs5f7Gw1kw?=
 =?us-ascii?Q?hDbpesw67v6K01+f7Hhja9Eo7DszUrNKpq/tRRwqioY93tojX0DTpRd4lrvl?=
 =?us-ascii?Q?ANQ/F8ksliozeEhSrECrQDgezIM5cBUSchxLZySEUHoysuARXE6DdQO8y9Gf?=
 =?us-ascii?Q?FTux7wKbxVFzkjfe7IPXhEbLcrYBx7pKTQijsWBwq2w4QOI2M7OtYriAKLV3?=
 =?us-ascii?Q?fE1pRrUK6konfhr+NjtgRpbmGEEdIyaXXDQlHw+jNCZsuCg2nQ27xiru3qVI?=
 =?us-ascii?Q?DjNlngJOChHHzhrewWpd0ss7vq9rfE0dlz23TtQyvHfuMf9znWddQ3fLt+Oc?=
 =?us-ascii?Q?QAKz0LR4BUA56KgBiYvkTni3dq+BWO73Y8a3emRyeBU1Z7xt6a0kmqrRxuxC?=
 =?us-ascii?Q?F7Xuap7fALN4b7qgciilmF9lUd97JPgcy52lyfCPyEFwZEmCKTKshtvbn7Oj?=
 =?us-ascii?Q?IA7FB/r07oS8qw1qJ1X9HjdY4Nh26viziCIKc6JDb8542EyP5DaTU+GbJza/?=
 =?us-ascii?Q?oC1msjutoKSswLQZ7UHEACOw2J42AuIBVCvon5J9Nf8RWvekGWiwzWUj9RQt?=
 =?us-ascii?Q?nfxt8LaGQ6oO6AJBOtGJAY/GpHZe8JDEpwykrWlibd3+C8f4sbSbhEl7dbMg?=
 =?us-ascii?Q?q8L0ue4eKpo4fx32bNunOZZGAaFM9bQBEfJZW5accBpfrpPwVmWncFK+fbj/?=
 =?us-ascii?Q?RWrXPVvMbyJkV/NyAW+fsroqerz1WnfGw+GPJYLZGNg0tvC0bIcxEari6nIA?=
 =?us-ascii?Q?jHfV2wJX2g3+7Gal6A8L3EMkKP6tymjqaDpXHo9zP3GjAlOHGCWv2iBkqqEb?=
 =?us-ascii?Q?q0G7/AMdsfqsvK0GPp0iHLnZNH8UF3DIyGRzxCDi/Lp+7qWsVoH1B65mKdEF?=
 =?us-ascii?Q?fBIEBunrSyoe49tmOgeA+m7VxzERduuhjGFEcDmNT+KNWMbrTGY2Ew/n5RO3?=
 =?us-ascii?Q?DOrFh3v1HoPfKnrhJjkngughGXs5HJ4ykntecjXdLgEb7TL45lAZAg3PTN6a?=
 =?us-ascii?Q?CrolltOtkPB1QvjQv3+geSf1H3G+N0iCHHKPBNVLzzRpW///NdRymBfmkNJV?=
 =?us-ascii?Q?8E5bBqei2ARzgGB6jzMyw1QizciurpbkOpv1gZSoGySznELaqI0Znn2HZreU?=
 =?us-ascii?Q?zuDb526sWUBTP5n4h0h+/pKyHNOoP6tqcvwyFHJbpQo/Zlqeyi4ji2Gh3qRo?=
 =?us-ascii?Q?Vgl46NdTRuBHAufmc8E92avbTioQM7c4KQl217R94IT2o/fj0dd34vsLib49?=
 =?us-ascii?Q?xzDiKEoqmq/iiEsijm0sR5eMGXd6UGj+bsMpdn1+D67J5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yeG50Pc/945FMRAwySB840rcAFi7cTTn/2dIRkvkf4Tf7ydSay+Wjs0NMh77?=
 =?us-ascii?Q?ubEGwPYephDMwcxTCV8+Cjv9/tqjTDAEY3/zZS8D/cU9BsckTUfN3eS2nS48?=
 =?us-ascii?Q?OqKW4lgOU3ej93IZIkSlOLppts7PJtpkJbMAwHs7HmNs6kiGHE+RHZxoerx/?=
 =?us-ascii?Q?mQMtJ36bn7BLll4RYP6InbMcElH8DGXDg7BjaS43JZW1aYvbeQmnLnXprPCZ?=
 =?us-ascii?Q?/8uIxUEuvgbqZ3sS7UUTntI736CX6miB/H8J5Kllx6R4VCp8KV74etw/fOv0?=
 =?us-ascii?Q?GGeWnuSVzR2plR9FtPVedv2Ul06IULxVN+3jymf10ubbpRYkHLj2xeB+Klsg?=
 =?us-ascii?Q?n2E/9jzkpdq/aWwJbNeIyBS2StiILmdlVvZUy0DLdlDt1U+iDiYi5ZRb8iBZ?=
 =?us-ascii?Q?KRjZcuu6NYlYby1XTdtVyDjk7q0T27v1vJEeyzIDJOFTwuPZZHUxq+hsoF2C?=
 =?us-ascii?Q?e9oA6uC0lVKP1TEPhVTW55RSydx1pVOlW/W3iDhHfiH1qm8krGq0Y7R+0tf3?=
 =?us-ascii?Q?qCe5TWS/3wDS7CUViD09czJbl/L5Gc+0Y0dwkCy6tpptmzrBIaqGWwTNt3Pv?=
 =?us-ascii?Q?McmCghW+dQ/jTPm7sdzcqS2kqr4k2C9Jzir8M9w/QtkE2/loOG8mcLWWwai1?=
 =?us-ascii?Q?1fMymHgX7A2uAg4/Hz3DuAOp/stEIIcXKsaC5NhxNdOcCdbGSr+b2wCoEmQN?=
 =?us-ascii?Q?Eu2xeCaJHlVQ5iyBgSVq+qbMM5VY6wW1XRqjjb6XbUVNTcmevFLoSbbetlVC?=
 =?us-ascii?Q?4UeJUmUKL5BKd+QZcnqSagOk4rohsKBfkuf0BM1sNNio0FzA7a93MuSqja9R?=
 =?us-ascii?Q?QjtTmcM+JXbpfDzvMi5YAlJHHALP+F1gAmZcYJsGgISYN4WRhUpi52sjeauo?=
 =?us-ascii?Q?/kYiew5n2tnREmUMzU+xxSx3JZSY2dM1sPD8BkUErpw2n1TPhuqvTrJnc0Qz?=
 =?us-ascii?Q?CZdkhBoq38pxiqp9YPVnBYKQAkDw0MDYxxacZZhw9CT33UlnrRTJFyzYHYXI?=
 =?us-ascii?Q?b/ZBZpeHHaHm/6VF4GJtSL6Pq8uchemqM6aeDo5rqOz7ihB8zJziVglbm0tV?=
 =?us-ascii?Q?frhxDNOUOHIy8EkCe+deqmW7xv59VBoH2+6cLtp2kjAItcMAR216TWS2Af+V?=
 =?us-ascii?Q?OpgSDkqGwPy7B/airoBu1KHLLHnma9xkZGcwLz67CInqYHJywApSCCKj5VrI?=
 =?us-ascii?Q?Fzd9Zo/srF+F0FaeiEFVUDIgU9rWn6+F9+tx/dYce6whuAaruQU00e3+a9uD?=
 =?us-ascii?Q?DgB9x9uxt8aqzgSBdDch+Dk8DVD8fs5bAJgFUXne06d+Pmvs4LwvbGKPBCgn?=
 =?us-ascii?Q?AW4wB6efXFF3Nv1NL+43/S/E1WaIHrMMBdjUxEicsP1Vnyght8gT3OP5oESx?=
 =?us-ascii?Q?NbNLYI3RlGh0CEqSTERVI9+uHoCAEk0SvY3vMOxKNYYEIFcUeRYiyWjWvYPW?=
 =?us-ascii?Q?73FUuxLzRUUZREh2MQ1i1+cdIDlVEYesrfI5vp/Q42HORVq2TlmgZ7Eno2do?=
 =?us-ascii?Q?t+FfWF+JvelVurReSCmkmeLUBH4B02eUATK3AwdrQg31nhCDcDmc113SimpH?=
 =?us-ascii?Q?7HhxhILCeNqoA33rUevqHuG448Z1/RB5nuXMaE9wWk8fhjA64L4EyOUieFTo?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8d36ee-e5e2-446a-02bf-08dc9b7a7466
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 16:09:02.1828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6/XQqF1hSCcHfZ36dzA99oMBXm78scWr7vGOHGIbCtv0IdMUxCb7YIHk+QkPd4k4IiBkh2Qs2k9jCajHzUHLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4554
X-OriginatorOrg: intel.com

On Wed, Jul 03, 2024 at 04:57:18PM +0200, Christian Eggers wrote:
> Name it 'addr' instead of 'port' or 'phy'.
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
>  drivers/net/dsa/lan9303_mdio.c | 8 ++++----
>  include/linux/dsa/lan9303.h    | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/lan9303_mdio.c b/drivers/net/dsa/lan9303_mdio.c
> index 167a86f39f27..0ac4857e5ee8 100644
> --- a/drivers/net/dsa/lan9303_mdio.c
> +++ b/drivers/net/dsa/lan9303_mdio.c
> @@ -58,19 +58,19 @@ static int lan9303_mdio_read(void *ctx, uint32_t reg, uint32_t *val)
>  	return 0;
>  }
>  
> -static int lan9303_mdio_phy_write(struct lan9303 *chip, int phy, int reg,
> +static int lan9303_mdio_phy_write(struct lan9303 *chip, int addr, int reg,
>  				  u16 val)
>  {
>  	struct lan9303_mdio *sw_dev = dev_get_drvdata(chip->dev);
>  
> -	return mdiobus_write_nested(sw_dev->device->bus, phy, reg, val);
> +	return mdiobus_write_nested(sw_dev->device->bus, addr, reg, val);
>  }
>  
> -static int lan9303_mdio_phy_read(struct lan9303 *chip, int phy,  int reg)
> +static int lan9303_mdio_phy_read(struct lan9303 *chip, int addr, int reg)
>  {
>  	struct lan9303_mdio *sw_dev = dev_get_drvdata(chip->dev);
>  
> -	return mdiobus_read_nested(sw_dev->device->bus, phy, reg);
> +	return mdiobus_read_nested(sw_dev->device->bus, addr, reg);
>  }
>  
>  static const struct lan9303_phy_ops lan9303_mdio_phy_ops = {
> diff --git a/include/linux/dsa/lan9303.h b/include/linux/dsa/lan9303.h
> index b4f22112ba75..3ce7cbcc37a3 100644
> --- a/include/linux/dsa/lan9303.h
> +++ b/include/linux/dsa/lan9303.h
> @@ -5,8 +5,8 @@ struct lan9303;
>  
>  struct lan9303_phy_ops {
>  	/* PHY 1 and 2 access*/
> -	int	(*phy_read)(struct lan9303 *chip, int port, int regnum);
> -	int	(*phy_write)(struct lan9303 *chip, int port,
> +	int	(*phy_read)(struct lan9303 *chip, int addr, int regnum);
> +	int	(*phy_write)(struct lan9303 *chip, int addr,
>  			     int regnum, u16 val);
>  };
>  
> -- 
> 2.43.0
> 
> 

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

