Return-Path: <netdev+bounces-216458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B740EB33B93
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 11:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342D01B25A11
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 09:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1668E2D12F5;
	Mon, 25 Aug 2025 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1b+taTs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48D2D12E7
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115313; cv=fail; b=VOMLj/MDqVekMJSdTiv9PKmR2qhi7DlM7XMhT5a84nGEw/oBp4oQrhBrIGOTsec58Z7hrQwbzPxaAUekQsB2ogduGaG0xl+wmh2Y0JGh+qR2fX9hc6SDUzeNZfKbr0r4eIzadtnnqX/TCGtz1FiYwgFLjDkCE7gOnhlz39Kgy+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115313; c=relaxed/simple;
	bh=V3G6UpAfDUJD2wveu3IYO9QRRwOXLYhkh5tyh/j4KYk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XUgmwYSOsPX0ME94AtV2F/udrm+vbdM7vywysxfPMry3DtpoGL4WfRi8pTynCJJpZyhtPbtHu4EMhJ9XdjxhXxt2XtlGDkJN31xHuL87h94t+z7QLRTLcpgFbVCVwbgFW9QwdcH0RASgbCaWaW7JFKwfLe7+kO/XCG1tkUUCs+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1b+taTs; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756115311; x=1787651311;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V3G6UpAfDUJD2wveu3IYO9QRRwOXLYhkh5tyh/j4KYk=;
  b=W1b+taTsITSTESZrP0t67XIKSdSOlO5FKnqUoLkfbB582HZdfmth/jUN
   93yBlK/PWA4MG8/xSfQhhqT1cjKDIsXWYhkXfF/16KCntK+nfg/jhsa5S
   Hy/8GYVyceeEWLVLnrGqdVQRyFn7nCbObwGt0sXrt8DU/4xN7VRzj8v7j
   YUIIOGiCuZUlBlVMdHqli5MjSF9u9dpAViBO4WQW+8Sp6ddikIf56ztMP
   UA8luEJx48UO19AuQJJFVCz3VTBzrYyHV98cVyiDUv6C0vMjYNoGv2l9q
   E/16PvjZQ3lP9eFdaPhLvWjcw9p3EcwWLSSyk6Xy4ArdAtOXvki8KUGHP
   g==;
X-CSE-ConnectionGUID: 9G2hYeYjTMin3C1+WlEA7g==
X-CSE-MsgGUID: 8+jECKZBRjeLuOWNz9u7OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="69695573"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="69695573"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 02:48:30 -0700
X-CSE-ConnectionGUID: gcFnX6BqRKu45D2/aBNfMg==
X-CSE-MsgGUID: H55qpelwTWWusL3q0xx7iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="200194892"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 02:48:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 02:48:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 02:48:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 02:48:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1hW6EwgNHzp7wavtE9xh8E2zR2GdEwgSPPwp/Jc/UhLyI4I7/9RBnY0WataEGkWC3uaa1SO1Oc28cv5GWX+H1sIENlbJr7ujg1cQJ+b64z/xDQ2UytkqyYpIlsSRymArIUfuwipYWy6snd3ojCgPVHu0ZDW80PJB3tpH+GhnoAXBBrtDuphD+B70Km7zVKPmNXtKzTfNwHFGqfHPj7mRzdbIBe81shOAceufHUw9VkES/bNmFzGl4rafEIJ2+rWd9TYUAxja9ArOI1nMAZXcyBb35jDFPaqE0nRjBQ5gTrojqTVUmAe5tvpW7kYksaIaAcfCzEePPpOS6ALfK2Sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCuep8obNB2DWQXt28Mivt4+NNa+7eH1uJSdQAwQoWo=;
 b=D7wzouj4xdxhrUZaCvbj7fDtakqjT/y6BsCaQnR7+SOH9LPf3pRTUBx6IIzjnLFr8r61Ya8GqUjb21E4FhSiBejRWiF3hHkDweok7wI+Rs7g1gtumrbsV8c1fe07bm+68QjSRdB/tJ6dTr5qPPDEgvoYm3zYK3yZkQGSkRVlHBXd9dFfxOh8VF+abatNL4Gqu0obDYbaQZ9KoiBI5QGxUrLOp5YlY/3u29TRg/Dmc2ACydwIs8oYZHjV8kPEbXY2Myxn5NrS3K4dB2Q2mWBtkMU1aRX+D1yqxdVrqhdF+1NxO0X10BVu9rXXRpAi//heJW+Ker3LDY8w9EcnTjvdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ0PR11MB5939.namprd11.prod.outlook.com (2603:10b6:a03:42e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 09:48:26 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 09:48:26 +0000
Message-ID: <781791cb-b22f-4197-a4e6-ff11a6fba8d9@intel.com>
Date: Mon, 25 Aug 2025 11:48:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v1] ixgbe: preserve RSS indirection table across
 admin down/up
To: Kohei Enju <enjuk@amazon.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <kohei.enju@gmail.com>
References: <20250824112037.32692-1-enjuk@amazon.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250824112037.32692-1-enjuk@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P251CA0019.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::10) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ0PR11MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d8cc54-55ed-4f97-acce-08dde3bc8a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDlIRTRIeGxvNXR5UW45WHNtUmh2UFBvREM5NFYvOW50cXdVcmZ4NWhCanhu?=
 =?utf-8?B?bTBNd05jNnVEUUZKSVBVSHAwK3F5b2JMQXNpUnRZdjkycmY4TUJqVXVHVVZJ?=
 =?utf-8?B?ODREQ253MlZzWTV5RWR5U3REajJBcU4vMExLcEdBMUtEY0lxbTF6TGhHbW1X?=
 =?utf-8?B?NTNYdU1BUzcrQThMZEFVZFl1TjBWb2ozc3Q4dDlQdFpxM1J2M28vMDd2aFJS?=
 =?utf-8?B?UGtlTXNFWDVwclJzODljNHJXTTA2dnV3ZXMwZE5ic2F5SXBDTHc5V0NtRXYz?=
 =?utf-8?B?c1hSdUM1dWhHWVEwek5EeWl4aDFUVDJ0bXg4MGhUb2l2YXpwNEE1amtrb0Js?=
 =?utf-8?B?UmJQZ1FtVFhnekthNFpoSWJ1emlXZFR5MnBaejNWbUs1WDNOcFU0amR4eUxE?=
 =?utf-8?B?cEZxNEdlY1JXNEwwbTUweHh4c1VrRVZ4cDJkWUZrSnJKTFM4cU1aL3dyWnNh?=
 =?utf-8?B?RmQzd014bkpkeGhveTRnZkJjQkNab3d1YUZjWi9TSmVqVXBZUEN3djFRSC8v?=
 =?utf-8?B?WlVVd05OaUxoSVNNb3IvdUpsZmRyd2lnTGFEZjdBVjdrTGxXSlUxMnVucWl3?=
 =?utf-8?B?aVl4WXpZRjNuU1cxM0RtYlk0RkVXckJ4R2dzSGhqajN5S3BER1A2NldxazJG?=
 =?utf-8?B?ZmFUTkhEblRsMnV1NW11bXg2d3pXN2JQeDJsWUVGTVJpSXZKcXJRS0lSaVFK?=
 =?utf-8?B?NXA0MzZqVWJNYW42VFlPY3JOQXhveWRja2tzd3FEb3ZQMnJya3hTcS9ld0xz?=
 =?utf-8?B?dHlsUmNnRUlnVmxwV2xKRG9mV1JtZllrTFZFT3hhLzltckxiYVg5ejdhcUIx?=
 =?utf-8?B?eEhBcEFLZmpRZzBzZ2FjOWhmcklHWFloSTVmOXhNSkZrQ3RUSFFjc2RKYTND?=
 =?utf-8?B?V2xIWUZocHNKTnlEeVIyUkZ0M0RTU25EbS9SSWVMY2lBTlI5QVRhSmxqLzFZ?=
 =?utf-8?B?SURaQWpzajIxZDFjZzAwbFZSbHVNTmt1MVdaZUoxTlhudWFVWTlmcWJPR3lI?=
 =?utf-8?B?bDUxdmU3b1BiNGxjRjB4aW5aZUNlMGpLbFdySDNlSmVnT2R2NXdXVE9YZUdt?=
 =?utf-8?B?Tldua1dKRGtlelBvRWwwSGh4NUJ5eEVLUDJtWld5VVRCMHpxYyt4djU1ZnBo?=
 =?utf-8?B?emVPVnhHT2Q3T00vT3VHeEpPbHMxbHhpK2lTSDUzQ0hNd3VDU3k4R2RHYk52?=
 =?utf-8?B?amt1THVienUramd5VVZsbkZFWkZRM1dTR2czeVV2b1RHaHlXLzFxY3laNXJK?=
 =?utf-8?B?eFo1emY1cjk3TWJyYmlHSkxEVmxFVWdzOGtSN2lzeXJ2aFZZV0RpMnhqN2FG?=
 =?utf-8?B?aWxaMGh3MDhEN2haS01GQ3ZiSGdCQ28zTlFNa01PbnVXdzl0OTZlakF6b1A4?=
 =?utf-8?B?bk1mK0lTVGFTSHVUUVc1OTZjQURyVVU3dzJnWkZGSi8zQ01pKzNXR1pySnRz?=
 =?utf-8?B?Y2lFbnlZMnFObUpNVGUyd2xRdTkyanBFN3JteVdtelMwZVN4Umk2RThjQU9l?=
 =?utf-8?B?ZEFnaXNmazk4MGRSNmVZdk5HeTl6eHpOZG9zWWRtOWN3ZnFjK3FsWFNIRC9H?=
 =?utf-8?B?MSszOXFPY2tPSzBOR3ZYekxxWkc3YkFmYkY5UTdvZkJPbjNKWDNqWEdmbVFp?=
 =?utf-8?B?TnZBUlUrZnRqQVJyeFZPQUJhN2tEUE05eHRrQk5wSmFvQ29veVJEbWdmd2hK?=
 =?utf-8?B?dHRvOCtYN2hkWWNQYVR0YlVEWUd5cGNHNDJRcWVvNDkyV2JDQ0Z4c1I5cHVB?=
 =?utf-8?B?WkdWQkJ5eEovdHd1UUhDV1ErNEhvandKWDVtQXpVQ2FpQlhla3JJSFFlUDRk?=
 =?utf-8?B?TVpnNlJ3eUNHL1hZS2d0Zkx2M2VtODRTMWhsdEZZbkg2eitKdkhEMEJ5N2R3?=
 =?utf-8?B?dndwczVNaFJ5MjBYT0lZeEUzZ3pXRnRjbUMzaVdSZjRtcWxEK3UyY1l5OUFO?=
 =?utf-8?Q?Z9syXjafoEk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWRMYU92VVlGNi9nTmRjYmRPWjJ6K3k2VEkwMzRPV1lPZnFhRHY1U0c1VkxS?=
 =?utf-8?B?cThzYS81MlVHVHFUR3lXMEJsdWJkMEVmY1VPcHR0YnhhWGtBazA3VXhHWkEv?=
 =?utf-8?B?amJGWk85Mi9oZFcyNXQ3UmMxdkpQWDNJY0ZUYU8vQkdHaks2akY3MjVlRXFj?=
 =?utf-8?B?SVJJUFMzZWNQSjVIU0NSWTc1ZjFzR0d1UUF4L0hsdGJEOEMzZmk1S0R1bkdh?=
 =?utf-8?B?OVpzTm45T0NnZWhkNDhJQ0Nxalc5clJBSC9mUE11ZnVmTVZMRStYMmxxL3A1?=
 =?utf-8?B?ZmYrNEp0Nm92QjNQM2RxRlhXU2E0SUVIZDRJbEpXUjI5RC90bDVEL0dXMUQv?=
 =?utf-8?B?aDN4NnJIampmcnZUcGFweEY0R2dMZkpEanlhRDBOQXNHbGd0UytnSWZIeVU5?=
 =?utf-8?B?Q0hndkprVWg2Ujhxd0ozNGY1bFhuMVR0QUJBOFNVTkR0bm9JblkzM0JmZjNH?=
 =?utf-8?B?UFV3T2lhOVFCaDNBMTd6T2FMRkNHVkViSkpVUnR2b2ZhRG9MSmkyZzBYWW52?=
 =?utf-8?B?K2xsSmpoNzd5Vnc5T1lpZEp2WjJLc05kSFkwSVlITHlNRENSRXNQMlhyUGF6?=
 =?utf-8?B?WjZWeEJ2NklIQmxtVSttNWphQ0xYNWdMWk5KaGlpQjZjbWdwckNNZWMyWStG?=
 =?utf-8?B?TENob3pBamlRVXZBT1FGeGVnUlNuUEJxSVJER0g4MXhwaGFnUzV1N281cmQ5?=
 =?utf-8?B?ekNHRzNQYnU5dHRZOW0yVmxKYlczS2ZpMmFTT2ZXbkczdlgwT0ltZkxJSnFE?=
 =?utf-8?B?ZFdLT1FFaGNVZHVRR2pWVWFRM3pSZlluNDQycGNlaVcybUxZbVZzWGozaHNQ?=
 =?utf-8?B?RjVNU1BOUXcyaTRNd1NOa1RLWnhOZGxjTlpsM2FzT3UwRUtjUzBqR1pBTExs?=
 =?utf-8?B?K3ZBUlYzdzNNb0cwcUI3V0ZFa0ZaeW5DREcrdndHbUVpSDg4cjFsQlpPRk9J?=
 =?utf-8?B?R3NCT2kzbkxrTytraVAzSlRPWFc0YmdPc1BlZTA1UEs4d25PTkkxUDdZWHFl?=
 =?utf-8?B?T1ZEOXhFL25JdzFXa3JaRlF6cldXTVBYeUp4K3BTMkRTU2c0MEN6OUpkUE9V?=
 =?utf-8?B?Ujcwc0h5RFZ4U1RkNzUxZDhYbUtBdTNMeTJJcTh3RjgySjJ0WWl0dURFNU9p?=
 =?utf-8?B?VVBSWklWWHVnTGVRRnpObkplNk0zWHZTWjRnUWYxeTJhUmJGMmVSQ1lsQnBQ?=
 =?utf-8?B?V3RHU2ZNN0s2QVpDT3RpNmdsS29XWWZtOUdXQ0hsdW5KckJ3U1dieVhBcXBw?=
 =?utf-8?B?aDNUVUlPejM4REVRb1RWeHdSWGQxWWZGVjM3L0xuUUNQRE9sZGRVRTFpK2Iy?=
 =?utf-8?B?cTFNWXhnRjFRQnFYdlQxNlYzazFiQ1hkc3pvL3RDZi84UDIzY3htcEZrVW1i?=
 =?utf-8?B?clUvVStueHB6RE5FY2VIa0hYb012OHdrN1lqL3VyajJyNzdCRmdmWVZMeGlh?=
 =?utf-8?B?Z1AyZ3FRSjcwREU5V25iNHhjNGgyK2dvd3dFakRrcllmektHelU5dUJ3UWZ0?=
 =?utf-8?B?aWFNa1YyeVpSaXFkUzZ0MG81eHRxWFNoZDluNWZzUytJTWNPYXJ2S1lnYjJL?=
 =?utf-8?B?b204K29EdXFpTHF6SktPK0Y5Vlh4c0NqL29oWFREUXdOMCs4TEk5a2ZHb3RX?=
 =?utf-8?B?T2drZXF1N3BTVEFQNzVWK2dBYnpxa0d3NjRjazJBd1ZvRURxalNBQm9ycDM3?=
 =?utf-8?B?a0g4MHZIbXU2eExrWHgyTjY2cnBZY0ZUMnIxMVVMS3ZvcjBZTUZScHU1Y1ps?=
 =?utf-8?B?L2tLM3VSWHk2L2tabmRHM0FmV2dPaDY1ZkQ2TE1sK3NvcERWaitGY0pHWHNZ?=
 =?utf-8?B?d0dQYzkxUDVYWnF2eWNQeHVaenRoclY0SG83alhLc1J0MnlwRGhTeEs3QmI4?=
 =?utf-8?B?Mm4zc1hBMEl5b1hMblAvYTBKQjhrekhGTm1qV0NEc0dxY1owS2svMENreGN2?=
 =?utf-8?B?ZkRyc3pGM1I2TWRjbzc0RzlEM3FwcFhZSVRxY1VMa3VBb3BnZ01kNk9Sbk9q?=
 =?utf-8?B?ZllzOWxQWXhHY2NaUVA3TFlJZ2dYWGJyYkdRdUlOZ0Yrc1h0aDNOWGx2Sktt?=
 =?utf-8?B?MjdJd0JCVUxtUGhkMzBkVjh6SDQybzVkUE1HUkpvVFlSc2l1L1VSUnFKM2hw?=
 =?utf-8?B?NDdJeWkxM1MyVnlWY3kyQ2had2tXUVZkcG9McDhsN1lSU0FiRGs5bVBRVzNZ?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d8cc54-55ed-4f97-acce-08dde3bc8a01
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 09:48:26.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJDpKIW0jaxm0dgWE7PWo62s57l3JgXeE0neCsiAnLzVlPyRePfygd1XV6WRzitZBoOth2bwhrxMe7WcUb4Pp9ts/5gJ2g/lcZFPAzznQKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5939
X-OriginatorOrg: intel.com

On 8/24/25 13:20, Kohei Enju wrote:
> Currently, the RSS indirection table configured by user via ethtool is
> reinitialized to default values during interface resets (e.g., admin
> down/up, MTU change). As for RSS hash key, commit 3dfbfc7ebb95 ("ixgbe:
> Check for RSS key before setting value") made it persistent across
> interface resets.
> 
> By adopting the same approach used in igc and igb drivers which
> reinitializes the RSS indirection table only when the queue count
> changes, let's make user configuration persistent as long as queue count
> remains unchanged.
> 
> Tested on Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network
> Connection.
> 
> Test:
> Set custom indirection table and check the value after interface down/up
> 
>    # ethtool --set-rxfh-indir ens5 equal 2
>    # ethtool --show-rxfh-indir ens5 | head -5
> 
>    RX flow hash indirection table for ens5 with 12 RX ring(s):
>        0:      0     1     0     1     0     1     0     1
>        8:      0     1     0     1     0     1     0     1
>       16:      0     1     0     1     0     1     0     1
>    # ip link set dev ens5 down && ip link set dev ens5 up
> 
> Without patch:
>    # ethtool --show-rxfh-indir ens5 | head -5
> 
>    RX flow hash indirection table for ens5 with 12 RX ring(s):
>        0:      0     1     2     3     4     5     6     7
>        8:      8     9    10    11     0     1     2     3
>       16:      4     5     6     7     8     9    10    11
> 
> With patch:
>    # ethtool --show-rxfh-indir ens5 | head -5
> 
>    RX flow hash indirection table for ens5 with 12 RX ring(s):
>        0:      0     1     0     1     0     1     0     1
>        8:      0     1     0     1     0     1     0     1
>       16:      0     1     0     1     0     1     0     1
> 
> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 37 +++++++++++++------
>   2 files changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index 14d275270123..d8b088c90b05 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -838,6 +838,7 @@ struct ixgbe_adapter {
>    */
>   #define IXGBE_MAX_RETA_ENTRIES 512
>   	u8 rss_indir_tbl[IXGBE_MAX_RETA_ENTRIES];
> +	u16 last_rss_i;
>   
>   #define IXGBE_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
>   	u32 *rss_key;
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 80e6a2ef1350..dc5a8373b0c3 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -4318,14 +4318,22 @@ static void ixgbe_setup_reta(struct ixgbe_adapter *adapter)
>   	/* Fill out hash function seeds */
>   	ixgbe_store_key(adapter);
>   
> -	/* Fill out redirection table */
> -	memset(adapter->rss_indir_tbl, 0, sizeof(adapter->rss_indir_tbl));
> +	/* Update redirection table in memory on first init or queue count
> +	 * change, otherwise preserve user configurations. Then always
> +	 * write to hardware.
> +	 */
> +	if (adapter->last_rss_i != rss_i) {
> +		memset(adapter->rss_indir_tbl, 0,
> +		       sizeof(adapter->rss_indir_tbl));

Thank you for the patch,
I see no point in the memset() above, especially given 0 as a valid
entry in the table.

> +
> +		for (i = 0, j = 0; i < reta_entries; i++, j++) {
> +			if (j == rss_i)
> +				j = 0;
>   
> -	for (i = 0, j = 0; i < reta_entries; i++, j++) {
> -		if (j == rss_i)
> -			j = 0;
> +			adapter->rss_indir_tbl[i] = j;
> +		}
>   
> -		adapter->rss_indir_tbl[i] = j;
> +		adapter->last_rss_i = rss_i;
>   	}
>   
>   	ixgbe_store_reta(adapter);
> @@ -4347,12 +4355,19 @@ static void ixgbe_setup_vfreta(struct ixgbe_adapter *adapter)
>   					*(adapter->rss_key + i));
>   	}
>   
> -	/* Fill out the redirection table */
> -	for (i = 0, j = 0; i < 64; i++, j++) {
> -		if (j == rss_i)
> -			j = 0;
> +	/* Update redirection table in memory on first init or queue count
> +	 * change, otherwise preserve user configurations. Then always
> +	 * write to hardware.
> +	 */
> +	if (adapter->last_rss_i != rss_i) {
> +		for (i = 0, j = 0; i < 64; i++, j++) {
> +			if (j == rss_i)
> +				j = 0;
> +
> +			adapter->rss_indir_tbl[i] = j;
> +		}
>   
> -		adapter->rss_indir_tbl[i] = j;
> +		adapter->last_rss_i = rss_i;
>   	}
>   
>   	ixgbe_store_vfreta(adapter);


