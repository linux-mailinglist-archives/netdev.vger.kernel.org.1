Return-Path: <netdev+bounces-216901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96774B35DF9
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FAC3AEA6A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53442FAC02;
	Tue, 26 Aug 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y35zHRdJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5971749C
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208968; cv=fail; b=TmNfhJfZX+jPMsw23GMk/4vNkNyhyAjdFjT0StFqeJH06As8XOhhdyFWQINbWNZX3rqft2TCfx4+4rFtg9PbxMVf/C1LpfLpresIZYJAQRfPC8j++n/8nrHvV/U6t2EbJHO8f3hsCWI9sx/CxDVJ3AZ69M317HGEVuCfJbhEBjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208968; c=relaxed/simple;
	bh=bH9RYfb5obdx7kqPrmuoMLO5c4hFQfLOCrqiTsr+Nzs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tWJSKxSOybYDfCm/PsIDNsfbBw0ddl9fmGNfV+BXN/WJZxV3Q1zrO1kTct37PzSZSSwGqkpYUcS1PBV4sNtHZphh2RAnwJ7PEXgouTHljMxlo+BLKMPllyMXTm0ze4pxJm+hIUWGVXHV4IypfNCIHYOFUctb/3nMNCu7ey3G29A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y35zHRdJ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756208967; x=1787744967;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bH9RYfb5obdx7kqPrmuoMLO5c4hFQfLOCrqiTsr+Nzs=;
  b=Y35zHRdJkqzMm8KRDjTchKnyh/PYdzdIo5dLr9xQan78SVygZ6FiHc7w
   G01Soq5+G5kghjHhOSc0Kjhu1awDHi6jnOzXW8BAMq+8ijf/qMqN8rlDC
   NawtAz9zZwZ5+4qVByJTwQY1y0AHUl165gknIE7GKewsAYYFTsyLba1B/
   foBKb2uAHaNvo/ynZWTq+ZL8trV6ZAXMtINoOzVh2qd9MZz02IMF/Vllu
   RNiavOIudmiDvbXkCZE1+hZ6rJP8V/D7vYziIs9FwD59rIJbKmGxwICo/
   fjgIQDvxjwrOdc0aq4pvwfTn1soyvVxp9kg6qIMtteV9BV/t0NK1ua2D/
   Q==;
X-CSE-ConnectionGUID: RmOIGxV5RnOn36P1jwXrxg==
X-CSE-MsgGUID: qMOAtucBRZ6rVtJJqMl14A==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69539624"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69539624"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 04:49:26 -0700
X-CSE-ConnectionGUID: tHM/H12GRHSUphypceioTw==
X-CSE-MsgGUID: h7qj4P9AT1eVLEfPSrb5fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="206719045"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 04:49:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 04:49:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 04:49:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.52)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 04:49:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ae/vSrzQM/XAtE/Plg6o0TBWXXWdHN89PD5i6RSwZT2RqmPw1ohQZq03Jz+iVCN7rNAFsy56yHvxyOecNOFkaCccxtHaNT5bBpBYld3D8SX0NwsU+A30i8ZwMN1r9iS272aPLyxysz065mWRIU4daz6P6YVPwtIR89R2Zlx+Dr/jj4B9ZO3xbdpFDupvyPzZq9ZK5OP+XrhQpeRZCHEzBKYOeINfdoDzL5kDG8LgS+JyBmdBPLEEpmNmouug9d35EJ5qP4zdI5VUjKK+4qzJTmFvQw8GskZoMHuwp2P17gBL1AmJWeYECAuzGysOdTr9D6x6wtsQTsYVacRVkUsbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mK/Qix1Dgpyo3R/W7u9FCzzBbbhU6MF+bgWWVzVEqnA=;
 b=RNj3cYxb746lxXwVWUAdJpWbDsQucwCsu9s7WArPdLMT6Gbi61nAwda2OyAPH1t8HEUHjtsLk8AV47zB1vRbYJ+nVSEJRCt6aQ1LHVy2snjvsw1ptAZ875oMywi41ad0XHhCCKzf8zUa0Ji/yj4obXUeWpQVJPNftvn7/+jfA7OcMYrQizRzFI3sCcl+lM76SkONAqFu96H9NF/DOLc6eiWS4CXx/+5cONoK9Ck6/4IK2afg7twSftbfWTQhYD2C/JUCJ2MlzQMrqjYyrrUo6+fzAaBQmr0z4l2h1Cz1INs4A3KEThsTCNujF+VPwpU/fza5LbfMEOZI6VTssojQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW3PR11MB4699.namprd11.prod.outlook.com (2603:10b6:303:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 11:49:23 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 11:49:23 +0000
Message-ID: <c3983568-203d-4d90-838c-c87d1c6ab605@intel.com>
Date: Tue, 26 Aug 2025 13:49:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH 2/2] fbnic: Move phylink resume out of service_task
 and into open/close
To: Alexander Duyck <alexander.duyck@gmail.com>, <AlexanderDuyck@gmail.com>
CC: <kuba@kernel.org>, <kernel-team@meta.com>, <andrew+netdev@lunn.ch>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <netdev@vger.kernel.org>
References: <175616242563.1963577.7257712519613275567.stgit@ahduyck-xeon-server.home.arpa>
 <175616257316.1963577.12238158800417771119.stgit@ahduyck-xeon-server.home.arpa>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <175616257316.1963577.12238158800417771119.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW3PR11MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d853c10-2894-4fac-7f93-08dde496999f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGQyQWdURWZ5L3RrZG1VTXY4RDY4cWVXU0hUVjdvZjR6Qy8vQ2VlaVY5dVNN?=
 =?utf-8?B?ejdCQnQrQVdVbUE5MFhvY0pXczNQc2taRk83UmErUEVsekJXaUpyOFMxNHZB?=
 =?utf-8?B?UC9peERPbm1FWHBTb1FxN0pnT3ZMWGcvbkYraHEyUWN0OUwwTnAxZVdaKzBa?=
 =?utf-8?B?TjJ0NEVFQm5hQm5PWTkvY0ljbG1IeThIV2dscWpncytrc0xlci9XdWpjY2tM?=
 =?utf-8?B?MmhOWWtNZkZldVNzbHphNzFjRVhHV090Sjh6RktzN3JLWUxMUEJ3cGRTS3JH?=
 =?utf-8?B?VHBDWE5CZGdkYUtEakl1NzFCR3JoaC9zc1JobHNPSjZ6bGtnRTZJb1JWNGMy?=
 =?utf-8?B?QVBkcEhndzhOeXFiVkc0cVhxTnJKZ0JwaHN1bGNFTm4yekZSUWZVd0R1ZlFW?=
 =?utf-8?B?WlhRczBGNVh1RlY0Zi9Bc1dLaTlrMVlHMWJBYkpPSW5Ld09haENiZXVkWUFG?=
 =?utf-8?B?aHlPb3dkWXd2SXVHdm9kQW5Bb2wwOXVsWklyT1I3THNOUVpGT0xDc3VvczJx?=
 =?utf-8?B?Y3pKM0c3L1lyR21qMDRnQWx6alB0elZ6cGV5bVpBQ0YvZ2tpbWlGc2hUZmU4?=
 =?utf-8?B?RmJWZG1OT1BYNU9GOE5RYkRlNVlSNDByUTk2czVvZHI4OGR4RWxyMGtYdk5S?=
 =?utf-8?B?WDR5MzVjVjlYOFY0MDVnaVZQRDhWV2YyMDBybTBDa2ZGQWJHdEl0YUJpN29B?=
 =?utf-8?B?YlJWVFBtUHFVMDNoZTVYek1TTSt3bU1KZy80OTZ1RDJUU2cyN2xTd08vYXE2?=
 =?utf-8?B?NUlKc3VGb0RqUDdpcmZZRkhjZ2xFQjR2eU1mWFpsdm9nTjZaL2lPTE5BQkpk?=
 =?utf-8?B?VzBjN0dhV3k0OTRIZklBRGhtT2dPTFN1V2RxTHVHeXNQbFlDemkxNGEvNHVG?=
 =?utf-8?B?Uitpc2FvdzZXNUUwUyticUVSWXdiRWd2bDZvamJXUDd5YUlNblhkOWxEaHps?=
 =?utf-8?B?N0xrc21KbTNQRWtDV3NwMU45eGdGcDlsWkM5QmFoUkNFdGExMDg2aXhLVVZK?=
 =?utf-8?B?V29oaC9iOUh3V1plQVRLVkIzOWlnZHZoY0FsOS9uaU5RVUZkMVNWNmNNWUY5?=
 =?utf-8?B?TEs1dFF6TXIvRDJQYWxTWEVySXhLL2x3dzdKK3JOcTViWXdTYlVaVy9TaFo3?=
 =?utf-8?B?SFpUU0ltSlliQUNHTnVOV0dDNDVhWUF0ZFRZcGlKQ1NiajdyaXNYc2JyYTFF?=
 =?utf-8?B?R1h1WEJUcGFYV1BTdmlzSGlVM0d0QS93R0QycXg4SVYyaUYraW1lSDJYUGJH?=
 =?utf-8?B?MkdTallibEtka0ZVMmo4WGNTenJFcmZxY2E5ZFJadTlqZTM4dnpXZ1Y2SEtw?=
 =?utf-8?B?bkV1dklUdmpsSkhXSnp3M0tWOUVVQWtCYTFVbEE5ZWdLeDM3d2l0d3pNMkJT?=
 =?utf-8?B?N3hmSnNpa1luUnBzMXJoc1RUdVpINElNeUNYaURyVHA4eXBQbm9VQXp3Z0cy?=
 =?utf-8?B?b1Y0czNhaXZ1WnFqNFYvaTgxOUo4LzhTdFBFN21yTTZjM3Nta0RodXBjdHAz?=
 =?utf-8?B?ZTFOeGtMSnRmWEtpSjdTaU9YTFIrcUVubiszcm5hZDI2MGswSWt0Vm9hNElG?=
 =?utf-8?B?cUFPSWNwbnl5VkpRRnQyOWlnNlJMZnNHOGhuTHVKbnZKK0NtWUhiUU4vU29C?=
 =?utf-8?B?L3pTY0Z6dGZtaVgwOXFSdExZS2Ryc1FPOVFCc1ZnUE40VlRkUlhjRmJ5Ti8w?=
 =?utf-8?B?V0NCSEZxUW9OdnJlU1JNT00rSWJZQWZKRlZUVElnL2I0NHVkcXI0TE9NOWdl?=
 =?utf-8?B?TGNZV1VjT0JsQW9UTUsvbU9HY1hibXhrb2t3dkhJdHNQU2w2aWFRcUQzR3hT?=
 =?utf-8?B?U0NvdDB0QlpuemZ1MzlvaXp0YWpVTFQ4WEVKVTR3NEY2MnZPWGR1emZKNjVG?=
 =?utf-8?B?bEN5VXY4TndBVDd1RHg2bGtkNndUakR4V0l4MVh5dmEvUXJUb293cHpqTlZt?=
 =?utf-8?Q?SwqBZRJoPXI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjgzUkQzdlo0SThLREl1VGE1MHhpTi9vWXQrRnplYnpCZDkrVHRyb3ZIWWdE?=
 =?utf-8?B?c1NtVVY4WFFMMEdLQnR3QVRoQk0veUZRTUZQamt2WGVsZkIzYnc2aWJvTUI3?=
 =?utf-8?B?Mm1pK1FrNjRrMGs1MlFTaWRTNGg5Zm83YlI2RWNna0VGb3ViZHBGRFI5MWxL?=
 =?utf-8?B?NnhheEFjNHZZUGFKUGtrZEhrTSt1Y2pHWVY1d2tldk5KZ0tNRkM5NVR1VDY3?=
 =?utf-8?B?STlSYmd6UXIzQTAxdStXaGY5a3gvUkZpM1RKMVJ0bWxQNUE5S0dkYkJjZUZW?=
 =?utf-8?B?cmJEd2s5V1ZGVFZQQXJzNHF2d2hMaHMyRld4RmlNWkxrQUtZOG9RaXYrcllk?=
 =?utf-8?B?T25FK2s5RkQ1SjBrLzIwSmcwSkZVWjVSdHlRTnJ6blJIdlFpZzJ1ZzFTSFJy?=
 =?utf-8?B?U0JMenFTRlpVekNhU3lYc1FWdVRwY2NLaDZLUGFMdUI2YlVCQ09ENXVlNDJW?=
 =?utf-8?B?bGVJdzdrYmFCTGd1Rm9vY3RNZFRkZzFoelpVc3FrTDdQN21EU3UzMVhnRXE3?=
 =?utf-8?B?K0VFV3dOYi9Sb0hibEtvZlhNRyt3aW9yc01oSG04dUZXMXBvQVNQODZ5VGtD?=
 =?utf-8?B?Qm53MXl3VkRHcjdycTNIUStROStQcWVuOHNCbVRYU0FoRFh0OUNWZm9ZcDRB?=
 =?utf-8?B?MUxldzhOaS9iUEV0dUZjSlE5WDN4MGk2TWhYQnVSVHRIdzZvckJrdXovWW9x?=
 =?utf-8?B?MHlhVngreXIrTXprMzVPc3pCTE9OdXJOWFlnUjJyR1MwaHhKWmFxalAvSlgw?=
 =?utf-8?B?OXFZbDJIVVNCTG03ZFUvb0kvQTFObXk5bzlObndoUGFYNDBrSFJvYy9MQ0I0?=
 =?utf-8?B?eHhuY2l5YVBkcWZsVjRVK1QxbjFxaklKeldaS28wV0F1cFpHVkdNTDdGcGRK?=
 =?utf-8?B?VHBqTEJ2Qit3MUJ0MzJ5YStPZlpVMjBBOFVvUVhyaUQ0SC9nWlVPREJXWnRx?=
 =?utf-8?B?cE5RVTEzUEc2VWJVQ2g4SVVtY0VFRWJBeFdWZUJ2bHFzcHA1UTIyTlovM0Ux?=
 =?utf-8?B?WmRDMDZZL2NDdUoyODJtZ3QzczA0aTVXTTFKUjRDRDFUOXMrem1icFhwVHlY?=
 =?utf-8?B?cWRqM1dTZmJUTUV6b2J6WjJoZDQ0aE1yN2VISG5MRXhEaXdReHVBcWFxcTQx?=
 =?utf-8?B?VUpHcmZ5TWhNNVEwaXkwQWllMGYzYlVybU54ZldDWHErV1V5ays0c0xWcWVj?=
 =?utf-8?B?VHdOU0ZCSkJTZ0p2bHY1MmtqSTlpd1NnUzR3dTdIYjJLT1UwRDdvaTdIeDVZ?=
 =?utf-8?B?VjhUY3l2czZiYVl4UGoydzVSQW42WkhFWGdKa3lPY2pQei8vY3ZtS1FjR2RP?=
 =?utf-8?B?OVoxbzMrV043ZjNYUzZNQlhic013MHRTSFhFdVQ4a1RiR2Rtck9DdlFCSkVJ?=
 =?utf-8?B?U1Z1STZoOEp0NTdxUjlCOE1OYzNSVlB4dUZnbTZJRUZRWFhaMURaRnBVZ3Aw?=
 =?utf-8?B?NEhGdTdQUG5sclFycjVXYXFOUitLY1EvR1VsbTViWXl6dGt4OTFQZ3A2WXFG?=
 =?utf-8?B?T3NKYWlnSnd0cHlORVdWdlkrUUJ4Z1h4ci9iUnhSaU04L3ptZmVkVHVJVkZ0?=
 =?utf-8?B?QkRsbGdNQWduVGdwMkhVMWthSlhZZGtqMmZ0LzU5K0plUUxkaGRiNHhNRlIr?=
 =?utf-8?B?d1Z3UkRZbDlzTGZOWkk5dFpmVHdYbFljcS9mL2FGVVNiaTQwUEkvZ0NndjhM?=
 =?utf-8?B?LzQ3NlRXOVR3OWNSSkRXR1FKaHo1T1JLT1orOEpDRzlUVHdBYUVnbXFWWVVB?=
 =?utf-8?B?ZG00ZTZwc0p6YTRnOGQrY0NHSDM3cG1ocHZqY1V0bU16M1NwL3hNOWtQSXJH?=
 =?utf-8?B?cHBNa1VnbnBQb3dXR21XNFJBSWZsN3huOUlWK3QzTXNNM21wY01xOFU2dEFQ?=
 =?utf-8?B?U1B3b3BCWG1vSFFKRjlzbFJJTUt3WVR1VHJIR1ZUVzI5TlVDSEFueW9VQi9R?=
 =?utf-8?B?dFJldGRlTnpSMW1nQmE4TTRNaStPNVhxeVZ1TjZSdGswWDBGeGdzMDkwdjNV?=
 =?utf-8?B?dlVlUGY5bkZvRit5OHJXZEswK1dtU2FQSUNicFF0Y3hMZ1VseDNTZmpaZFo2?=
 =?utf-8?B?TkQvQ0l0S1E0V09rZll5TWJjNmNKZVpoazUzYjFrY01jVlAxNnd1QXhjVUxC?=
 =?utf-8?B?RGN3Qi9OTWNhdm5zUTh0MVdYc2JjK3JROTdpYVBkQSs2aVFaQWFraW9Kbzd6?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d853c10-2894-4fac-7f93-08dde496999f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 11:49:23.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxDQYFkrbhaEhOw2hhtqO6/JQ7nPwbIkiC0ERnKSZG3FEJCPqObbfGqt/dN0PhWMSuyCSQ2MfA4TtRGISRSn8Kbw99liNxGQWCo6z+/P0HA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4699
X-OriginatorOrg: intel.com

On 8/26/25 00:56, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The fbnic driver was presenting with the following locking assert coming
> out of a PM resume:
> [   42.208116][  T164] RTNL: assertion failed at drivers/net/phy/phylink.c (2611)
> [   42.208492][  T164] WARNING: CPU: 1 PID: 164 at drivers/net/phy/phylink.c:2611 phylink_resume+0x190/0x1e0
> [   42.208872][  T164] Modules linked in:
> [   42.209140][  T164] CPU: 1 UID: 0 PID: 164 Comm: bash Not tainted 6.17.0-rc2-virtme #134 PREEMPT(full)
> [   42.209496][  T164] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-5.fc42 04/01/2014
> [   42.209861][  T164] RIP: 0010:phylink_resume+0x190/0x1e0
> [   42.210057][  T164] Code: 83 e5 01 0f 85 b0 fe ff ff c6 05 1c cd 3e 02 01 90 ba 33 0a 00 00 48 c7 c6 20 3a 1d a5 48 c7 c7 e0 3e 1d a5 e8 21 b8 90 fe 90 <0f> 0b 90 90 e9 86 fe ff ff e8 42 ea 1f ff e9 e2 fe ff ff 48 89 ef
> [   42.210708][  T164] RSP: 0018:ffffc90000affbd8 EFLAGS: 00010296
> [   42.210983][  T164] RAX: 0000000000000000 RBX: ffff8880078d8400 RCX: 0000000000000000
> [   42.211235][  T164] RDX: 0000000000000000 RSI: 1ffffffff4f10938 RDI: 0000000000000001
> [   42.211466][  T164] RBP: 0000000000000000 R08: ffffffffa2ae79ea R09: fffffbfff4b3eb84
> [   42.211707][  T164] R10: 0000000000000003 R11: 0000000000000000 R12: ffff888007ad8000
> [   42.211997][  T164] R13: 0000000000000002 R14: ffff888006a18800 R15: ffffffffa34c59e0
> [   42.212234][  T164] FS:  00007f0dc8e39740(0000) GS:ffff88808f51f000(0000) knlGS:0000000000000000
> [   42.212505][  T164] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   42.212704][  T164] CR2: 00007f0dc8e9fe10 CR3: 000000000b56d003 CR4: 0000000000772ef0
> [   42.213227][  T164] PKRU: 55555554
> [   42.213366][  T164] Call Trace:
> [   42.213483][  T164]  <TASK>
> [   42.213565][  T164]  __fbnic_pm_attach.isra.0+0x8e/0xa0
> [   42.213725][  T164]  pci_reset_function+0x116/0x1d0
> [   42.213895][  T164]  reset_store+0xa0/0x100
> [   42.214025][  T164]  ? pci_dev_reset_attr_is_visible+0x50/0x50
> [   42.214221][  T164]  ? sysfs_file_kobj+0xc1/0x1e0
> [   42.214374][  T164]  ? sysfs_kf_write+0x65/0x160
> [   42.214526][  T164]  kernfs_fop_write_iter+0x2f8/0x4c0
> [   42.214677][  T164]  ? kernfs_vma_page_mkwrite+0x1f0/0x1f0
> [   42.214836][  T164]  new_sync_write+0x308/0x6f0
> [   42.214987][  T164]  ? __lock_acquire+0x34c/0x740
> [   42.215135][  T164]  ? new_sync_read+0x6f0/0x6f0
> [   42.215288][  T164]  ? lock_acquire.part.0+0xbc/0x260
> [   42.215440][  T164]  ? ksys_write+0xff/0x200
> [   42.215590][  T164]  ? perf_trace_sched_switch+0x6d0/0x6d0
> [   42.215742][  T164]  vfs_write+0x65e/0xbb0
> [   42.215876][  T164]  ksys_write+0xff/0x200
> [   42.215994][  T164]  ? __ia32_sys_read+0xc0/0xc0
> [   42.216141][  T164]  ? do_user_addr_fault+0x269/0x9f0
> [   42.216292][  T164]  ? rcu_is_watching+0x15/0xd0
> [   42.216442][  T164]  do_syscall_64+0xbb/0x360
> [   42.216591][  T164]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   42.216784][  T164] RIP: 0033:0x7f0dc8ea9986
> 
> A bit of digging showed that we were invoking the phylink_resume as a part
> of the fbnic_up path when we were enabling the service task while not
> holding the RTNL lock. We should be enabling this sooner as a part of the
> ndo_open path and then just letting the service task come online later.
> This will help to enforce the correct locking and brings the phylink
> interface online at the same time as the network interface, instead of at a
> later time.
> 
> I tested this on QEMU to verify this was working by putting the system to
> sleep using "echo mem > /sys/power/state" to put the system to sleep in the
> guest and then using the command "system_wakeup" in the QEMU monitor.
> 
> Fixes: 69684376eed5 ("eth: fbnic: Add link detection")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

changes look good,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

next time please minify dmesg output:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages

> ---
>   drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |    4 ++++
>   drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |    2 --
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index e67e99487a27..40581550da1a 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -52,6 +52,8 @@ int __fbnic_open(struct fbnic_net *fbn)
>   	fbnic_bmc_rpc_init(fbd);
>   	fbnic_rss_reinit(fbd, fbn);
>   
> +	phylink_resume(fbn->phylink);
> +
>   	return 0;
>   time_stop:
>   	fbnic_time_stop(fbn);
> @@ -84,6 +86,8 @@ static int fbnic_stop(struct net_device *netdev)
>   {
>   	struct fbnic_net *fbn = netdev_priv(netdev);
>   
> +	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
> +
>   	fbnic_down(fbn);
>   	fbnic_pcs_free_irq(fbn->fbd);
>   
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> index a7784deea88f..28e23e3ffca8 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> @@ -118,14 +118,12 @@ static void fbnic_service_task_start(struct fbnic_net *fbn)
>   	struct fbnic_dev *fbd = fbn->fbd;
>   
>   	schedule_delayed_work(&fbd->service_task, HZ);
> -	phylink_resume(fbn->phylink);
>   }
>   
>   static void fbnic_service_task_stop(struct fbnic_net *fbn)
>   {
>   	struct fbnic_dev *fbd = fbn->fbd;
>   
> -	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbd));
>   	cancel_delayed_work(&fbd->service_task);
>   }
>   
> 
> 
> 


