Return-Path: <netdev+bounces-207959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DFBB09299
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7618F3B732D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3802FD86F;
	Thu, 17 Jul 2025 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DC3k79id"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6165EA93D;
	Thu, 17 Jul 2025 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771838; cv=fail; b=qDYngYkdxZbTBm988+pM4zevQF45ltS8EAaKubuTEBhsBRDLo9+r75liU0rMm6rEpFoqRQZyt3VbqZ+fGsPmbX7LXUSA31qvIKOdxeet5SsEiIJ4MVxo98d4kl32BXcjfzaHa/aydwwYPacysUCBPmYxVCjsLY+8ydqjQQC6PWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771838; c=relaxed/simple;
	bh=tdYwAnQu5Xr916YINYMfsr+OHPJapFdQVNrrg9kqgiQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n7v4EKpREowdy1Jx4KMh3+HWDyCmLWLhQSf3fU9TMtVq79//Rcor80TzqanpGT4q/08w3/T6Y8yZT558OarRDTzBLfD4odvFZMsbq9tWE/1VCMZml7mrEGKxWapcbNPaty9a2nXNA2YZSpb8nTLETD0E61xtuvkQoHhgxDJnyEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DC3k79id; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752771836; x=1784307836;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=tdYwAnQu5Xr916YINYMfsr+OHPJapFdQVNrrg9kqgiQ=;
  b=DC3k79idNgD/S7pVl/mQtzniu/m7M8zZbXeDmRZ0hGmdw3nrto24EGKr
   K1bYhFnay0PeY8IpBMQLF4y6nRg6KzmdLAW7OS/Ator5m9FyQxduiFF0F
   Is7QW0/kGAdROS0fqUUFAQQtRjQMOEi1hD2wPHSjRIBAJbJPS5CVR0gha
   xnFGb0N01TlK/Hy29lWboSp7/57Jo5xAjI7/AnefujOKT+Vvu9NFhdTLZ
   01tLZ4SUMyX2MEPyJnYB61IlMgrDrlmhI8FMk24is4iFAKhzq/hYUc93B
   uvhayslW0CFfPbqribhCJDumbvtWpBPCyxb6ljYk/QA4LapDuglxGQpoa
   w==;
X-CSE-ConnectionGUID: Nk09zjcWTWSKS6We61/8Jg==
X-CSE-MsgGUID: zXdzUJlPSbuJncaRt9+F5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="58726870"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="asc'?scan'208";a="58726870"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 10:03:54 -0700
X-CSE-ConnectionGUID: wo7XIiGuTAOpreDpX+I+7A==
X-CSE-MsgGUID: /5E7/cYhS5OIzfx4QH5Czg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="asc'?scan'208";a="163486939"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 10:03:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 10:03:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 10:03:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.84)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Jul 2025 10:03:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAbxbR0kTpqCr/exp0FuWsZ7tgrFfUQDHii3nvTLIfcUUanv1zJQopGTnfS/QWToWO5Sbhah0cBNeJNAYoE5SfHGqWWcqzzoHC7dMnLrQJk7cWNyB59C9wSlwIb3u1rzazV6EtLLyAyBh1++x+VizAhiOWf8ISFgXVmJpQhAS9Z3GxXF+ArTO+OY1FzHiRpZct7Qd4qjJXW3j8zYiYQPFBb/tzbZWGztzIrEVUmIhOBssFnLksFO+u6Lcf2RvD2GKmLG4gULGp4uUU6G5wAuMT3nb7rYM2SIjK0tqvnY10/JAy3kg3DLA7VAOKzEY+nlZcGBEp8c2kl0KauC8xmnsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdYwAnQu5Xr916YINYMfsr+OHPJapFdQVNrrg9kqgiQ=;
 b=Z+5RnB7irFRcB0vUuaytZdls7wWzTi4pSI4EiM1xOWYuLxJJ0d0IimYhamL7Vh2OR0ZDFUrPiJllVUmP82KMxIfg0kON6RGdvjUQ6Lm0RgN45zYE4ygegbzq+BqpMX1JHMONZjqAbHs08M7wOeKsducF94PEWyKrNxuE+huaVinFVOeocXrBPc/SZEurT8x1VgOTBI+TzA1k7AaU+QLsmPUQi8M3it5IaWndjJm1VEVZ7FUrRxW6X4g5neNAlrRKu4L+hLyVBXxbEl1oHuc32f+U8KgQvBXFEJDvKH/CNXezjfDt6z6Abhu8Px4U/62yaH4KYzSgWWsi9cYjGMBi1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 17:03:52 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%5]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 17:03:52 +0000
Message-ID: <489c52d1-cad2-473d-86ab-cdae51b043c7@intel.com>
Date: Thu, 17 Jul 2025 10:03:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: We found a bug in i40e_debugfs.c for the latest linux
To: Wang Haoran <haoranwangsec@gmail.com>, Simon Horman <horms@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <CANZ3JQRRiOdtfQJoP9QM=6LS1Jto8PGBGw6y7-TL=BcnzHQn1Q@mail.gmail.com>
 <20250714181032.GS721198@horms.kernel.org>
 <db65ea9a-7e23-48b9-a05a-cdd98c084598@intel.com>
 <20250716083731.GI721198@horms.kernel.org>
 <CANZ3JQRwO=4u24Y17cP3byP8mS9VOP5g=sy_Ch_g0xKSDJLhKA@mail.gmail.com>
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
In-Reply-To: <CANZ3JQRwO=4u24Y17cP3byP8mS9VOP5g=sy_Ch_g0xKSDJLhKA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------vfeSAzf3ts5NFeXSaJVrImb5"
X-ClientProxiedBy: MW4P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::27) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|LV3PR11MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: 224ea281-1e38-4911-c928-08ddc553e782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHdxQ1Y3elBwWjI1dnpLNTRKM29RaFBFNmwwUkhCRWVpb1AzWmVrZWxOeEEx?=
 =?utf-8?B?VnVCNVZHVkpCdHhEdm1DMmlDM0F1c0JVSkhKN0hHZjhRclMrK3ZsTGpyWUFv?=
 =?utf-8?B?azRya01DS1R3dzVDTGo1NTFmbTc3SmZBQjZCazZUV0RiZUFIYi80NnN0RFU0?=
 =?utf-8?B?NFNiUkZ6UExWWURNejlyQ1pjb2p3ajBYenpmWG9XMnJJbmh5Kzhxc00zRXdJ?=
 =?utf-8?B?M1E2cGVoTHhBT0dPdC8zNlpScTNKV3pMQ2lMQWlOQjh5eUM0eUR2SjRDTXFy?=
 =?utf-8?B?T3QxMlhlZzhkZzRzVGFIL2FqTkRRYko3eDErMVhTK0dKdmxHeUV6YVRVcFhW?=
 =?utf-8?B?UEJ5czNEelhtMlorTG1KcisrTkRVSjZQM2FEOHF2cVJzOVFEWjBraDRKZTdu?=
 =?utf-8?B?d0NrbUE0bTNuTnZsZndidVBWNVFnZGNEemZ1K2tPOWc0VmtzUFlRQ0RRMS9V?=
 =?utf-8?B?UDAxMDV3L0JpZ1RUTmxQZkc4T2t0S3dvTGpZNnpvZWhhdlIvdmRuQlF6aXZX?=
 =?utf-8?B?Q0p0dEpBRlVVUjBkZE5GV1NLUVFsREc1aWw2OTlqY01TNDdXam04NHY3OWZo?=
 =?utf-8?B?K1FRc3dEdUNSL1dLNTRTUC9sNjZNWXQvRHRrTHZYZ3A2UFpkMmJuQU1pSXZ3?=
 =?utf-8?B?UURIU3dybzl6cEtFMjdZVWhLSmdKdFhVc1ZDWlk1UmJ2SXRyTE5Ibmc4M1py?=
 =?utf-8?B?bWhNM3QxU1E3Y05SWSthZ0RWYlNDcmdvSWlkR2llUkxTVVh6NHpvZEtxTFBN?=
 =?utf-8?B?SC9jY1JKSDVGaGl6d2tTNWtycUJiUVZTYnlFNDEra2ZGaUs2clZKbVpBblBE?=
 =?utf-8?B?U2xLczFiaGg0NVdSVmZuQTZDY2VuSHh0VVpUdjBDUXIvTHhVSWlVN0lJY1FT?=
 =?utf-8?B?Z3NLVE1SNEcyMzNCa3pCNWd4WGEyYWtTcE1FSFN5ZmFhdytjM2U3aDAvclEy?=
 =?utf-8?B?ekUyV0tSNGwwV2NDVVl6Zk95bk80TllQTGZOdno5RzJqZndFdmpOaVFCak1P?=
 =?utf-8?B?Ky9DT29mc3dHaEVXQURvL1lCdVpiYjMxUGo5ZW1majR2VW16T1ArM0RLMFBX?=
 =?utf-8?B?WEpKWDFieE0rbWgrNkxFWDRuaS9DU1g5UWJPeVVNT0w4SUVQYURWZmZQTFAy?=
 =?utf-8?B?cTB1U1p3dy9Jb1BydXVKYUpnUGMxR1V6Wk8vRDBzZVo5UTZFdFpPUHp6L2JY?=
 =?utf-8?B?VU1xNTZSYnBkeUYrVlpFaFJUN2poTzRqdUVjc2ZxcGwrTTZIbzhneDUzS2tM?=
 =?utf-8?B?OHVaazZCeUltazZkT2Q4YWxwTCtuNGpHNkxJSzdVMWhRRG1CSkVSMlNwTTAv?=
 =?utf-8?B?MndETlpwcmk5UjVrV1I0MUsvaFpuS3lBTE1yTUd6QzE5UWZpbTNyOFJDd2RM?=
 =?utf-8?B?cDNuZndKNFl2L0dJUmZCZldHOTFENTFzQ0NyVzFwOGpJa2N4YmprazV3MlBI?=
 =?utf-8?B?Q0tIWloxQ2F1VFRFaUhCNzNMRUxxTGIrR2RTWWJLSmM5UWtzMlpqWUhWQ0JV?=
 =?utf-8?B?MkNIL2FVNGErdFRRa3ZqamZpSlFvOXE5UWtPcDlIRW50VkZoOGxMOE91aklo?=
 =?utf-8?B?TE1DcWtVRElrVVR5M3NHSGE2eEtFVzFBODJpa09UcXFUTnRZZzE0NGRmRlpl?=
 =?utf-8?B?YjRQWStaVnN4NHRoczJNWUtJdEF6YUZoajIxc01iTDhPK2UxZVRhQi9qVVFN?=
 =?utf-8?B?RXNpcFd6ZUZXS1dSZnpaMEtkNWJXSlB4UUJTdzhKMjBrQ3N2NEc4MjlsajF6?=
 =?utf-8?B?OVE1QUNmQnoyVFNUVXVuZ2FwTWtaL3lkZlVvT1FQeDJoemxRRk9DWks3RHJn?=
 =?utf-8?B?Sjk0ejR3SDdtNzUyMG0ybVFvSVI1K0ZoUkJaRlRnT2FraXc2VHlTaWdHcWNV?=
 =?utf-8?B?WkdMTGRUWDJubXBxL01vMmp3LzE4SWxDZ2ZVRTg5aE9SQXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlNqT3ZKYXJxWXZtSUo2TDhCOHNDS2xqc3hSK3F6MUYvaW5vNVJnejJCN1lt?=
 =?utf-8?B?QzhPL3BjdExBL3hMN2xUS1REaEdaL2lCb0VVblZZQndydHZEMi9BclJXOUZI?=
 =?utf-8?B?a0VJSXY2T1l2VkNmcGRoQndsL1A4NmgwUUxhSC82bUxNVDZ1bEUyN3Y5TGF5?=
 =?utf-8?B?Z3JWeUVuMG1XUEoyempCcHV2UmJQalhLOC9PcXhkSHY5QlhQdCt4dEFDaWox?=
 =?utf-8?B?V25MQXZRbFBqRFNIRHBwd09NQ01PeGJHanlQdVhMUU9aMFkwTHVSVEhENkRB?=
 =?utf-8?B?ZXR2VWFNZUQ3K2IzSG95UEhtNEVsZkcvb2hhbVFmYkZiRXJLNXBYKzcxYzVn?=
 =?utf-8?B?eDdHTnpIQm8rM1BBMEdaN2tjUjJPaTZ0eHJSdUppaWF3em1pY0xYUkE1SThi?=
 =?utf-8?B?c1dBcUdYTHRWTWRSVm1WRUNCU1BSNE5LMy9yOGRMKzg0d3QwY1p2dENNSzFr?=
 =?utf-8?B?cytjOXJlVEpYUjVla1QyVFpJd1hlcG1XTGFod1VRZFIvTWJxTlJ5TWxWOExO?=
 =?utf-8?B?Qzh1MEt0YzZybjRRUVlZc3JuaDZpTXpJSm9OYjF4cCtJL2hMRGF2T0ZmdFBw?=
 =?utf-8?B?ZUNpRm9GNHcyZ3VGTWlJUmlTZDZvZkZWMVhkQ2NpRTFsVDkvV011ak9HVG5y?=
 =?utf-8?B?WUk3dEtHd093b1J0TUw0RW5OcldpUVB2Mk9TTTlXWlNCMjlIK1FaOWRuOVhh?=
 =?utf-8?B?Z2tFdFpGZFlwVHNFQ3pGNVRUM2xhaW5USUtCdW9VMC9aRjQxUlJEajh2dFp5?=
 =?utf-8?B?eVZCVmdjM2VKOXJVMnoyRE1FK1NlMDNrb2QwRllDTkw4b0d6L2pOS0IwWENk?=
 =?utf-8?B?NXJEa3NhVXVHUnlnYWdLM1lLcUhaTUs4UU9Fci8wTnhGUlNpZFVoZis1czNx?=
 =?utf-8?B?NVFDUnlHeFdScGJNTHBUOXRHQUtwSllNcVU5WnBTdjlUVmpXY0x6TE9MV2tp?=
 =?utf-8?B?RDFQeUhUTXJaYytwZDBkREhPeU9sRlhtbW9NUE1TYUZpRjhpYk4xOWdzMGwr?=
 =?utf-8?B?eTRLR1VnejRDeTJQZS9FdkNRYTkxNyt0T0RuUG85TmRhMkNrLzk1LzBGSmFL?=
 =?utf-8?B?bXRUWkRsZ2M5T1RNQmJSZmlEZGY1NUlveGpsT2twcXlhb2dZNnE0VjJqTTFN?=
 =?utf-8?B?WGhvYTI2ZjV6aVlTSm5nRkZyMU04ZjFONXZCa1NUZU1NK3RRMzVLVXE2N0d3?=
 =?utf-8?B?VVphTFdvUSt0MUJoaU80VFhqcldCT3Q4TVY0NlNhTGdsL011RTZyeHkzUVdu?=
 =?utf-8?B?OVFaalFjbXZIb0NlZnlmOWwzSzBYUjZYczlocW5GS0Jud1Y3M2JtWUZNRnJv?=
 =?utf-8?B?NzlrcGJrdUNtRVN4c0pFNFFUZGNscS84MTVjS05adFNnZGJJR2ZKb3JYWTk4?=
 =?utf-8?B?cU1kYmludktCcU1FMlpUdzQ5aktQY2x4RDJ0Zk1iL3cxUVI3UUhIYUhZbE5H?=
 =?utf-8?B?bWJEQ2pDVFlCVHVYNGxIOERibys4K1Y0WTNzTUdSakRnVHovSGVCR08zQ1Zt?=
 =?utf-8?B?R3ZnVXRkR1VGL3lQc3dRODZyY0pDaktPMG44dU80dFg5a05LS1l4NkhmaFg5?=
 =?utf-8?B?ZE9NUk15MkdPc1pnaDdXZUdZL1FvcEZTYWh4RDlnN0FkQVZ2enhXM1Y3dzBn?=
 =?utf-8?B?VXFpdjVFbnBlWWFJS2tnbDFXQWFvQnBSeEJ3RUkxL2N6amJVLy9ONjlWakRs?=
 =?utf-8?B?VlBSKzNVeEhaTmRjdHEyRFR4c2VoRTFYbkJTTnpBbWt0d0ZVd1hROXJianI2?=
 =?utf-8?B?RFRlL0hxak1xYnBTZTJvMzZaVUExN2svTzFULzlqUmxoeXRVUnQwVWhDeGNy?=
 =?utf-8?B?QmpWeE9LeDQzc253V0Qya2V2YW1GRHJ1S0djVy9qcHJZbUp4YitlVjVKQTBN?=
 =?utf-8?B?OVpJRnNMRnlRL3liSHpxU0VJRFNtRTBkek04Z1RPRDFSeWpnZnkrUE9kcWVx?=
 =?utf-8?B?ay9GYTE3OTdrVjVBdld3WUpYSGR4cmxIbE9PbXlCZlhBSjh6dS94VkM1NFJn?=
 =?utf-8?B?Vm56U3kzYWNTWjF1T1V5U0dLaThZSDZ2ZElJSjdGclMycXhNY2JLMnFKRDZM?=
 =?utf-8?B?L0FjZHpzdnBpNlNQa3pIeWpZc2hKTVA3em0rWjNEN2ZKcVJ0RWNRajcvaFNu?=
 =?utf-8?B?WWJjd3ZqQVJPMHd6R09KMTdJMWlrejZjWkh3bjFkSFhRdGQ0eUo5TS9GczBZ?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 224ea281-1e38-4911-c928-08ddc553e782
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 17:03:52.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29b9SSMAwl/N9aYjstpGkFMTm++M7KKYTek2U9V3EnLUeGS87CKq36PGcVrcASvPHcwJ6NS9r9KYxo5EyCX9sc9m9kT8FUhaA8sDV4h72Xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8531
X-OriginatorOrg: intel.com

--------------vfeSAzf3ts5NFeXSaJVrImb5
Content-Type: multipart/mixed; boundary="------------HDXzVHx3L4v3frZprpXx48TI";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Wang Haoran <haoranwangsec@gmail.com>, Simon Horman <horms@kernel.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <489c52d1-cad2-473d-86ab-cdae51b043c7@intel.com>
Subject: Re: We found a bug in i40e_debugfs.c for the latest linux
References: <CANZ3JQRRiOdtfQJoP9QM=6LS1Jto8PGBGw6y7-TL=BcnzHQn1Q@mail.gmail.com>
 <20250714181032.GS721198@horms.kernel.org>
 <db65ea9a-7e23-48b9-a05a-cdd98c084598@intel.com>
 <20250716083731.GI721198@horms.kernel.org>
 <CANZ3JQRwO=4u24Y17cP3byP8mS9VOP5g=sy_Ch_g0xKSDJLhKA@mail.gmail.com>
In-Reply-To: <CANZ3JQRwO=4u24Y17cP3byP8mS9VOP5g=sy_Ch_g0xKSDJLhKA@mail.gmail.com>

--------------HDXzVHx3L4v3frZprpXx48TI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/16/2025 5:52 AM, Wang Haoran wrote:
> Thanks for the clarification regarding i40e_dbg_command_buf.
>=20
> Please let me know if you'd like me to submit a patch to
> remove this interface, or to replace snprintf() with scnprintf().
>=20
>=20
Since this is a debugfs interface, I think we're safe to drop the read
accesses entirely, without fear of backwards compatibility violations. I
think I can handle making a patch for that, but I'm happy to accept a
patch from you if you want.

It looks like there is some complication as the
i40e_dbg_netdev_ops_write() does appear to use this buffer for scratch
space. I think that would need cleanup to align with how the
i40e_dbg_command_write() function works with an allocated buffer rather
than using this static space in the driver.

Thanks,
Jake


--------------HDXzVHx3L4v3frZprpXx48TI--

--------------vfeSAzf3ts5NFeXSaJVrImb5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaHks9QUDAAAAAAAKCRBqll0+bw8o6LXC
AQCa4prXVkLzCzHmTXa123H8F15VhhOOK9PlWGRPqcjnRAD/bJGJbNy4Ai0X4LJWhpm96W6I69Ct
4lxxA4UPkHpofwQ=
=yp+3
-----END PGP SIGNATURE-----

--------------vfeSAzf3ts5NFeXSaJVrImb5--

