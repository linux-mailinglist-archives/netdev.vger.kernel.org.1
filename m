Return-Path: <netdev+bounces-167920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 541EEA3CDB5
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 00:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4FF3ACEB1
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A0D25E453;
	Wed, 19 Feb 2025 23:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jx8WSRaK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD0021B9CA;
	Wed, 19 Feb 2025 23:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740008244; cv=fail; b=h0vOW/X1DyurWwm5mKMmRdrQdXeNpFk/n8YWV/Y+k9doQC30micKKF3DXFl3owuG3RECn7W+7Pdhdgl8PenkW/FYRbAIWM2QiiP+YaRUpxfGizw+9tnyNNIqomMSRWdu8VQyQL93Tq5/RMCUqMa3S+jRDK0McU3rcim9zedj9Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740008244; c=relaxed/simple;
	bh=hZNycg+/HRLMviM7mcDWY1t2ES0VbqXdi/ARD0xx374=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xn+tV9j57SRDx9+RG1TfcMwI7Z57GxdRkzKWCCX+V/VQjIEGBrr6uRwhoNIakIXn4d0pSnMN4WiDbreGgNuRwPzVfsejxSK70TEe9xm20ya0ff6Zsdz7+NfWtwn4IBVuGtcExa1Rd1p7QNyIHd9D5gRbdxq+mkyKF55KmExdLSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jx8WSRaK; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740008243; x=1771544243;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hZNycg+/HRLMviM7mcDWY1t2ES0VbqXdi/ARD0xx374=;
  b=jx8WSRaKkaPzk4DXACj7kjt/hq8ty0+GpLyHQH7cx0vmBYuDD+PwlHpU
   QbApXK/wZ2iWtK3m4I0dbOgfg0XxAeNI6nZp3iIWM76wQz/ll0yhcdMaz
   aonXA64gDZXKgxp/UE/zM078WWN/o7BjgQ9y0Iv4EFwHyQyUTTNGxT/VX
   J1uXJQDfxQ2fRNOehsIDa3tv/QA9jy42GDMSCBFBvXpGqHa2gn27x/5UI
   gMnDbI1Fp0fwCiMbnEZmfrBwNO9z4U8YMUlI2NxPHO8pB1VzxKWvkOibE
   PoeClrJ5Z2xWRfk+jx3OSrHUFvOSo9xvs4GZshRQBdlusL3gQ75eOLMxf
   Q==;
X-CSE-ConnectionGUID: /v2pK9MfSwKH+AbuNE3x1A==
X-CSE-MsgGUID: n2Dd1rRzSTWCeEN3MykiJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="43598907"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="43598907"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:37:22 -0800
X-CSE-ConnectionGUID: n1plrf+IRIuSx0zUbKlGZg==
X-CSE-MsgGUID: T9CW0IxSS8Krbb4jpHpR8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115345019"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:37:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 15:37:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 15:37:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:37:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2s/IfHBUJS+XyDZbxh5AXqGPe/HdcUezZOqf1JZMwt6lz7zp4Dqfa+G0jvhwEj2Zy+JRbC5H/Kvzzm8WFMz37dlMrOG+Uy7LX/XktleWhc1+oRX1q5uvMl+L6LnoR+WiW20HuOVZyROozkRp9tp2RZd/9S7BQz/qZdVN3pZljfANwBhWT4LLFXWqSRk9Er6QPGOLLQXEOX+c/vg78O1IrBn8rwezkVku0n1CQIljvcp0uJTkmOzC4tufrxqFULzKHQmtp1U1Chj9DbswceVsg9PM04eKafIdbH7SkfWjMyBaBAw9ij1xpuVxnJ2gMsJnbTJstvE1xFM7lbz1tolyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z52vl5jPkk2Tfe+gbL5W/nChkstvNH2wS+Ipfz/1qKQ=;
 b=Kd5DzY1EvhO0bo37Xf2DfqRlfNy8oZmrzzZWfxI4NKGatoLj7cX42S2f0OcMPm/957zHtplXA3/LvxJ5B2zY8wvzD413vOmDu9kzdSIklddYXqbEPDEfvs3zzSylrSqCcEQ4eTjtyiN6X0AhzbgsLhXeEhjS9/0HuxTXlnVCAEttvUeFTQu4WcmTW9RjShrZY3EaV8NqHTCRCP2RlMMA5/TcUlkQyc8OqvA2UqfftwJHYu7sXdAkWnt4xz4wUiV6QfhkjcL1MBhjrbJ6PTpm7v+qJuxeI7xvBnJ0ewOlt+2JDCU4O29r22l7N6ix94uXjO9QAQCK21vBZP4IayZ+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7735.namprd11.prod.outlook.com (2603:10b6:8:dd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Wed, 19 Feb 2025 23:37:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 23:37:17 +0000
Message-ID: <415f755d-18a6-4c81-a1a7-b75d54a5886a@intel.com>
Date: Wed, 19 Feb 2025 15:37:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] Fixes for perout configuration in IEP driver
To: Meghana Malladi <m-malladi@ti.com>, <lokeshvutla@ti.com>,
	<vigneshr@ti.com>, <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
	<horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250219062701.995955-1-m-malladi@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250219062701.995955-1-m-malladi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:303:dd::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7c4326-e555-4cfe-7c97-08dd513e58e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFZKK3FrNHhoaXJmS2tBdmpnZmJYUHNBa3NsNERmSUFtTnNwekJBNmx3c3FJ?=
 =?utf-8?B?WTNDRnVMMllCV3cvZEx0M2lyL0ZkbndPaS9GbjFQK3ltVDc5YkNaWk9PREF6?=
 =?utf-8?B?MFVLNEZNdUN6ZUw0ekYwRkw3Q2R2Z1gwNlpQWkZGWU5JVVNyeFI3OFFsYzh5?=
 =?utf-8?B?SXE1dUFpR1VNOG1uVHNna0VGWE1IZUZXdmd5OS9kZVRRL3piMDlHZTVXa25t?=
 =?utf-8?B?RitqZ1ArcXJralZlUlVHcDJNTFBSM2xNY0Z1aDBkNGNiTVFvaENhUjdnMmRE?=
 =?utf-8?B?Y280ZHB0eXFOeHpxckNOVkpPMXhnZm9FUDRNdkFyTG1RbEVLdm4rcVNWTkZw?=
 =?utf-8?B?bHd4clVuMUUrN2pheVcvbzlVY1ZLLzFzTFZWTi9IQ0NFa2pGK0lpc3lUOHVv?=
 =?utf-8?B?R2szNVdodWorT1JJM2QvY05DcnprUjBSZkhDZVFVcnhGYnRaaUc4VEE0bENZ?=
 =?utf-8?B?Wm9LaFFoYjZyS050THdFc01DdWpGZ1JtdHBwUlJ1VVhNTGMvN2Y0VGtuQ0Iz?=
 =?utf-8?B?bHVKMFk2Wm1tU3JsRkl3OTU2QUoxV25HS212YzFMZm0veTBRd2lJV2xsSExy?=
 =?utf-8?B?VXRnLzdQRjU3Zk02UU1GQ1dXUW5XSHNROUdDV3JwWnhyeUVjeENuMGFJZndD?=
 =?utf-8?B?a1ptWWV0TzdmSzBlbDZYSS9xQzFhejhJRWpCNWYyL2R0M1JQdHBQQ1FpS0Yr?=
 =?utf-8?B?VXJuOEd5U3ByTlg3RXNndURxNEZxQ25KbXNGek8xQ0xEZTJ1L2k2dStJNDEv?=
 =?utf-8?B?R1M2OFo2bTljRUpxb1hTcURLT1VKRXJTMnQrU1VjRk1Db0dMMUNyV3VlcmVx?=
 =?utf-8?B?cE9mMEMza3k3cFN0d1pGcCthVUFuUVl0WGF4OG5INlpPTVNRV25NcXJrZzlj?=
 =?utf-8?B?VWpOb0dSSzhIOWV0N2phR1FqNGxOY292bDB5U1JuMi93Y0NyQjJUMnJ3Tk9C?=
 =?utf-8?B?ZzNLbndMZ2tIcmdoOXZEQXVwWW5jVFE0OHllbVcwWmt1OTJLcEFVMnd5eDln?=
 =?utf-8?B?cVhKZ2N1ditUb2ZadG9mRS9rak1RZ2RXck90OG0zc0lQU0tqb3ArUk5aVkVw?=
 =?utf-8?B?WnFTQUlncy9sRzZ3T1VjTlhDY3lmcTRYQnd5cEVCN0F6RWVGWStXeVhxR2t0?=
 =?utf-8?B?ckFBYlNsY29IVDZvaldpQWpRTFdRRHkzNFpEeHM1ZE9xVlN5aWxnMXowQkV3?=
 =?utf-8?B?WTBkZWZiYmo1WEkzb21QaUQ1VEhQbjlwcmNCeWxVZFB2NkVZSUptNnhMWGdt?=
 =?utf-8?B?WXFWTXBJZ2pnbzZSQmJRL3JwTzNOdGpod1JmV2I2aDZjVFVKbHRaRmJwdmow?=
 =?utf-8?B?VHF6d2tlR1pEOUN2MXA3aFFWWWN0T3c5b01VNXY4aGc1QnFyQ3VlZWhJUjRw?=
 =?utf-8?B?aHlkTHpuQlljQmd4NzNUM0hHcm9GR2hndkZwUTNkRG5mNlFBMkdkRVd6Y1JL?=
 =?utf-8?B?NzNEU3U1Zk9ORnhVK2RDVlVBUzVSNnhpUU95dm9McEdFRmh3V05pdzFMS241?=
 =?utf-8?B?ZlYxWkt1bkdYOVBiMlpCRDkvdUVOeEp0Y3JUdi85U3I3WldYbXJVdU9Cd0U4?=
 =?utf-8?B?cytzK3pzVit6TXNWcHc4QkFmNi8xcnJhTkxlRWI5TDJqTnQxMXZzbDA3NjdT?=
 =?utf-8?B?dDM3N3FRNC85by8wM0JLMGs2eGZQWDhuN2Zhd04yNDFHblM5aU1sYncrc0hi?=
 =?utf-8?B?RFVFU0lBbXhOd3lDTURZUmFFREJaZVUxWWhjV1NRa2NTbEh3NmtRVjR4VGli?=
 =?utf-8?B?Smwxd01KSlNHTTRqN05tSEd0dVJzNTFrci9kTXBmajNyb01NSmVQMTBRVDIw?=
 =?utf-8?B?RTRwekVhRHQxZEdhNmpxYUxZTlZDWkFsKzJwQ2tabDhZYTRsQTFIR01WSUt0?=
 =?utf-8?B?Q0xRczZ3dEIxRmloNzM2Q1pIWlptU1RxQTBSL0YzMGFVQlNHMzNDUmE2SnlW?=
 =?utf-8?Q?e2QpkYY8Dbo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi9QVjlxOE8yMUMxQkpNQU1XOHVxTFlaT21xVmRPSXp3VUxCQjdHc2UvbFI1?=
 =?utf-8?B?ZXVsYXp4ZS8xWmVKUjhhMllLcjB1ZDZPZTl5TlhXQkZ5WDBuK3Z0ZHVXa3Jy?=
 =?utf-8?B?S3dvSE9kTXhVR1JvVVdraFBOaFlzREJEckt5bld2aFNoYU5ZN0J4S3VpUHdh?=
 =?utf-8?B?VmRKRkpWdzExeXI5cDFJQ2tQeVI1QVpYNzhvSlpIWWswbEl0Z1N1MjlkV05K?=
 =?utf-8?B?NGVpRGNPeThTS29vd3RURjBvU1o5YjB0SXc2TjhpSFE1MkxORitlR3BQMzI5?=
 =?utf-8?B?TURqVTBGbFJwak9UNUZxRlNOSUM3cWxBOVV6TDFzVlNMSkd4SlZRSVFJb3ZH?=
 =?utf-8?B?b1c3WmdsbmFlbUJNVmxhV3JpWkE5cnQ5Q2FZMFBxM1g4RGVCRmlEdlZtOXds?=
 =?utf-8?B?M1hDdm92eUdxVFFjZ01hZ0hvczByUFV5REovemhvMkNwREdwcmRMcTB5ZmI5?=
 =?utf-8?B?SjNSUW1ORnp0N1VWUXBKWkg1bUJCQ1diT1pwNGF2bWpYS2pGYUZNZVg2b3Qz?=
 =?utf-8?B?cXUrMzdvUy9VbXg3YUVvT0dEZXdwMU05eldPcU8vaFZmY0p5L3hzRVNUaEhD?=
 =?utf-8?B?Z0EwSG5vNFJTTGI0WGhQZTFveHpnV3NzN3N0cTVISHYyVVlyV2xzZ3dqYTN5?=
 =?utf-8?B?LzdNU25WMWprNVpMdHp2NFJjNHRzelpqOGVRc3d0K1MwUmE3THhycGtpTllh?=
 =?utf-8?B?akhoREViVDZKcDh3dE9JeGRlbCtzYzZSR3pabUt0RFUvOVN0SnVzWjFPSUlx?=
 =?utf-8?B?SFZ5dTN2aGNkNTBtUDBHQUsrb1ZET2JXc3k1b0thaHZ3R1JFOUYzcVZxcis3?=
 =?utf-8?B?SHBmQ0xFazREb09DR1JRQ25yZXZ6NmpLOE93cUVIVldqVmd2bXhLdlVQOU4v?=
 =?utf-8?B?bGVSQkNhS2lBN2JFKzV2VGxldWMzWTNXbW14cExBUDlGR0RLZE80cmU1Q0di?=
 =?utf-8?B?d05CaVlDaFA3RnBRUmNhYzJhUDRtZVZjekZUWC9TUFI2Yy9ldEFYYmIyQ09Y?=
 =?utf-8?B?SjRvUlZsbnUzZGJBQS9KdnJDLzVEd2w4Q2dBdjlMcm5LVFd0ejg3NFBzRjhY?=
 =?utf-8?B?UFhiUFB6VmtzOTlodjlabGpJbG50dVRuYTVnWXcvaWZwdFB1YUJocERYMjky?=
 =?utf-8?B?MVFqRWxZeisrOTV1elZScElBRGVXRTVlMkZGQ1doWVNBbFRxQ3FCQTVNUUFz?=
 =?utf-8?B?N0tJd1JuNmF0TG5hbUNMWDkxaDhWQnRjZ0gyUHdnN0tCUWw1dlM1TlkzNFA0?=
 =?utf-8?B?aCtITVZGenlBUXdqTkNoTFZJUGYrWXhIdThqU3dCTytiUGNYRmIzaDl5SlR1?=
 =?utf-8?B?anpGcm9HZ3RBUkR1TGFBa2o3ZzF6Y0xmcktpa000bWxEcHRlWXF5RFVyNFB6?=
 =?utf-8?B?M2FiSGwvcU16eGlyblVjd29ZZ0pEZ0tRdGFnQzduaTVPTGtTcU51OWFtL0lH?=
 =?utf-8?B?R2RpaHNaMlFZOGw5ZFB2cjIva1ZLUjJoWVZNcW9UZWVpTE90djA2RlExZVM0?=
 =?utf-8?B?SWgrTjVlNlo1K09OdUN1dlZoZGZFZllmdUxsc04rK1QyMnhwVDFLaWlEU1lh?=
 =?utf-8?B?amtBNVdVRDlwbVVYLzlhc2pVdDc3RlJKY1lDREwvVkJLaHB5dXU2dG1QQWxp?=
 =?utf-8?B?MXBuN2d3dWtBV1g0VDZvSFJURXVpaVo3M2hhTGdXWW5QUEw5and3YWJrOXRN?=
 =?utf-8?B?MDNtaXRMUG1NaXRUQmUydVRRck0xVnpCV3ZWTVpFWDI4SitCekZaMFlXYnRR?=
 =?utf-8?B?MkZwOTA0bEh1T0hWdUxibGhKT2hHaTk1ZXVPWldPZ0lRUzNPS1E4djRWTmh3?=
 =?utf-8?B?WHQvcS9OdC9NUEZTZnU2azZhV3ozUkx4d2UzUHBkWW14VzZDTnphWEUwSGRW?=
 =?utf-8?B?ODFnZmUrRjlWcS8xc0F0a1BOY05nc055dkhRcjd3aEk2OFZ6cXdZYTc0akZs?=
 =?utf-8?B?cTF4d2tuZzVuWFFidlVMT0JjbE5uNEd1RURxdnNNOEhGSDNoelhaMmNKWnQ1?=
 =?utf-8?B?R1d0eXpVU0hSTXhuTnhoTXBrUHNDUWNoZk0zVGxOL2ZjemE5dHJRUGFFZDFn?=
 =?utf-8?B?ckFOTVd6SGxaZnNYWUYvRVFzZlFwN2E5dGIrbVBIR01RN3VrUWkyY1ZrcWpt?=
 =?utf-8?B?ek0vVUVWWDUxSzN4OFdSaGtyZ0NReWxmakw1a01vWDhnTnpIT0RYM1grTHJx?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7c4326-e555-4cfe-7c97-08dd513e58e9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:37:17.8944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxAtrxtid2jCIH9a4x0FjzjVsmII7Pv/2ue9WTW/Zrcw0IT2CeaRUlafEvzKXuzIzk0rzRmBESVFpeqNGbWmVQTJh1o+SFQ96PHoVALM/iA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7735
X-OriginatorOrg: intel.com



On 2/18/2025 10:26 PM, Meghana Malladi wrote:
> IEP driver supports both pps and perout signal generation using testptp
> application. Currently the driver is missing to incorporate the perout
> signal configuration. This series introduces fixes in the driver to
> configure perout signal based on the arguments passed by the perout
> request.
> 

This could be interpreted as a feature implementation rather than a fix.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> v1: https://lore.kernel.org/all/20250211103527.923849-1-m-malladi@ti.com/
> 
> Meghana Malladi (2):
>   net: ti: icss-iep: Fix pwidth configuration for perout signal
>   net: ti: icss-iep: Fix phase offset configuration for perout signal
> 
>  drivers/net/ethernet/ti/icssg/icss_iep.c | 44 ++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 071ed42cff4fcdd89025d966d48eabef59913bf2


