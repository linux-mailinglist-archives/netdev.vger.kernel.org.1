Return-Path: <netdev+bounces-168098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D145A3D792
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A4A17BD70
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB5C1F1508;
	Thu, 20 Feb 2025 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yxhn/3Uy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC61F0E58
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049154; cv=fail; b=a4Xxg7cq4pJtO2lHi3E0a7fd7WBPL5v9mb+tp85upMvN6/T1M3TGRgBpBgZgB3ZK02aN5eeYyWAtkKt63TsuNsg6lllbugQDfnoB9x4Xib9nHYz1yiCrLkcGddjXB00+WUnqkryWrwjde1YW8VDhEzR9tlEQKTbehC8AN0bIQoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049154; c=relaxed/simple;
	bh=sQ6BebhNFUfONwK9zXZBZB8n9mTMnUEqZRosTtNZ918=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fCt1NWze2ljgPAZqgqJCxSHM5HFK+Pc23sJLDksxCwtM1GRGEL7VmC29x212QwR9bIiIAmhOpX2uxkrA+fKrrUpS+Lh80fG6vnd+Vb72lEOkzNZJhtvaiTS5MmFzol/cj2JfLupJ6TWGx8HMzhaEQFuxZn7Wd0MHpEffkPUgiJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yxhn/3Uy; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740049153; x=1771585153;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sQ6BebhNFUfONwK9zXZBZB8n9mTMnUEqZRosTtNZ918=;
  b=Yxhn/3UyEDxqP+y+FQy5d7huUqJFRls9usOzuXmDblSGhGApW1mnCn0E
   4ObBHpeEvnlK3A7KNL5oyNvvoHCqi/6YX34JmVhe4kYxM7rC/JqUFl98r
   bQVKowV6InztLJmtWpysEGMNpKj407YwuL3T4ttekPeP5tH327E9gJYtD
   mQyjkGDmYRMYziiebDoTGyMaxaTeRdsZkLkU2dTKYAbnBYhB8XCBrO+5K
   oQpEzhu24x1tqeAeDlIXJwpF9Y51+rju3fd77Lrn0ynMngW475XkOGkc5
   zTHfGs5hxiSJXJKzdCFRpIbSXMgW9a7v1BLGZXHbJk5YqssXJCltWxyU+
   g==;
X-CSE-ConnectionGUID: J2V8/8fwSF6uxMcg6q5xeg==
X-CSE-MsgGUID: 7aHjlFnGSCKe1+1NRJBs8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40053005"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40053005"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 02:59:12 -0800
X-CSE-ConnectionGUID: sLXFpDXxQTa9nZris6hq9A==
X-CSE-MsgGUID: SA9DhlSTR8uWZqVVcbXJIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="145856181"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2025 02:59:13 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 02:59:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 02:59:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 02:59:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqYHVPdNp8UUaLci5wdRFOt86aY+oTFf3YsyCTA4KAYhfSWVfOjP4xNb8Q4/4XpoBPcSug3/2wF9Jg1aZSnwqAMvzBlvC+VH5/lXkpeVAgyIhFx5KzS+x//HaAPRBVWiPhnwJ+2NfgsOU4HmrhENqbCgy2r/EqwljGShsbs6Vz6F1y/2H/H8Cu/bki1fsDHwsgsLy7pEahd9MyWFS1uPELT1z5O1SKE1zXAXtQvFbTB4V7CMWaU2kxk1aSzjseZA9HzkdkRj8c8oQaeX05QdNR57uzsnPynl1iQhF7bigw2DDDOFo4bHfTi1XfbxzfG5UAlUHfzpSUhkvPj31gWbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD8MLGYi0fxPgef5OvsP5cAkUix2ezvJHV7T3NtjbOA=;
 b=ozeLfAtr8r/SllNqMFH9T1rozDx4mu4yIvwykv8IFcvMEoRMf1I+DafeAwdoBcARr6pIHdaKzR5LtBoZxAJayqpTYLk5MdUPk1biuFfnXDwxX/Sfeoh/AJhQ5iGwVXfL8NBCSX+9u1sbk1Hc4I2GESh+DMQIN557Ya7uP69SB8oaQ/QfcJ0YTmiYEQqdYr7n1zLH1XvC/XJ+4MQhl49dCyAnBmYYFjZKuqjnG1w2guDd+N8CNjW7NePhKslBy7c3Zh1C6B3bdBzddYjdEr/rAFl/Fr1y+xlILhuEqRQwJSMOHP+SEvcectjf8cqo/1LNi/7NO8A3WAc7TF1BL4Pp7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 10:59:09 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 10:59:09 +0000
Message-ID: <4c815e00-da1f-4ef1-9d32-01d09fedb095@intel.com>
Date: Thu, 20 Feb 2025 11:59:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: remove unused feature array
 declarations
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Miller
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b2883c75-4108-48f2-ab73-e81647262bc2@gmail.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <b2883c75-4108-48f2-ab73-e81647262bc2@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0239.eurprd07.prod.outlook.com
 (2603:10a6:802:58::42) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|PH8PR11MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: a809425a-1b82-445d-8e70-08dd519d99d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVdHSVJmblJaOFdMbWNsakExNVlvaHlET3pQby8yNks3U09kbW8wc2ZjRDNQ?=
 =?utf-8?B?YmJiN3c3MWtHUnkwSmZPQXR4N2hwK1RnS01YYWNYcHkxMnFOY1RlQXdJeVV2?=
 =?utf-8?B?K3VJRm1nVHE5SmU5ZmY2anZQa0E3VFV3bjVMd2pnRlgxcjVCbTBqWnhNL3o5?=
 =?utf-8?B?UmtCMTJHN29TSTFWM08vWWZmdVFMWXRRZ0NmeTRrY015YmJNaVh4M0hqK2c3?=
 =?utf-8?B?NDZUWlpiKzNzMFRtM3k0RlpGUDRtREJwcE1tR2dQQjdoTldNUWJMSm9yU2F0?=
 =?utf-8?B?T2Y3T1RiSFVzWEFBYytic0syNnZvZ2ZNRlhSdXBkYmpTYUdZZit2Slo2RjYz?=
 =?utf-8?B?SmoranVyMkd0RGFhME1jeE4xeEdaUkNlelRNOU1KSm41WkdQQlFOajJZMkRt?=
 =?utf-8?B?Q2pPVUhVNHBCcDNUVHBMaFRmbFJOYjJBNFZxb3VOREtSYUxOeVhUeUI3TFla?=
 =?utf-8?B?d3BkOGNBelhPdzRnRTc2M05mc3BjKzE1M3JGSlZPYnIyU3hTanVLL3VJeTN6?=
 =?utf-8?B?S1BkaC8wMjk3eUs0NWk0amZXZy91akNVSldOOUlRSUxocWV5VnZoZjdWbmNT?=
 =?utf-8?B?NSt0WnI3T2F1TGJERmZhUWZ0cXlQUGl3VVV6d2p3dnNiRkRDSGxxbThieFhl?=
 =?utf-8?B?S3c2WmxKZEZ6bHpMUEhJT2dHUzFybDJvUGlkMFpRQkp0bmNjbE5LK3VWTnc0?=
 =?utf-8?B?WXI1VGFXaG9JTEZIL0xzemZvRXhVdFFlUWZNS0ZSUkc5Zm5aajhUc1Bib3dv?=
 =?utf-8?B?NFV0U005V3dmYmxyM1U2RUM5dk9sSDVQdm51OE9KRVczZURYc0dVbE9nbFoy?=
 =?utf-8?B?MHF1ZHJRUWRDelZ0cnFyQ3Fva0FxRXgvY1JRYTUvQ0hpYmJ2ci9aY1RTUUky?=
 =?utf-8?B?a3M2UTZwMy9HbC8xbThiMU8wc0JSalRVdmhBeTZlMzlYb0lCTFZROFB6Uk5B?=
 =?utf-8?B?ZEJTcWgrcTlLVkYxZGRIVmhNZUVDbVlISzIwNVNOZkZBd2t6Sy9aS2pHZ3pN?=
 =?utf-8?B?N2pZaW5TeFdiY0M4TnJXNVhsZTNzd2x1UVpLQ0ZWemlvSEROb3p6a290V0pN?=
 =?utf-8?B?ME56aFZBM25qSytEVkN0QkV0SEprU2dFSDVod05PNnBsdHp0Nmg4VDBwOG1T?=
 =?utf-8?B?ZktSUTdtMlU2MHBieE92YTFqTjFXMlM1WVY1Mzdzam5SZGN6ZnpmU1BRUWFy?=
 =?utf-8?B?VDJteklhcTNTWGJZL1FCMTNTYVRqVWNxWmRNMGVxRS85eTRqMzFONmlQQnVR?=
 =?utf-8?B?OTdjc1lLcDJIS1dvVnhDSVhZczd3Rmx2ZEhQRno2azJKdmxBcWVidnQyNTh5?=
 =?utf-8?B?bDZzcU1wUFhSdjkrYnpSSE5udTV4WEFhZmRWK2k0OU9mK3NuUVVDVm1KeFlX?=
 =?utf-8?B?cVFEbHFxY29qM2hBZWRDTkx3T3V0UjQ0dE4wTjB1L2tndlQxYklseXZWUDl5?=
 =?utf-8?B?emtVVHd5aGFyNGxLNmtRWkdCc2I4Z1Bnd0RCL004R2RlYXVFaitiK1FEY2RS?=
 =?utf-8?B?NFZ2anY4V2NVOUZVMGkxSmpGT2FDY2c0djVvNEJUeDdBK0pIYmtxVWdML1Iz?=
 =?utf-8?B?UHNQaElRaHRJTWtYTjF2NUhpUWRWQXJLZGZjemVuakJEN2ZZV3JhU3Q3eFZa?=
 =?utf-8?B?RGx4M25wMFJRZzdXSU41dXI5MVdDemR5SnV0VUNudWtnaHdRdlRLOXhYZ2FM?=
 =?utf-8?B?Q2dxSU9zSzMvMG1jR01hMUdRbXRJdUtlaEkyNjBlLzN6VjA4ZkFlM1U0a05m?=
 =?utf-8?B?bXlXRmlNWWY2dHlyeGtwc1VVVDRhMGVXN2dTYUFRMDZldTVCazFGeFE0Z0Ex?=
 =?utf-8?B?N1JKbGJRQ3hTYjJTSzBmRnJ4cnM3S3N4Q0s3SUJyZWQ5TEFsdnA4UXlIQlFh?=
 =?utf-8?Q?K3CewC3yr18Pl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlorS2V2NW10R2xrbmVJSk10WldYeVpJT1B6R0JqWWwyd1BQV0lHNXRjbmgw?=
 =?utf-8?B?NklDU0U5R3RaWUxFbkhPNUt0aTdkS29ENjNwKzVkRHlXQUlIYmJxa051dkJn?=
 =?utf-8?B?SWxpT2N0ZVh6RzBmeWd2RllJNUVUQ2lTQ1RYeUdvN09TWTA5L2gxUlAwclQ2?=
 =?utf-8?B?V1AxR0w3THl5T1lha014TGtOM2QzbkxtV1djR3lZdGtpaXpPbmpaSVRPV2hu?=
 =?utf-8?B?LzFxUUFhN2NIRWVYZWl1NE9DRXFyMVpyV245ZFpsOWhPQzBacStIenFYbmhv?=
 =?utf-8?B?UUlvSHFiM0JaUzFJT2dLV241RVpmR3lpK2M1REdJV1hqclpIanJreU1TaHIy?=
 =?utf-8?B?QU1LQXF4Nzl6VjNldzZKNHVxMzR4dkNSTEtIVEpSdEIvT3R2VE9ySXpjRWN1?=
 =?utf-8?B?TXl0MXpTSTVhNVNEWGFWN3NNOXEzNy9haGhQRTZnZGk5WjRISHBKUlBQR1cy?=
 =?utf-8?B?U1ZSWE5hS3BFNUpCaDJmZHlKZFhSQ3hLZXBVc3BMMG5NcFdGRm5ZaHpNQTdx?=
 =?utf-8?B?RmlVV0x1Tk5FaTJKdlhPcVpPcjZuTjVvcVBIdmpNTjBjTFJsMzdMbzJCNDEy?=
 =?utf-8?B?eHdLUW5NVG5qZzdKVUFaNnB0bDRnUWpPNmlOaDA1VHM5TloyYWE0d2tHNzdC?=
 =?utf-8?B?T3h5OCtYQjBvVWVkMDdzbk82RmFVTVlGSXRhQ05rUm42UXdjUFBZbkVYcHJw?=
 =?utf-8?B?bW5meTNZRWVNNjh4b00vdjduSmRIV3UrUzhkanR6OFRoZFJTTjdJRGdvTkxq?=
 =?utf-8?B?Z2IwQWpkR2t4b2dzajhWWEZhQkJFQUlpSHJJSUkwQkhRNXJEMnowVjR5WlZE?=
 =?utf-8?B?TzhFMDRxTTQrdUtqS0N1VFpsaktISUhNaHZVaGFvRWFHTExNK21qdnlLQWlm?=
 =?utf-8?B?c2s1R2tkQ2d6QllyOXdxSzFYQkxUK0hUbW1KaEJELytodEFTYVhWcDJJd3lu?=
 =?utf-8?B?cjNlVE4xc3pWZXVNdkdCSzBMTTM1OU1PS2NZb0U1Kzl1d2tUWHdHSWRpMlFn?=
 =?utf-8?B?NW9UT2dRZU5zd2VpMVMyQ210MkQyVXQ5OW90dE5tNElrT1RCTVZ6bWhML3Bw?=
 =?utf-8?B?OW1rc2liMEFJUlhqdVlZcUxhOVRsRm8xcVdBSXhKeTBCYWxLZ0sveVdRRm9k?=
 =?utf-8?B?eE9GaitsM0lBOGlwZHNYUjlsak5rWWVWUEJHd0Nxc05BNXhVM2NFODhjU1Jw?=
 =?utf-8?B?SEUvTVo5c3NpQllWSnNLQ2dKSlpiZEpDblY2R1VqNkJpQ3RWVGtJOGZNK3lp?=
 =?utf-8?B?ODN4NTZodlV0bWlnSzlDYzg5T2tXRGsyQnBxSGdEdVVVOWZTSktoVHE1cU5t?=
 =?utf-8?B?S2tnMjg0ZDFGa1V6ZU5xZmY3Nk9qK1VCTmRLRGU1cE9GdTVuNGdvUkl1NXRt?=
 =?utf-8?B?LzVtMWF5NFhhNHpBRDV5Q0d6ZGhUT0ZMbG9IdVpqSTdjdUdCS2tmbnpiclQz?=
 =?utf-8?B?VnNObWZNUC9wL0JQSkRJdkMvcSswQnZBWitKUXV2RzFZZERSUS9USDNBY3pC?=
 =?utf-8?B?ZlhvbUw5cVErR3REODR3QlBodzJkWHkrN1E4bFIxNEdkcDlNZ3FNc1hvK0pK?=
 =?utf-8?B?emc5dDRuU1FGOUFCeWwzWkpmZmtlek5HUVJNSG9NczE3RjNzZDlkQTBmYUY2?=
 =?utf-8?B?MHFnL2tFdFVydEMydzlOVWxuMnFnbktvRG5nNHo0ai9YeTRWZ2tGYUluMDBN?=
 =?utf-8?B?ejRUN09XVWVkVXRnNkFCbDhJOW5zRnlmY01MVFpETzYyQXJtYWVEMlpIUTFU?=
 =?utf-8?B?QjI0MFp0YWRldG0rMkFjU1MySlM2VUxLQzVQSW9VUWd4WEpuTTlsNEZCeWtk?=
 =?utf-8?B?UkFNZGFnUzVCNFlyVFF1Nk42MGthR2lRNGJKaXV0ditvdFRNbGRHS3VwRnV6?=
 =?utf-8?B?MGxTQVJZaTVOOCtZMCtsMEhYQnZ6VzBROTk4eHFPYXdnOGFvTlY0ek9ZZXJa?=
 =?utf-8?B?UDBXbGJjM3RXcERzcmVnOXd1ZFh3ekJURG1NWklCUFBQdmZpVHFsaVBKeUZO?=
 =?utf-8?B?U2gwN3RMOEdneElRdVBoVjJSNXR2L2N5ckZwK2RFQldveTArWElDamIvS1l6?=
 =?utf-8?B?ZnpSS3dWLzJJSFRpWkhHUzVzZkNmSHhyVFNlZUtWbDFyNkhMU0lxRUJDQjZ0?=
 =?utf-8?B?VFFnNnQwcjRlN2Y3U0JoY0NtMDJvK0tLSzNFQUo5dnhLNXVLT0hqSmlxanNW?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a809425a-1b82-445d-8e70-08dd519d99d0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 10:59:09.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB5M2xAbZRu75d0aBLFGokH4Z1IoG3yH/RkHlOQvDIs1xjAL5NkC6zyw8wRZUWX994rRvanKVYjMETq2YCmv+awVGJpiJVvx5/QmK30oMRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
X-OriginatorOrg: intel.com



On 2/19/2025 9:15 PM, Heiner Kallweit wrote:
> After 12d5151be010 ("net: phy: remove leftovers from switch to linkmode
> bitmaps") the following declarations are unused and can be removed too.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   include/linux/phy.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 3076b4caa..e36eb247c 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -37,10 +37,7 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_t1_features) __ro_after_init;
>   extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_t1s_p2mp_features) __ro_after_init;
>   extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_features) __ro_after_init;
>   extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_fibre_features) __ro_after_init;
> -extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_all_ports_features) __ro_after_init;
>   extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_features) __ro_after_init;
> -extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_fec_features) __ro_after_init;
> -extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_full_features) __ro_after_init;
>   extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap1_features) __ro_after_init;
>   extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap2_features) __ro_after_init;
>   

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

