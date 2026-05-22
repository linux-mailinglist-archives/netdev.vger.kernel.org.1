Return-Path: <netdev+bounces-290791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNZXFf1AEGrzVAYAu9opvQ
	(envelope-from <netdev+bounces-290791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:41:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7835B329C
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C5530B879E
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D123D79E8;
	Fri, 22 May 2026 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ifv2baXx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08423D1A86
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449629; cv=fail; b=UOi7jGDfWeoRq4GMePkN590smDlCCx/9mWJIZdnePEEopcrFOlQUq4Q8lDOV35FM+GHJ67SDZLKoEqvYW3n8+QcazubBO906O4hkJGJtbM/VQeKtUwA9K+Wfqn53F/id56Vo7J1EOJfVxF/ISq53L+eJaMo3D7DOe+8v1IBKqcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449629; c=relaxed/simple;
	bh=DP/iC9yJEUDSSCyBjS33PlEA3WI063IQQu2hvcqzxGk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xg6bt8BK9l5TQ6kv21vuKrB4MAU88Nxz+WY2eKUIyUVqjNpb1mjpVdmC6mnodk0HK9Us7QSgQ6+1N2Q/5BdI8L4HTb9DVKbVH/1YeKBDioGWPpags5m73tRf+L1Qptn/Bmo7V3127uc5ET/LVT1bT+Mt2CQrKoAplPnYWrsFaO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ifv2baXx; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779449628; x=1810985628;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DP/iC9yJEUDSSCyBjS33PlEA3WI063IQQu2hvcqzxGk=;
  b=Ifv2baXxeUDMAoSJZmtYhxt+ToujAVSLZVZ6m47sB2wFRdubreYWGCGu
   +n0fYBNoGF6/VnuNaNEhFDi0Q459MaCLtw7VX1/ryY+L1vtTwnLY4Ns2t
   97W7ts037yVNlb0f09qlZLuHqWS9OnPfCE1jTRVyRZM2yyV9muk7Lcv0G
   nFljsg+liNMktrn6gQmQY00VBE11qgdMg0ocFfQ2yxD0y1ZeHEYu6IbYP
   btVvs8fyxy/lPJt1Ps5FiGNTLFecmqIEdlcj4h/fgNuklD8BOv/jrk8Z9
   ymQ/R+UtdIfsbmpkJ9kyAzW8RUNmJwseTlBES6JoxDV0mENMl67tc48Jq
   A==;
X-CSE-ConnectionGUID: PBrJvyEdQq+mBcvegvtx8g==
X-CSE-MsgGUID: /Fzik/mNT+eWlZbzFS7j+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80409323"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="80409323"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 04:33:47 -0700
X-CSE-ConnectionGUID: 3JQTSWIVTWKQhw2Wpmgszw==
X-CSE-MsgGUID: g3ROurOAS6q+ckrpO2w8ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="234535051"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 04:33:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 04:33:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 04:33:46 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 04:33:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2MtdrkvkxLGqURD5mXiXIucMD8n5Wg11Ujl7pI321a0UI6RVxfJHA0mKmLE/ywoJOGE+OwoxJ7elu5g9TfR8JgsXOlRx9hpkIZnxSR8DwkEnxtokQ9cjqqeDqd7h9w6/oc+1fLTSZyDjF+Xfk3kuy4FHdn1ZhxLh6MV3J5BI1eSK9p3wz1KA1nmcjZ5rFdxTpdUaOrw5W5xZThGRnjBeypuH6W9njP4Obk2HKZCVUO+G/FC6XIcv6dnTke8+q6DkaXZ73qYeJdDuZ8oPtMJDldT5KhwtbErrT4IYzgVxt8meLodcfeGIvouOj/HVKhaXgpHsXSM7rC8Qoxq55f5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGqhUwJ4lrcSodFCZcLGsr6GdqBqU1Z/rZmkKz/bdG0=;
 b=Po0YeVK74682cuVjgIkcOrtvJ7LE0nFIUU5P9+WOv+u4cu+kL/JtQdRmct/0ei4xVJvvmhZhmu3BLQrEBsLEJWx3s8nOvvcqzFc34WhFLcDkVKiycdWQ+64QZ12LYNbn9iA9cKgfzsGiQKF0k6+4dtEiD146zZmrrOtwxfW96ABobFu7mfZ2tHuGPr5NHIFx1uViln3ERwAJfisAKBD5ZK94yJ5rzYjyKebWFKQzFrfTYDcaGBhlQtWzTj1GtkIk39qUGsFMuAtiEkK3mTy2VBFUsrWzcgfBvgoqH8dxiGT/s9mBczcHPqf7H4IktZpncnn93oCFlIry9YDBQAeTPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB5918.namprd11.prod.outlook.com (2603:10b6:a03:42c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 11:33:38 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 11:33:38 +0000
Message-ID: <8096bd0c-5e14-4cff-956d-33ac6b8fcce3@intel.com>
Date: Fri, 22 May 2026 13:33:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [e1000-patches] [PATCH iwl-net] idpf: add padding to PTP virtchnl
 structures
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
CC: <e1000-patches@eclists.intel.com>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksandr.loktionov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<konstantin.ilichev@intel.com>
References: <20260521085428.117991-2-przemyslaw.korba@intel.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260521085428.117991-2-przemyslaw.korba@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: af162c18-2c34-4f53-ee7b-08deb7f5f759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: tqlPCK7y6ena0LAytCJjuH+mEzZxJums+XElzc7pilRla5HjO7vqkXdu+2FMZVHXOwXF84HNRDRPJjBC75L39qJZ4VPUxohpPVpbI5V4T/oAvwc8mJVXlMT1nQR4nu2P6C47FyAhYHuTlGNHdELlP3v0bHPfkwE9KeY3T0YXfg8I/dEcQCq8ij1UoFkOEt+YU3uRr8EYLHq0z2tWnxExI+yInnq+D6VjdCZqSBtLnhlyeqzhHUjL+1Cb+shkiNDjTDWalKeRzQRjUljwIZs1wEobXJAXqcbbf6Od4t6Nma18FwwQrSXLAa4Q/pQC/XXhjp8wJgkAoPHaQgrQ2IztS4Ga1jre2VXeHwFV0rceerci+jTF05Ex8GL6ECh/APZtRLnE01LPUh6rBfQkMw+/t2e5nit4o5IO23ZXoUDH22BYRH+0QZg3PJRCA6KG6YHkzfBMCcLy3mdSnPlwuikCKqZxq+U7D3vLzDUEqaFulR3wWfOrleRKrRfVkWpNrSCtIYUm5VBVV4EtOcipxVnw5LNXIS2+cFb86XwjALBIcFaSfqnV9FIZgMPDdICevCZvJE2WIUrQhwD1SvJz3FJHAdXRFWJ+7hYNbFrhBwmuDAN0QFnKrHGPVyedMTgOTrZSoD8I40huuQoeloOsGnE23nBnBg1LO8+aDsBqeGTpBQSM2Koa7vCsvkWKS90SRn6L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2R5L1pkV2lqQUhpbFJ0R0Nja1Voa0pLdjQ1RTVaRklOa3JadWluZUxmN0JL?=
 =?utf-8?B?dHpVcmk0Uy9KYkpoR2NScTFka1FOZUtXWTZWME9uZHpLbFFpSWdRYnFwTG1L?=
 =?utf-8?B?RE9KOWdpMlZ6bEE1d1JHakVmRFFPZjFteFozOXVFKzFUbVlobVhjdFBaOFRh?=
 =?utf-8?B?MXdoY09zWlpNUkxTVkFxMTl1bmg2aWw3SXBGaStuZGs0RTVtamtKRU5BUklF?=
 =?utf-8?B?MFh3TWVma2M2L3VhMW9jRHVwWjA5RXdTU0VwL1ZaSXgzdzNsUUhQWk5GNFkz?=
 =?utf-8?B?Ukdpd2ZYcHYyb01VQjZjRkRjM3k0YkVTaGV4SmNLNi9XL1d2eXRIVmkzUXVr?=
 =?utf-8?B?b3dLYjRuWVZXZWpBOGxFS281RFhpRW9jbkU0dXdRNTBMcUVqeURLT0VjZm5I?=
 =?utf-8?B?OGZCaGFibGJ0OWcycWZSNFFoL3NFT2FJd3Y1TmJtY2xzaXFGOTAvQ00rK1Fj?=
 =?utf-8?B?WWU1NlIvdk1TWnRMTjhTZUxJMXdyYzNsQUdJTHBMK1FPdXBaMmd4NUxZMGY0?=
 =?utf-8?B?aklvYlcrUy9FV01hUDRzakR5Rmw5ZFlKdWRuNEhvVW9sb0xxOTBkbjdSYlUw?=
 =?utf-8?B?WlgxS1pZY0hCK25CeEdkODB5NHJyTFVXOGdoT3ZQNmNLcjc0NkRXakR1UDBX?=
 =?utf-8?B?NnRUWFJoTTVLY0JOaWR5Um4vMTNnTjN4WVFWYmhsU003MFI2QW5qQWZYdVMx?=
 =?utf-8?B?NUcwQmtkd2lnZUJEWFhRMjMyMDFJeVVmVitrbThUck43d3hrakxKdHNGekZi?=
 =?utf-8?B?aitBWFRubHJIb0tuRzlCRldKb2RXUEoxcytsWDJ3VDdjUWRobmVIUlRWNTBM?=
 =?utf-8?B?bGxVZmJ2Sk90U2lqSksyVWlSS2JFVFpmNGQrU1kra0d2ME9Oa3hJMUFqVjh5?=
 =?utf-8?B?THBTMUZ3SVZIblJad2gvUUdKRGhncDVTZ2RUYWNTS24rcW0vcnJTREZvdUNI?=
 =?utf-8?B?MUZ6dE5nMEp6NlR2YjBaVmhESEo1NUJPeXhXSnY5SHpzRmVNQzQ5eEQ5WWlr?=
 =?utf-8?B?aUF2amN4a0dmemxVcytEM28yajhPUFVPb2pRUURLWUFNUnN1eDJpVHlnSzJo?=
 =?utf-8?B?bFNwb3VrM0sycnpiQVVsTHZZQjcvcVZ1TmpVSDBJQnBGQmpJTFpvYUlzeVpF?=
 =?utf-8?B?VjhEZmdzRlI5V0gySTJjMWZ3WGNWQ0dzdGRaWXlSZjlHbFVRS3hrVjhYb3dW?=
 =?utf-8?B?T0szQ2ZBd3lMOS9XWXdGM3JIeEZBdzFMemR2ZlZxd01TcHBxeFBGUGNmMU9o?=
 =?utf-8?B?OHBQa1hrbk5Jc3l4ZGxZeEg4aHJkR2xoNWQ3TEhtVGFoTDMramZyM3FVa1RT?=
 =?utf-8?B?L0hsK2xiOSt4cGRmakxHZ20xQWNEdGxxSG4zOTNhd0xPRFRXa0t3Qm1pcERD?=
 =?utf-8?B?aFhBZFFvUVdqWUw4ZEYvVHpOZzB6S0hiQ2FaWFpZUXJ1ZGJPZmsxOGJUS1dn?=
 =?utf-8?B?ZmJrM1I4NHg0NUpvdlpqaGY1VEE3Y1FUSUE3NUhqOFhMZ2I3a0ZPNjFhU1pS?=
 =?utf-8?B?K0FvMFI5TGRGTGZwVW1NaHVsWmp2OHQ4UEZSeHFvZzlDcStZV3VGWVA4bmxr?=
 =?utf-8?B?Z2xwQnAwS25IMFM0QWZZcUdWbzB5MEhXUkNDU2FVYjRrRVZJa1FLNnhKWVBR?=
 =?utf-8?B?eFpKZjlmbXJQMlV1MktNUjhMTGFaNGNGcy9wdHRIRU1uUG51akZhREgvUXBQ?=
 =?utf-8?B?eWRvWWZKeitiMElnM3FLZS9IKzM2citVcWV2Nnh1NUZvYnlMWVdPWW9HS2g2?=
 =?utf-8?B?SlFhTWF0alJ1emRyOEVySWpsVmh5MWdhdVRZdUZkUStYRGRlQ1JNUGdSUFZY?=
 =?utf-8?B?UjdsZTVJYWFjci9rZWlDSmJoTUJXL3VHOEQ1SkpDeXRNTmN4Si90TDRjb1lR?=
 =?utf-8?B?cjdIZXFJMlhJWjFuU3UzLzQ5QjFEWi9iajQ2aVBUNW4ySXYweTZ0cW16S1M1?=
 =?utf-8?B?NzhHZkJZUnluakpaY0xraENPcWlOVE1wZW82cHBrZTNOWUFQRDhqUEJnWCta?=
 =?utf-8?B?a1drOGFMYXo4eHdkZ0M2Um50b2taQS9PVDhnK0hMUzViQjhkM295YStJRHZ1?=
 =?utf-8?B?eThpNnVQQSt0dWE5NVByeVZlaVBQZGFJd2FDcFRvYUZhTGk0S29tMkdnNmhO?=
 =?utf-8?B?NFkyT3BiOG53dUEyc0dEaU5YZFlCYlJTc250TkpIYXNuWStDSG9qWk01cUZV?=
 =?utf-8?B?dlBPa0tTU1NYcmJWTTAyRWpyS0M5R3VvdWMyeXdmMGM5N0s4YXpTeFBHOHBJ?=
 =?utf-8?B?dzJQNkY4YktOcm5VVlN4UDBKcU1wY0VMS2VYMTVxeGdiVFI3bDlaaWRiREhw?=
 =?utf-8?B?SFdWVUZNMnp6V3prQU02LzNnWGlPczc4MHRiRTJwNFVZMU1KM2s4T2NSL2FE?=
 =?utf-8?Q?P0aM01ubXhe5oioE=3D?=
X-Exchange-RoutingPolicyChecked: CSAdlQlpF6rLTu5x4s25gTJaxdKi9PHf5i11CseIgR7vyzSzi4587HUaLQ86U7aYs1Eu8Lp1fYjUnml2y3bRbEfQVeeCqFWjgG2aUjR+oa7Nf/r0rA0IDk+QNgr/HBB1Wemh6ubwUYR33/QZXZDg3sK/Xj9C16CZQycm3/ff3oHDq8WtpN57jg/jNsfORmthUm1dkjgK+au+97oZ2rOHfuKDzC/4hX5QLBdVnBJze6JgLfo70xW0OOh/HMXILs4ll/N9Dh58urwqoBHSKtoBEZXst7jBiJxkQbrDXOI7s0DtXZHBARkpSutPUy3Ij4VK5Bwk9fF8SRDuon5wCWhVgg==
X-MS-Exchange-CrossTenant-Network-Message-Id: af162c18-2c34-4f53-ee7b-08deb7f5f759
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 11:33:38.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptkJSyVu4qYmLQRtOpJVQTUgdTFnlVH9EoJm8BOmuUbXFEv6MlUZHyggdZc8Wbwv6Zok/PgFgNW3fhrkr6ulTpfJ/78xbwLOfeHmrIf9iCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5918
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290791-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BF7835B329C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Przemyslaw Korba <przemyslaw.korba@intel.com>
Date: Thu, 21 May 2026 10:54:06 +0200

> Add padding to virtchnl2 PTP structures to match the Control Plane
> expected message sizes:
> - virtchnl2_ptp_get_dev_clk_time: 8 -> 16 bytes
> - virtchnl2_ptp_set_dev_clk_time: 8 -> 16 bytes
> - virtchnl2_ptp_get_cross_time: 16 -> 24 bytes

From my experience, it's better to not start lines with a '-' in commit
messages, they're sometimes hightlighted as removed lines. I usually use
'*'. But it's up to you, pure cosmetics.

> 
> Reproduction steps:
> On ACC, run: ptp4l -i ACC_pf -m

Agree with Joshua, it's better to not mention ACC on public.

You can just write something like:

"The FW expects the following sizes and the PTP negotiation fails
currently due to that mismatch"

You can also mention that previously the FW (or idpf) didn't check
message/reply sizes, thus the problem appeared only recently (I bet PTP
worked a year ago when Milena was working on it).

> Observe: failed to open /dev/ptp0: Permission denied
> 
> Fixes: bf27283ba594 ("virtchnl: add PTP virtchnl definitions")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/virtchnl2.h | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> index 02ae447cc24a..ba953dd5fb67 100644
> --- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
> +++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> @@ -1572,13 +1572,16 @@ VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_get_vport_tx_tstamp_latches);
>   * struct virtchnl2_ptp_get_dev_clk_time - Associated with message
>   *					   VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME.
>   * @dev_time_ns: Device clock time value in nanoseconds
> + * @pad: Padding for future extensions
>   *
>   * PF/VF sends this message to receive the time from the main timer.
>   */
>  struct virtchnl2_ptp_get_dev_clk_time {
>  	__le64 dev_time_ns;
> +	u8 pad[8];
>  };
> -VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_get_dev_clk_time);
> +
> +VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_get_dev_clk_time);

Don't add empty lines between the struct and the macro check, it's not
related anyhow to the fix and no empty lines are intentional here (even
if checkpatch complains).

>  
>  /**
>   * struct virtchnl2_ptp_get_cross_time: Associated with message
> @@ -1586,26 +1589,32 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_get_dev_clk_time);
>   * @sys_time_ns: System counter value expressed in nanoseconds, read
>   *		 synchronously with device time
>   * @dev_time_ns: Device clock time value expressed in nanoseconds
> + * @pad: Padding for future extensions
>   *
>   * PF/VF sends this message to receive the cross time.
>   */
>  struct virtchnl2_ptp_get_cross_time {
>  	__le64 sys_time_ns;
>  	__le64 dev_time_ns;
> +	u8 pad[8];
>  };
> -VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_get_cross_time);
> +
> +VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_ptp_get_cross_time);
>  
>  /**
>   * struct virtchnl2_ptp_set_dev_clk_time: Associated with message
>   *					  VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME.
>   * @dev_time_ns: Device time value expressed in nanoseconds to set
> + * @pad: Padding for future extensions
>   *
>   * PF/VF sends this message to set the time of the main timer.
>   */
>  struct virtchnl2_ptp_set_dev_clk_time {
>  	__le64 dev_time_ns;
> +	u8 pad[8];
>  };
> -VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_set_dev_clk_time);
> +
> +VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_ptp_set_dev_clk_time);

Besides the nits above:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

