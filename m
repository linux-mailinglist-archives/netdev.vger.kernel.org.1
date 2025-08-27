Return-Path: <netdev+bounces-217491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D77DEB38E4A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BB474E2AF3
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 22:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F42E9EA1;
	Wed, 27 Aug 2025 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOoF6eYz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0034B2BEFF3;
	Wed, 27 Aug 2025 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756333360; cv=fail; b=OpW63Ifc1VsXcSftvwHXD1ka6PdnVhpWJWtVKltaz6k6m92C1BgTX5eFHwAnfd0mYl6P+wllcn41dniR1YVtuUorQ41xXTRfbdTDoS40Kn0bZKSXRSaUcvxBYBYCWIiCRhEMRCUpVkgJMlnpnJfR1GJrjDbnOe1OinJiNGBQQfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756333360; c=relaxed/simple;
	bh=b9V6nbuP0kWig2/nhNiRwvB2ZwyW4j3IqzwJ+hLwKzw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cfX+ciFtYB1+Tvov3YN4EEB3pe6C/fzbE3BtPJzMnDHQyYw3HWUDW5FSYCFS3EIG7FAcFeMAq0IDtrmJFSRS6oYNO3v6NX0J+HAgdUydPgtDuNTuvM1rz7wv5p9DWp68zQ8M5bI5/fpPZ50Kfdm8j9EOBCE4HrEY8Pnuz2IKPsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOoF6eYz; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756333359; x=1787869359;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=b9V6nbuP0kWig2/nhNiRwvB2ZwyW4j3IqzwJ+hLwKzw=;
  b=GOoF6eYzOz1g4EwX8Uby9P5Q/l2L4N8auxLjXYWRbeM7a1iAC7lVw9wc
   s5P+8Tg7bEC9JIdLBw7xndBBc7UpyIMvT4jdaesz9wvYzjvDUrQnYbDOh
   bHy6ncuU07Y0MAulebWpeehtjqo8nBm0DaDkGgFG/mztSw0JvbAxXCvDs
   cUvJS5VDLNeF/fwV6pmlEQnmTH7Kzu1+HGU1Eu5wX1wyjUrTojzeUS9dR
   pZYz2xzR4xxR1cO24OkRTLu/Kb0mudZir2Z/x4/MTfJrX93+HScJkeYvP
   rFPX3TlaxDc5YByv4DmXRnG2w0uuF6ld3VzhWAFXKcAQcJZ2VQn2qdiV6
   A==;
X-CSE-ConnectionGUID: rSBe+aUTTbm/bdK9W8pxHQ==
X-CSE-MsgGUID: iridMV6xS8GmYVcTPBQkoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58518283"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="58518283"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 15:22:38 -0700
X-CSE-ConnectionGUID: szrLBe2fTqSBkBvtVnSw7Q==
X-CSE-MsgGUID: 9fXO010xRRy5IU7fZJmRtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="asc'?scan'208";a="169200849"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 15:22:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 15:22:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 15:22:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.62)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 15:22:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cF0KRlJC0WruyQ1PuVBBQRajZo1rWaqbjafr2+HSnVBvL3/fSlJz4zp3NfeeWIIiq3O6U2BuDWl+hd2OTkC6m4CjdH4AXsSW5IHq/0rQ+wdPw949LrHoYwmqrso2tAwurJQeso0HfjAQzIwulXsFAOs0A2hDwKXmqMpHtirhfQDcCcTZOGu2h1Z7TbOBXwllmuvTLqwMUVRyuh0H4SC0xAxNicFAhKzKurrpNXIMxuypq7VW/fwGu2plTfjOKmKRF8ezFMgG8WtCOcD/WiXpB/4/TfNkjdmU0NMb4/EwCe0tYFf+XKxh767p33bdL9PTYW/r9z/p4tYWhanpOXRj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VY422jZSq2UOCj8uu6B1WZsEN4uzT7neoNzpm6gl/CE=;
 b=LxLnp0Xf8Em57UNs5ShRXh/c9j/lOfQF5u+ZFYcGdHCEVRRL2g6qk5X2o8c9qUXeMMWYIMUn2HJom+gaaxaOrktzFFdGDZK34g0RccZzN84t0na+Xwh/helVU+g8yMQBzk+LPjiTOAWArHaDSt1S4kPIjZrqlKm3oYcS+3yZDJZAP8uuNAxsQdHTyLKOH4L64xMak36EUbuJAgmaoUBQ0pt7SoyURdIywRf0kCzHUBIK7XNbTqQfnj1g+N+xP4G5IMG9Nf7H/uyxpux/q0Xb7lD5kv1pf5SXv24KUZeMZpksss6C2KrhfwTK2y7huiaJI/sholQ/HyJGbeJliu4iTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5021.namprd11.prod.outlook.com (2603:10b6:a03:2dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 22:22:35 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 22:22:35 +0000
Message-ID: <a254a4ef-2220-4a72-80ca-1a9fa046c1c6@intel.com>
Date: Wed, 27 Aug 2025 15:22:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ethernet: tlan: Convert to use jiffies macro
To: <zhang.enpei@zte.com.cn>, <chessman@tux.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250827155455583-PdvmDYA9SD3J37_XRza5@zte.com.cn>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20250827155455583-PdvmDYA9SD3J37_XRza5@zte.com.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------T1ixrae4HC7p6w9np5XrndRk"
X-ClientProxiedBy: MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5021:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1c7b80-be54-4f6e-e374-08dde5b8383a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3BJb2IvWjI0bmt6VEk0dE9tWXJkZU1yUUt3YUJpaVZMTDJ0M1hxdmhOT1lN?=
 =?utf-8?B?ZzY4d0k3Z3JraHg5Z0xhNkRnU1JPbEtXeDhHZWRDMnA0ZzQrckJ6QTFRTTVn?=
 =?utf-8?B?cDlWU2I1OGZybXdqc0JKOGNIMlFscHhYL09leGFZcFUraUc4ZGFuTTR5cEdV?=
 =?utf-8?B?OS9UNjk2L3hqQU9zNWl4UjZpcThjTktxM1pCYnJ3VjFUWlg0VFZacE44SExO?=
 =?utf-8?B?ZW55THhFT2YwRWcvUXZhdFEwOWN4aHhsejlHam8wNEs2RnNlZEErRVdHWDVD?=
 =?utf-8?B?Y2RmQldoN0V5WlJrV2xGMkpYUEw5aGtLeXN1Skgrc1k1UEZITWhZOCtuUHc2?=
 =?utf-8?B?dU1YRGdobVNRT2pPdWlNMHIzR0FibWdGdGpHeWFwaFN0ZTk4ZFcyNk41QVc2?=
 =?utf-8?B?UnA3TFVIZXo5bzZDSksvWncwVUpsU1FDWjd5MVQ0S3dhZURXbkQ3anBpV096?=
 =?utf-8?B?TTk2N3hDYUthcys5dzdDa0dRczRCSTlMWTBBc0JzZlBNR1IzL2QwQVBkZWcy?=
 =?utf-8?B?S3BPOGovZVg4aEp0YkZuaTFmTFVpNHZzeWYrRHNwVldmdzFNR1FwelBva1RX?=
 =?utf-8?B?cCtBUVB4bmE0cHJLRFNDelFsb1NEQXZyUmk3UnRrMDkwT1E0Z01XaEp5YldO?=
 =?utf-8?B?ckp1WHlqTVBUZDN0c1dsVlBkZnRzNFVqQVFiemVtanNseHlvcXBYUVNVbXJP?=
 =?utf-8?B?cDd5OGxZVmM3L0RzTHJuUTVNem8yWkxGZ1VUb2JKaldXbGdadzV6ZUMzSTVk?=
 =?utf-8?B?emZBVDE3OW1jUWdodk9JQkUzM3ArYVpRMzNwMlgwYzZNdit0QVFEaEplbmVl?=
 =?utf-8?B?L1dGeHkzaVYydXMvWWRYTDVhMGlVRlkvZVljdlhJQVNWQkR3MHJtL3diUDBX?=
 =?utf-8?B?NVdCaUEvYWwxNGZJVUUwZTZZU2RteXVhY0I5VnZ0RFZ5YVFTanQ4UWQ4SU91?=
 =?utf-8?B?emFEdkw2bXBRdXhzaTRLbUhYZkpEM0o5WStTa2w1b1pPTDZlOFRLMFBoZG5k?=
 =?utf-8?B?ampYZmIxSk9WWHc5OGRPTmR0a09EWFd4THhsbUlSWkhtYmg3cjJRc1Nlczl5?=
 =?utf-8?B?aHRva2V2NHhiS2ZNQVZMaHBlUGh3VjhDMml5bU5BK0hOTmMwQUxPR0NjZTJR?=
 =?utf-8?B?K1VuY1ViekNxZTlKNWRJcHR5enZIWEFWWC9ZQi9qS0xyS3A3dGJidUFES2xU?=
 =?utf-8?B?K3ZPdFhuSjRSdU83SnhjMzZWa1Z3OXVQZHdzVFZTWGdnV2JaNGEzcWp6Ky83?=
 =?utf-8?B?TkUxcVYzRzBoOU91d0JDKzM5dWttTkJjTzIwR1F5TU1VVEpxUlBZeGI2VTFj?=
 =?utf-8?B?SzRnL2c0eDd5bTNDNUJCMDVsRmVNUGljZ0lqTHJCK1RTdlRPbFAwNENGaU1R?=
 =?utf-8?B?aWxpVUFGclByNmRrZUhscHVDWFBuZDlHMnNiTFBSbENoSzcyNnE3NVVtVHZP?=
 =?utf-8?B?cm5JeERZK1hScFppZjRXV2g0d1FDTUZNVW1Jc3M3V3k1ZmJmbnpPakFpYVY0?=
 =?utf-8?B?S1dIQU0zNVNvNVBhcG9nMHBnL2RCT3ZUR2UyU0tsNG81MzRLSU9iTkdSY012?=
 =?utf-8?B?U1B3bUpiRFhiNmdrRUtUVHV6cDZxTEFUR1VjYldFb3JtNW15WE9XYVJUL091?=
 =?utf-8?B?aU1WZml0YWRwMHUvMFdGRm9RVE1lUGJnamZaYlB2emRBM25Tb2s5UlZxbUpT?=
 =?utf-8?B?M09DMzVhWkNCbkZqalNBUmhWL2hKRnRlcmNQcnVqZktEN1BqcTdTRzZON0Qy?=
 =?utf-8?B?TDZ4Q0ZiTXpMZllhVjZsdnQxOWRTbU1lVms0dDFaeUMrYVRzbnhELzFGSlRS?=
 =?utf-8?B?RndxSjhjR2pnOEdways0UmVZd29HV2FMdU9IUDFMRUdKSEZrcTI3d0Y2Sk9F?=
 =?utf-8?B?QlZpQThFRVFpck1Sbm52S2Fibk83LzlRelczWWY1MzY3RHZzUGJQQUVsbEl4?=
 =?utf-8?Q?6Xu+bg+TiB8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUtIeW1Pdzh3dE0vaE5ha3NnY3ZRNmRjRndPSTlrVVNTdVowbFVQSE0rWDVK?=
 =?utf-8?B?K0cxWU1VMnlYTVpGdDV0Zll2KzUzRVFQanhIdlQ3bUI3dDQzMTRaVHRxQTY2?=
 =?utf-8?B?ZWhBM3RBRk5SQUs4K0Y0L1FBZkJJWkhCcWZDbWcvNkk2SFU1MGM1WDRvNzNO?=
 =?utf-8?B?ZmhzaUJ2ZnJHdzJoQTRTVHZHUnRLQUpPQzJXeVQzMGdndlNKTzJoam5tTWpR?=
 =?utf-8?B?bXJIbWYzdTV2NFBYVm9XN01ZVFkrWEFZNmt6YjVUZGgxMXE2WVJUeFc3ejlO?=
 =?utf-8?B?VmY5Ly9TVnBTNFBodjk0S293elptNWI2T0llUTBMaDlXeVdOU3I4VGNIT2Rt?=
 =?utf-8?B?eXFoYjduRHJlRXhJMEo2a1YzbUovdkh6TWpmWUE3bHlGaEl4bjU0eUdPYmVm?=
 =?utf-8?B?M0MrNjBHWmZTNzVLTnYyM0VYMXJ1U2ZKUXQ2dXE0WTBqaXZtaERYV1hHSVh2?=
 =?utf-8?B?QzgzV2dLMVBuV0pZY0ErTEJGSFpDRFJibHlMdVFrRllRcUgyMVdpaGt0dk00?=
 =?utf-8?B?U1NOU2d2ZklycnNpeTZGdGtZNkszVmJKZUk0WVJDYXR3OGpFK2x3NVFRN0pQ?=
 =?utf-8?B?NDRBMWxHU0dPTGJwdVVWVzJROGJNYUU3Q25VSTBNc3g0QkN1ZHdyZkVNeWhV?=
 =?utf-8?B?TkhMcmhwbXlJcjc5akJPTmhRQXdYZExRVzNOV0p0ZUthVTlaTWVtYmQxV0dz?=
 =?utf-8?B?TWFvS1pxRkdMeFY3dE1VQ1M0N21rVlhWUitkWCtXWkVQQ2VZRmJJaE5hd1px?=
 =?utf-8?B?azU3Q2lFeklKT3ZsOVJkU1ZFaUIvdVZkV0tpMStuV2xVYWk1aUs4WVVUdk0w?=
 =?utf-8?B?ZkxIbnRWNzYrMndaUDJUb1dUWUd6UEhsMUNmUnBpU05uQzQ2QkFSUk1vTjN1?=
 =?utf-8?B?QUsrb0ZzZW9SR1ZWOWRHUDBjdGhpVytDbU1ER000TERBOG9xUnk1dTlZQ2o4?=
 =?utf-8?B?ZmlKRG4vZUdXelVCdXJnb2kzUlh6MlpZQkNnUEczUHNod2VOdFJDUW92SDUw?=
 =?utf-8?B?L3o4UC9rVEl3UGNQcmptNUdzNGxSVytmd3dieDduSTl2ZzhIVmpHaFNtcC9y?=
 =?utf-8?B?bjVxMkNTWXdiY0NEZzJZVk8rd1BCYThYUEhidm5rVmc0RUNGQzh0ZHZ3bkxk?=
 =?utf-8?B?elRyOEFvS3NoVUtId2JiTlNHY1RyaXRFdnI0bG5EMnZEWk15V0hNdmRZb2x2?=
 =?utf-8?B?QmdqSnhkRUZveHBMb0RGL0t3VWtKcWRucDBQTHRhZlQ3eFFOS1kwVjZTMUFv?=
 =?utf-8?B?ZXhVa21OZ1NRdUZDWXFDRlZLYUxkL2FkOFI0bGxiUWJSa0h2TTNtd3NNM016?=
 =?utf-8?B?OWlJdnhDTlN5LzFPWjRaeldQQjJaSWJVdHFSSmEyM2lueDJZOTJ4blpRUnRI?=
 =?utf-8?B?d1FvZ0NzNDhQemhXRVM4OXl6N3N3RFBqTjVMclAxS1l6M21vQUhYaThSSFBa?=
 =?utf-8?B?VXhHdFZrVlhJUnNvZEVtL1hEQ2YwNDg5aWlQd21udUkyTU1TM3VTaUQ0YkxF?=
 =?utf-8?B?VnhqMGswc2Y2bkRtS1lwYks2RTE5UndIMFdLWE90T2pBYU1udmVjbnZJcDFv?=
 =?utf-8?B?NmpJRHZkSEpEdzVmU0Q5MEV5cVFKNkF1cGdyR0ZCeXVEUWsrcVl3S01zNnhQ?=
 =?utf-8?B?Z1RaSnpEUUJrc01vSWJKWTZRc2tzSnJGcmQvQjZTWTRJcTRRWHhNcWtUNnFz?=
 =?utf-8?B?Yk84V3BsNUtVL3piV241RGQrVW0rTmgzMXNOejRsR1JwL3FmZ3puemVYVndH?=
 =?utf-8?B?SXRyb2xmUGtvRkhzUERrenNHN292dndyUVUzNHIwVFEyTUNmMzlSMTkvMk41?=
 =?utf-8?B?VlRnWXdVakhhc3NrVGp4RVRuUE41eTVpWWhUR1psdlhSaVhCbTVmSUR0VG95?=
 =?utf-8?B?VmZpZ3NJTmx5bmlDT3V6OFpDVnJmaWQxb1B3M0U0N1MwVytzSUdkR1pwU0Vx?=
 =?utf-8?B?ZUliUnpsdHBGS0tNRmF1R3g0Qjl0UXk1NHcxeUNnVnA5L3N0TWVWT016aGlq?=
 =?utf-8?B?SEZBRW9KMng3eXJZMmZxM0JoYzFqUEJQV3NvNHhlUVZLcXBpQlVnaG5oSnhh?=
 =?utf-8?B?eUFMRGVpek1pREFTbjdTeHVYUmM4RWU3ZTEyd0crUHpZZklzK3lxL3ZQT3ND?=
 =?utf-8?B?TCs1S1ZzaWgwR0hIalkxeTQrZDhqMDUyYWNnc3VJVjhqWjFPY3NzMHNlZmdj?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1c7b80-be54-4f6e-e374-08dde5b8383a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 22:22:35.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: no406WjPE9VXBTN02aXH0QQPlMLMfH42MvKLOK4lLKFN9uuninaOc2yOKrGdX17O0NSKGG0tA3lcc+HsHduZODjv6oRGwjF6sn3MozN8KwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5021
X-OriginatorOrg: intel.com

--------------T1ixrae4HC7p6w9np5XrndRk
Content-Type: multipart/mixed; boundary="------------l8lwiuDsvYGt0rvRvkvLNQlB";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: zhang.enpei@zte.com.cn, chessman@tux.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <a254a4ef-2220-4a72-80ca-1a9fa046c1c6@intel.com>
Subject: Re: [PATCH v3] ethernet: tlan: Convert to use jiffies macro
References: <20250827155455583-PdvmDYA9SD3J37_XRza5@zte.com.cn>
In-Reply-To: <20250827155455583-PdvmDYA9SD3J37_XRza5@zte.com.cn>

--------------l8lwiuDsvYGt0rvRvkvLNQlB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/27/2025 12:54 AM, zhang.enpei@zte.com.cn wrote:
> From: Zhang Enpei <zhang.enpei@zte.com.cn>
>=20
> Use time_is_before_eq_jiffies macro instead of using jiffies directly t=
o
> handle wraparound.
>=20
> Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/ti/tlan.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/t=
lan.c
> index a55b0f951181..7c5e51284942 100644
> --- a/drivers/net/ethernet/ti/tlan.c
> +++ b/drivers/net/ethernet/ti/tlan.c
> @@ -1817,7 +1817,6 @@ static void tlan_timer(struct timer_list *t)
>  {
>  	struct tlan_priv	*priv =3D timer_container_of(priv, t, timer);
>  	struct net_device	*dev =3D priv->dev;
> -	u32		elapsed;
>  	unsigned long	flags =3D 0;
>=20
>  	priv->timer.function =3D NULL;
> @@ -1844,8 +1843,7 @@ static void tlan_timer(struct timer_list *t)
>  	case TLAN_TIMER_ACTIVITY:
>  		spin_lock_irqsave(&priv->lock, flags);
>  		if (priv->timer.function =3D=3D NULL) {
> -			elapsed =3D jiffies - priv->timer_set_at;
> -			if (elapsed >=3D TLAN_TIMER_ACT_DELAY) {
> +			if (time_is_before_eq_jiffies(priv->timer_set_at + TLAN_TIMER_ACT_D=
ELAY)) {
>  				tlan_dio_write8(dev->base_addr,
>  						TLAN_LED_REG, TLAN_LED_LINK);
>  			} else  {


--------------l8lwiuDsvYGt0rvRvkvLNQlB--

--------------T1ixrae4HC7p6w9np5XrndRk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaK+FHwUDAAAAAAAKCRBqll0+bw8o6OxQ
AP9rKauvms7DfYzrs5XWkbdCnN8nSLX8+IzSRLfNWlfetgEAiNA/tN1mzqVYti1UrG34KLpgyTXq
w+ky9LwehRTP4Qs=
=cNJD
-----END PGP SIGNATURE-----

--------------T1ixrae4HC7p6w9np5XrndRk--

