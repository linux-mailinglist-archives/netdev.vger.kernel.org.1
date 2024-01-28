Return-Path: <netdev+bounces-66447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 097E083F485
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 08:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65751283EC0
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 07:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F2E8BE0;
	Sun, 28 Jan 2024 07:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbNzb0fZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48280C129
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706427191; cv=fail; b=HkWc+2QUTVKlm4Nw6pxbAZchy6Mcy0hLXkd3WhbrVl3R2hBrpXMA7rL9mLoVeeN4Dfux1O9KxBr4mRYnXZ5Gd+ulDZs8glrlGbCVR8v4yvr2LvZDgj6pR/t9eusVEY0yHF/D59svY4pfCTMBkpYaXqAXWjjyWgF+wS5X01SrJdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706427191; c=relaxed/simple;
	bh=gulMwUzLSUtxf2MSx0a+vAJS214wBiQNC+6VanMfbG0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K6xmXA/5oqJOtfZyBLF3PqwHjG3aVTgoM2I5sNP7QrNAnHFozakhBJvFlz/+q4a+FhtnroXMYjCWPJL+e2cuPaslAG1YvI3voO1z/J3pTFamteOOe5TI9Tut/yG0y2Fnm2/DtaIGusY4ZtBObyjzcUUK3sT677vtDCAGEK8pzWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbNzb0fZ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706427189; x=1737963189;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gulMwUzLSUtxf2MSx0a+vAJS214wBiQNC+6VanMfbG0=;
  b=IbNzb0fZ+a9Z4r/3U6cJGrqKFT2WSIT+PuKKMXGlMuQWYCwWzYSOa8Hk
   LmoeQ4RL3cA8W8JsNfrU3Iwdcz8sah0Tv9mWr3mqfFNK0KqAc9F0F1YHs
   AusMuDFaIQuoou6JMbHNerthvfdurvX+2K74jRXbGp7VybSAt9mPHHYwv
   teE/hGIVhj0ftq3erxSWzA/I/VZZ41F5A9YRy3si7JiNalCNqVTWwD+LR
   aay0mYLGPw5UG5tOoer0irJ/yDYQSftWQRtD1lPENXlRwE99cH73lwaoq
   0KuLA2bSnjYIAwb02ftUvyNhkZGqiQBrfiut86bJUONJ81A2+8h275N1u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="16274916"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="16274916"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 23:33:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="877775835"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="877775835"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2024 23:33:08 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Jan 2024 23:33:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Jan 2024 23:33:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 27 Jan 2024 23:33:07 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 27 Jan 2024 23:33:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzhQDWBzoKf2jRiHhSHZMBHFZGxjPVgQ0LiGOGT1UaQ6fCgbd2k9/IHv5bEU/Z1NTQUs/T1r1rH8oVsqKrButQ1L62jIIGFwuTNWMzy2SW2g9Sftpuc15p9k6gUiZSLV3IrTf7sFX7XYl7Rj+g7b4gpzba80shaIl9OERwWpNUVSG1y3BcOb8wmG/Vi9LFV9OfBz1h4KobQwjjIxhpsXyxbSLDTjMzqQAFiy54J2eAY9fWBoSbgHQo9InWxBuX+o/9gWYxe1flw6wARljRI++KmQuFXCnCB6fuOJywuOLHSSo5dkR3/SNjauLlF5bWc8w+WjPilFUVxX8Gopw/D/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7TB8J/2erQAQ5yEQ8Jr/usk+TTZkcPTi4HWNPsXcLQ=;
 b=AyqrcbldoWAMxWJ3qjzxe745HhDPoy51/og69c78e1F1akuarN3xif4b9vzyfRREAMg1iXA7i5INBjMdtKltxkAoKm+jwQkcu6IX257HuDpDjGVP+6ys5FDon13KaAilPKfZ9C0TSIPG9aaZ35Vsevxa5daUR1CDNxE3JhVd4N/19NYZDb8k+eWo1+Y3Flaj4QDCblU8tv4w+FODdq2n+3GnYu2MHeY/lp08zxIdCVJSBPUTyW4ZEj9GMtZkCwGWERXs9FN8TFnro/RqNOBr0DAQRRP9wOxFtmjM6vswh5B7SgRkw8yYVrZ8EZntC7uLB1fnUWfHyt6UYJwdY+Qlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13)
 by SJ1PR11MB6249.namprd11.prod.outlook.com (2603:10b6:a03:45a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Sun, 28 Jan
 2024 07:33:00 +0000
Received: from MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::5e2f:2e89:8708:a92d]) by MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::5e2f:2e89:8708:a92d%4]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 07:33:00 +0000
Message-ID: <8d3340c4-81f8-4617-849e-e1fba96d0a19@intel.com>
Date: Sun, 28 Jan 2024 09:32:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] I225-V (rev 03) LOM + Linux kernel 6.7.0 power
 save issues
To: S. <strykar@hotmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Ruinskiy, Dima" <dima.ruinskiy@intel.com>, "Lifshits, Vitaly"
	<vitaly.lifshits@intel.com>
References: <MW4PR17MB42749868DA9C32BBDA50F4F4BB792@MW4PR17MB4274.namprd17.prod.outlook.com>
Content-Language: en-US
From: Sasha Neftin <sasha.neftin@intel.com>
In-Reply-To: <MW4PR17MB42749868DA9C32BBDA50F4F4BB792@MW4PR17MB4274.namprd17.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::7) To MW4PR11MB6738.namprd11.prod.outlook.com
 (2603:10b6:303:20c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6738:EE_|SJ1PR11MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: b1762816-589a-4379-0bc7-08dc1fd35abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYGr6zCSP5IrYRc7TIUe+/yTM+zk5IcW37C6Fb673DKrq8M9mga/Fp5ehVmAEHVVmirngbULXouvNNZld1HEFxON9GOIWhxXvBk7/Xhq+zDkNVPAQP/4WxW4NVW4QdiCSPwu6+rP64AkAsZA8nd/DW2sn7Q50vJ4b5BfaFOyLSEf+/gS3D/ozn3DlSrCYrM/2qvFG1IuTxS9VSm1aARZij19FRoYqVuPs/JKafRGXsEBBb3qyxgByRpRyvYWwsAZi/1F5UOEfqgpcjk+gsAMmyu/alM0Gn/YnrIndxMUFMLBEBDJ+skzdSB9ktArK1yG7jKT9qoKx5x0CeOzN3o5DKJBhc0tOyUuT+8qiGONvNEjZ0Q/ZwEH6QvGxhc6lyLoKSGQedeJeJbcV496DVynO8CuumFKsHZHtG4Lsmb5/2kaKJO5YRbdbPJbiyVL9iTicFjTF8WkqFIrd66Fo/L3JqV+A7UPiikwWMIpBN1yo2LxELmduSbInW+YI5SSrt/dmjWzjB0Tdzl9Dy9EWkTxdswaN3o44mAYf+5elhJYi8qEFVtzkBmgkKt3+BFMRfY+7B3Hiip2lf3ukG2a4I5UxZURRCVIeciw5UNYQ23xbDhxLlMcjcvd1e+s9seEuyjFwnV9dvBiJBkO9RmSe108yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6738.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(83380400001)(107886003)(36756003)(53546011)(31696002)(86362001)(82960400001)(44832011)(4326008)(8676002)(8936002)(5660300002)(2616005)(26005)(38100700002)(316002)(66476007)(66946007)(110136005)(2906002)(6512007)(41300700001)(54906003)(6666004)(66556008)(478600001)(6486002)(966005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGdrMi82NDNtK3pEMm5LWDlaUTJPNVBoQmhXTVl6TXJEbitaaGw2bmNROWtC?=
 =?utf-8?B?ZWY5bHV4Kzl5VENsdG9pQm5NbVdLRkJ2MVBoZnJqWDVjNnJOSEQwTkJiZ2hJ?=
 =?utf-8?B?Sm9Sby9kWVRDUWoxdW5ZbTFab2hOcUdzbjZSVUVrUmlrQVVsdnFkbDA5VTJH?=
 =?utf-8?B?aGFKR0ljWkpBb1VON1Y3RFZzUUI1TDZDeGsvZlA1MGNCUkZtbUZZWmxWTjU4?=
 =?utf-8?B?ejM5emllSzRPcVJOTzZ6TUNQaElHcTlhZEpoUWkvQVk4MGIxV1BvdDU0SjVs?=
 =?utf-8?B?bEdlV1lSeDdVcG5OOU5ZczdzUWZFSXRGR21EUnVxcVg3d2x6SDRsT1lwckVw?=
 =?utf-8?B?VVhFUURlN3JEbkQ5Zks5cUdMRkR6TkxEL0VVZGtPRE1MT0tpSGVNejQ4MUpq?=
 =?utf-8?B?Yk1lWXB3bFYxVkJEVGUwZ0xRYm9KeWhqODdLTEUwbXVicnlYTldTaG0rTjBH?=
 =?utf-8?B?YWhUL1RIM1ZBKzM3bjBlSGZPblZUMXZRSGlSRnVKazgwMEN2V1c1ME4xekVq?=
 =?utf-8?B?NC96SkdJQWEwdy9vOVZmaytEdUMzaWZLWlgvY0w2NlhUKytyeG10Mk5XV1Zy?=
 =?utf-8?B?NVI5VkFSVXlnRHRuNVdjMnVQYWo4cTIxRHkzWHlRSFhrMnJEbERaTHZhQUow?=
 =?utf-8?B?YzZyWitNcVhvaVZpbFdqSlBkWVZIdUFDUzJXZ1g3SkVCRSt3Y0NYemh6QTZa?=
 =?utf-8?B?S2dMVFR6NjhsUmdTdmExeTMzalp4Y1FjMVVJWC9VMVllYlJ3Qm9lTWxwVmdr?=
 =?utf-8?B?MXN6WVhXQmxXOWZzbHNhdVpyMFNtTVU5R2tKZDBRaXRtUStjejF1TU5wM0ZL?=
 =?utf-8?B?MlZHcHhheDJ3dEY1d0pXc0UxUDBoZEpxZE5ISzVBNWp2emFkdi85ajVVYUYr?=
 =?utf-8?B?WG5LTFlpd3lkc2dqdEZGb3oxUjVCUktEakk3c3VycHh6VXprVGwwUDlpOU90?=
 =?utf-8?B?TkdzUGRObGlwbzh6TXU2QzNaZmtqYm92WWU1ZEtwNHNUL01TQitnc01Ud2JG?=
 =?utf-8?B?cGxTR284czBRTkxkYmN6NnBtNmozYWFtRkVIMERCd0JEdnlqOTl0WlBSVjZ0?=
 =?utf-8?B?NHZ2cVhNck9yU2ZtREVseFliU25JcVp3aVl0UWhLTFAxbE5kREFoeDJGSFIr?=
 =?utf-8?B?Y005M0d0a08rTDRUV0YwWmlVRVFJb05PSjVLQlUrZnIvYlV0TGxkVldWU3Z1?=
 =?utf-8?B?RnRFdmlFUnBPZXVoN29ncldUQ0ZTbmJTempzaVhBTklUcFZReWx6ZmRlV2RP?=
 =?utf-8?B?Nko2MDFTMlVrMkpjcm4wN1daNHg0aldxcVFEbnFpbmFXSGlONzZ6YUI1ZUxv?=
 =?utf-8?B?UjBjYmRRTkVTTTZKVHIzWlgwL2ZaRFBKMEZrcG83UzZDUk1KTkoyZGFCU3hI?=
 =?utf-8?B?bGN6eGdIaGNOcVM1d2N4enMzdWJMMm84MXhRdUlLQXZzc1B6Q2svdHZsU0FP?=
 =?utf-8?B?aCtoVFRpWFVRcHBERWxFdUgxWXQwMFRMRGlGVC9HeStmUEFSQklGYW52Zmdh?=
 =?utf-8?B?eitvcDZQTTl4Z2pjdC9BbERzbXBQdHIrbGpwOEhJWTQxaTUzR3VBZTEweEF5?=
 =?utf-8?B?aGNKcmNrTndGSWxOZVRrZW9LamVLWHArdFEwWUY3VXdOQThNZ3JYMjNLd1ZE?=
 =?utf-8?B?cHF3NEYyM25XZER4V2xESnNTVk40eWhCTGF0NmdmWTBMNTJUSUV2ZmUxSlJI?=
 =?utf-8?B?bGNOZFR0MHJOdmRkOXBwYUpjU09jV1BYK2Z6Q2V2SnQrUUNkZ3ZWSXNodXZ3?=
 =?utf-8?B?MWhyVU1FT1NCYWJPVXRSVFRvek1HcnhNL3NlY1pxVExuUFRVWlFsYm9yNDNn?=
 =?utf-8?B?b1hYZE9EQ2JZWEV6cGs2Z0ZTMzFicDFCeERMTjA4WDNBN2IwVDlHZm9CQVdx?=
 =?utf-8?B?NEVLc2RWQUFCZ05za0ZON0srWEJiemU3UENRZlpCZHh4S1FtbE80bE4zUytJ?=
 =?utf-8?B?eUhMSXB0aGNFR25uUnUzTmkxQlp3aVgrN2R0VXlQMjNxS044Y1Z6UmUxdHdH?=
 =?utf-8?B?eEY1eGZseEJCaVpta281VFo1bitLUUxZclhXekxZVWVoWTZYMjlTMTV0NVFR?=
 =?utf-8?B?TUt0S2xYNGtaTHBBdEdPUCtIZ1JFZTBEZnI5ZDczU0ZHVkx4NkdBZytlcW83?=
 =?utf-8?B?YlRSbmNzaFc5V1lYNkdtTmM5dis0ZHZGSnRiNkYyWjVXMUpGcGVwMkExeVhW?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1762816-589a-4379-0bc7-08dc1fd35abf
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6738.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 07:33:00.3354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kHkIhmKSlndUTGfwnW3nD9zRAtlo4phDBEWnd3Gb5YkUAgfjicOPKVhi8x4L4Tt23PDxX4+cqicNYZ6a0cPQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6249
X-OriginatorOrg: intel.com

On 26/01/2024 13:37, S. wrote:
> Hi,
> 
> This was tested on a recently assembled Asus X670E-E ROG Gaming Wifi 
> motherboard running a standard Arch linux install - "Linux r912 
> 6.7.0-arch3-1 #1 SMP PREEMPT_DYNAMIC Sat, 13 Jan 2024 14:37:14 +0000 
> x86_64 GNU/Linux."
> 
> The NIC will only connect at 100 Mbit, forcing 1000 logs "igc 
> 0000:0a:00.0 eno1: Force mode currently not supported".

1000M works only with auto-negotiation. (but it is not related)

> 
> When Gnome / kernel attempt to power save to standby, it logs "igc: 
> Failed to read reg 0xc030!" and proceeds to hang the machine for about 5 
> minutes, post which it resets back to GDM login.
> After discussing the symptoms on IRC, it was suggested to drop an email 
> to the igc driver maintainer.
> 
> Some notes and logs at - 
> https://gist.github.com/Strykar/c78c292ca0a8ef942af846a1272a044e
> The issue persists even on kernel 6.7.1

 From the log I can see that PCIe link loss - this maybe come from 
HW/platform or BIOS settings. As a first step, I suggest contacting the 
vendor (ASUS).

> 
> Is this a known issue?
> 
> Best,
> Avi


