Return-Path: <netdev+bounces-198750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FF4ADDA50
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42E15A71CC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1942FA637;
	Tue, 17 Jun 2025 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWvr5Gfm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AB2FA626
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179519; cv=fail; b=YFwGOYhvh7pXN8rV1quUK/NP8IL8G8IEuHNDwblHU2vMaY/8/zMQrDNOUaPTB7u0y6o+VzBYHTLGJZpJ9HrQvGHrxSovLUgtPk64+6MEtPIeI49m9i9QNXIMmBuoeudVrCDap8ZccW/8HV0SS8GntzvKCmFsCK4jHnHhcz2zO64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179519; c=relaxed/simple;
	bh=EluGg3bU/scvHkqiNPtglv0QC20MP5LPEkiM80tpHnE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=biyBGKgsZFxjCg6uAFIbjhvTmIqwT91Hfd2fsxzwL3h82O8bVqOAvcgiM5HuFw4VnsryctFwdejb4tvH7h8RbgqxM9n+eU74QvpsoSrPQhQrI7ygdQR6bbyqiDyUoQo4vhs3TwJsV8um1vejqQjAAgXKA7knmbxEWfo8SYgLcI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWvr5Gfm; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750179518; x=1781715518;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EluGg3bU/scvHkqiNPtglv0QC20MP5LPEkiM80tpHnE=;
  b=SWvr5GfmCXXD6cyYzJKm7MqjuoeqeLFlag+UoIrbEeFb7+H6LXeg6cnV
   sAK2Ryz3HZcA1IkyXdRdlcqoPF4fSslsXqYzPacoT2EnWBdDUeSVlzZyp
   gtUoXWmpcs4/0NktNkGvnkrdrGFXzZUiPuInrif3ojsxcBLaV1lL0DA/E
   /T/c4B3VXIczrm3jRS0LUoA1QsHcrLs9oXzF+mApDiF/2+lx2coTZfzva
   Q/g0UJ2Z+JEPTrf2WvZ5pNy8teqnIEbwrytyQw67j+fFgYtypsACvU4f6
   s2eVhJ7hdfLX8b5aasNVexoBUx/nKre36jMFkXxSMgIL49GqvNdGeZXmK
   g==;
X-CSE-ConnectionGUID: tsmWplp0QRew4jGXrQhqhg==
X-CSE-MsgGUID: 1bgzeVC2R7u1WAdfGfCyGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="62642783"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="62642783"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 09:58:37 -0700
X-CSE-ConnectionGUID: t2RsCD8iSc2IPm+NLP3OfA==
X-CSE-MsgGUID: sKgGtj1yRE6MhrcwaEpMgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="149729837"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 09:58:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 09:58:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 09:58:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 09:58:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUhpKkX6nTmpsQyacq7u1ODLLNpSa7INGdn0qaCxlChkD05TIB9DW3oMFlfaSZ4rYmpVav0hZ0a1gWoXLq3QLTJqqWtKNMBbz+L2QJifDkvhthQutgiENSCMyTRMSkg8kt57/Txj0IX9FKbWSO2kHeV7t8tmyogm8Qt5aW0bz5yC9Lkj/qsDHHIclYl4xbsJKZUhneXmLm4QJ+goBMvM6A2EHqPYZIN9OK0EoSHKfExyVZowlrSbUxhc93Y7wM1PW70Ls62YhmdhATD3lgc9khshgi9CVQanTY/t0YiFSWHzCRFPiUrZHtX5K70U3yw5vGN/0CKF2xXzEnL7GUue0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfP8KmifFd6TY+kcgR+PMJeDMSdKh8Cx+Vog2S/Y3Qk=;
 b=OAUjldRslssFK4ch3RWabRwelV6RakQ+UWpHIXqRrTLr6IrZLQVVeH3w4wk28jGPbJCNLLJuJYexo+VAkTKb7RF3znGFhE9m9xjN4YA+h2rISns3ziQQIM/MMGcXg2yj0dF66d37oun1HGt1DCCK3HMmuNFhEJwMlqZdLzcebkuZ7QStuwcp8BRiGfPgYznadIjroTkXHqr29+oWfKJqxY/ozuQuVaElc2VGX4dBLMxKNKYA5jtH/o472LEuCvBeExvmQ9wa4yDiANYZAurJFy2fNfMGgcC7i5gqkJBE2sfXoSDVzpByhk2gLBW0cyG5Gu6iv6kePK6fftVA9sgWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY5PR11MB6234.namprd11.prod.outlook.com (2603:10b6:930:25::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Tue, 17 Jun
 2025 16:58:32 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 16:58:32 +0000
Message-ID: <2f590e74-4aca-4064-8226-378eed481ded@intel.com>
Date: Tue, 17 Jun 2025 09:58:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dpaa_eth: don't use fixed_phy_change_carrier
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, David Miller <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Simon Horman <horms@kernel.org>, Madalin Bucur
	<madalin.bucur@nxp.com>, Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Joakim Tjernlund
	<joakim.tjernlund@infinera.com>
References: <7eb189b3-d5fd-4be6-8517-a66671a4e4e3@gmail.com>
 <8020ee44-e7b1-4bae-ba34-b0e2a98a0fbd@intel.com>
 <c93dacff-eb7f-4552-9a1d-839b416fb500@lunn.ch>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <c93dacff-eb7f-4552-9a1d-839b416fb500@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:303:8d::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY5PR11MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8fa2bb-71fd-41f1-55a6-08ddadc02fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elNKK0JHK0d0alMvTkFDZ0ZnTEJ4NlA2VTJaUUJyd2hLckdJWDhyQmFMem1i?=
 =?utf-8?B?dnhYbFZpSXYwN2xha3luUjBnMStKRU5WcG5TMnVnUGNEMjFkeE9DamJtSzE4?=
 =?utf-8?B?RlVtUmlQNzB5d3pJN2lVQWFkL1dLcFc1RVZUSzlKdzV2b3FVMEl3TTNhWENk?=
 =?utf-8?B?ay9BcUgvSjhwZmorMlREYWxHaTFaNzBzay9oUmhHWUhQbDhxZ3pkWVRlYUVY?=
 =?utf-8?B?ZVRVSEN1NUJZN1d3RmxmQVp3M3BhVGZSKzlaY04yWGN0VmJYR2dFMWhnbFNw?=
 =?utf-8?B?SUdDY3pnR3plVStnVHlrQURNYWJrWjRDcXJvTHRvSGFVMDNmSmtEWVFLb1JF?=
 =?utf-8?B?L2FQd21CZlRVYlhxbzY2WFQvUTJEUmhQWEpYTWgvWlhEb2E5ditQOVQ5UXlo?=
 =?utf-8?B?Wm5Wc3hJcnY4Z3RZK3ViaHZQajcrdUZoSlVaakYyWmZ1WFA4cFZ2Z2FKVTZO?=
 =?utf-8?B?WkNhdDMzb1UyWjBQY1JXYWdrcjhhSDV5NzIxL2tMZVlzT0cybTBSRm9IS2kr?=
 =?utf-8?B?aDJ5VktxT0ZPMHZZbGlXUDJ2bEtrTEpIWktaeFBNL2dFYktqRmFnSWpwbDIz?=
 =?utf-8?B?Znh5TTRCdmdZKzhLTFVLR1ZEeHFxN3NoN2FPN3FHc3JHUlM3WjR0WWViNzlq?=
 =?utf-8?B?UVh1ckRGN3A3bnY5WUg3WC9ENFNxYUNjd0dRS3lBTlZNS2JuY0lFSisrNnFp?=
 =?utf-8?B?dW5laW1iUkpQaTM0THlvcHBaR2VPcVB3UWdYd3gzYjJlTkZkQlFQSG5ZbnhT?=
 =?utf-8?B?ZE1IRTc5dVdvblQ4ZXBsbmRPS3EzRVJFbDFRK2o4UmtCWVErR1FPc2MxZHpL?=
 =?utf-8?B?R1NEY2tEWjdWSVpQdWJnUVRuNERMU2FnMTYwMElRWTFXVGg2UEZRcVdHMGNm?=
 =?utf-8?B?K1czTnRtczN4WHYvd1YrM2cxdVMvZXRoV0ozdmNxR0hKWDFmWnVVMlBTYkc0?=
 =?utf-8?B?UlJDa2taOEJycjZFNkVBR2RZbHNJSDJzWG1CTWZZTDdiZml4RGQxM1ZrRHM5?=
 =?utf-8?B?U0xmOEkrcGJXUGwwdVk5dVlOUTd5TGtYdUpnQ2o4VEswc0xERUJVUnVyOWlv?=
 =?utf-8?B?Y0M0S1hTNVJMbzlsb1VXTUZvVXNiaTFpemxVLzFhKzlleVZ5VldnSFZqbDk1?=
 =?utf-8?B?dkUzNG5SK1dTV0RIMWN2azZBMUxHR1dLdW9KZnhKT0h2aUpCenVxUWlrYzM3?=
 =?utf-8?B?a0hWSjMrZVJjS3ZZVTh3Z01JVFN4K1JTNE1VV0xoYlRjdjgra0xnWk5ySzUw?=
 =?utf-8?B?eDNHT2pJVUdrRFM1enh5bHMzaFZRUEJWNUYrcUg2WWUxeG04QTZkT0Z0RFlo?=
 =?utf-8?B?RW9VbWp0WHlTMmk0cGlWSkJDNzRicXNTSGVxTzJxZlEwMmZZeTBGZ2s2SlZE?=
 =?utf-8?B?TmlLK2paUFNTdTlwWWRtbG1HRlN2Mko1VUhNYVA2K0Z3K2RRejN1bGZUMjlK?=
 =?utf-8?B?Qzl5SDc4TjkvTTVFYU1mOFMrL2twMktkMkNYcVhOakZvV1haSHJUUGs5bmY3?=
 =?utf-8?B?UUNvRGtVWHNWYVRkZlFrNzNhYXJuQ0o2M3FTZ0xiRTdvTk9KN01JK0RJYzVM?=
 =?utf-8?B?c2Y5WkdSbTFpa1hFalhOOFJDdVNBV01ZYkRNRm1KM0QrYjdYei9lL2gzOXVl?=
 =?utf-8?B?c3IrREhtNEdGYUFTT3ZTRERzdmpHNHUycVZhTk14NnJndnA5TXA2dW0wNHV3?=
 =?utf-8?B?VVBFaWh2dDVETUhBaTlGRDFQMFp4OXF4b3pnMitmWnVlam53WExyOFNUMnNo?=
 =?utf-8?B?c1JlckJNbnJSTzZvODFvRk1CNUFJQitSdU1VeGNpOWV6aW9HajV3Q0Z2ZEg2?=
 =?utf-8?B?a01KTmlkUll6WW1BK2dZZEVxaUkrOUNWV2VYUkcwTDlER1VUcS9xMEs0RjE5?=
 =?utf-8?B?ZVV2d1ZKR3NVeFhnVUwzZG85T2VINFFJUmV2Rm43ZjdRMW5xenJKTithb0M5?=
 =?utf-8?Q?Ei3GgfK1yjg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXNkYXRPZFVEMmMxaGR0aWU4YUd4N2xYSnVibnRkbURMRjAwcDFTMW1EM1VP?=
 =?utf-8?B?NTdUNEVMd01wN1gwZFlvbWtraGcrNldrK0tjbnMvaEtGNCt5WVBnc3RBWEtG?=
 =?utf-8?B?aWNYV2w1aFc1Y1pVRy94WEMrQldQOEtlVE8zSVJUZExSOFBEbnIrc21rL3Jm?=
 =?utf-8?B?eU45dXFVV0t0NTIrTzUyZmpiZzFsNFpRSjVmckpzQ2s2UzYwSzk0SVkxczlX?=
 =?utf-8?B?N2lCN2czcGd6U3J3MUV1bjNGbEt4VlY1VEZoMGhqV1JQYjhuRUZLZ0FhVWRj?=
 =?utf-8?B?QjkzTmIxQTBiQlhMWGR1R01yamplbGxtM3Z1bFliaVRsM0xZQUNuVHV4bGlu?=
 =?utf-8?B?NmxaSG4xRU5VeEtTOW5BVHFYUjdhNFA3L1ltU1N6VXAxV2dadHR4S1BkV1Vk?=
 =?utf-8?B?NHE2a3JMbnVHUjU0ZzdVT3BLTzk0TGo3T0lmTWtZZThETDFWYVdRQUVKWFhL?=
 =?utf-8?B?ZTV1Z29vd0xZd1orWUFKdjZKYkp3VXJWMUlYUU1hVGpDK0s0MXVWVHpJMWVj?=
 =?utf-8?B?U3lLQ1RmMGlrVWtvejZ3ZDhTcTYvWEEwVlNzcENBUHZjRzBIdUlwa2lxSDRI?=
 =?utf-8?B?Y2h6aktEYmdBSGsxNUNIeUNPcXNTRjE5bkdQang2dXp2WGszaEFrYjJaVVFI?=
 =?utf-8?B?U1F4VEsvZncweTJibGpQSjcxdnZsd3laQjhMNmdaQVB3a0FsanNaOU9XSUFk?=
 =?utf-8?B?ZndPa0FjR3ZTTDA4VU9wd083MjRvaTA5R2phYkZEMkV2RlQ4MUY5ZlpTV2FZ?=
 =?utf-8?B?N2xZbDVRa1VzUklXYmhqQ3ZyR0xlZHp6aXJKc2lPZnlYcS9CV21LcW8zTERs?=
 =?utf-8?B?bWw1YWJGZnhYUWF1NElSSWs5VGtYSUdTYTlWMUxIamg1NDY2N3BLVCsrdEg0?=
 =?utf-8?B?SjNaS1J3ZUlXMG5zQm0rK0JFdWs4V3RjZ0NiVHhPcWtTVTZmb2tyTXlkcEtS?=
 =?utf-8?B?Mi9vUmFiQTFJZ0VVVzFnSXc2MEs3TWNEYlV4b2dYUXFzeGlkcFoyWjNEOCt3?=
 =?utf-8?B?NS9PK2J6T0MvWHJXdkhLRmwzanNYTUV0c0pRc2xBZjRQTThYQnJ0YTFhZXVi?=
 =?utf-8?B?SDRaZnZ5ckdCMGg3TnJPMjBnOXpPVFRyTmJOZTRYWlM5NWxiTnRJK2N4T0VS?=
 =?utf-8?B?OUd1VmZTd0VIQzNEejhqOE5tNmIyWHovSTM5WmUveWJKMFhuYnlLMWhmQTBF?=
 =?utf-8?B?dENXSWNoZ1F3SXZMUE1rQ2pCWXJFdndBYzhpcElVYk0rbEJKRnRObnlaUnJo?=
 =?utf-8?B?N2Yvbnl2dEZXVmFhMGRkU1ZZcXNHS0FNQWhsYkY1dFdwOU15U1J4WERud1dw?=
 =?utf-8?B?aDh2TFcxUXBjdFhSb0ZRWElsZDZyOVBWY0thNHlqcXhBaEJZd1VxVzBQbEJJ?=
 =?utf-8?B?TTdaNU51dmpWcW1NTmNqbFNNWE9BZjlNUExHdXNmQno4ZWlCOU1qcVBCQWxV?=
 =?utf-8?B?WDFXb0JmSlZGTzhQb1ptWmRnWUF1ZmtLcmNCVzh2QktFaENGdHJuSXBtRW9s?=
 =?utf-8?B?Tm40V1ZGd09rMjBEMVJLaEZrNElKdmZzc0JTU2xvTW42NTJiK2RNcDd4ZEds?=
 =?utf-8?B?Q3NtdFYzemptelFXRERSR0hlM0pUZm1nUUJrYmRtamF1dUx2TjJmSHQvZlFD?=
 =?utf-8?B?MjdPRUFDeEdYVm1wZGdsYVV5YlhVcXk3dVpCU0FDNXV6WDNnWDRadGRrTGhk?=
 =?utf-8?B?REFOOENpaGt2KytSQ05EQlV2RGlzVzRVZ0tjS0RkTDZHNVBwbHUwNlRjbmw2?=
 =?utf-8?B?QkVQY0ZpRmFRbEVNTVdyeFdUM1hSTmdxenFkektabCtXQVRtMURFVGxoUHM0?=
 =?utf-8?B?Q3Z6Z0g4QkRCd2N2aUdxRzNzN3JaSmx6WmVubnF5RUcrUW9GVkJyOXhwTjRZ?=
 =?utf-8?B?ckJmNFBSM3pMQVhUU0tKUllBQzJ6eDRtVHQ3VHVVY1QrVXV6OGlPcytMbjNw?=
 =?utf-8?B?RGtOVkpaWHFQeEFJMzhRQzBKdFNwZWpOYWZtNmFIMnNZMVdOZlE0VXYvVHN3?=
 =?utf-8?B?YlVRZ1RhQzhRM2xIL3ZwRC90SXBvNmhHaWVTaVVrTmtVWFhOc2JEYXBmN29I?=
 =?utf-8?B?cEhuSmk1Yit5d1FxaThhRTR6a2pQQ3RDaEtJSU40N2MvNm9hYjRqbGZaSHhx?=
 =?utf-8?B?WWVTVmNhbXpYVXFseUtJdCs1b1Y4OE8vak9FSlJ3VVFjdkUyWmZ5YTREdXlG?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8fa2bb-71fd-41f1-55a6-08ddadc02fa8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 16:58:32.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuTr43eVBNRwYmivOh5vFIvHoHUi26pPS8xADHrADK0HQGw5EvjzrtbGlVj8WfXfWuiyLkqkaqqlP9BcWrf0umnnuwSO/18CQ3KzjeKHZ3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6234
X-OriginatorOrg: intel.com



On 6/16/2025 4:44 PM, Andrew Lunn wrote:
> On Mon, Jun 16, 2025 at 03:47:57PM -0700, Jacob Keller wrote:
>>
>>
>> On 6/16/2025 2:24 PM, Heiner Kallweit wrote:
>>> This effectively reverts 6e8b0ff1ba4c ("dpaa_eth: Add change_carrier()
>>> for Fixed PHYs"). Usage of fixed_phy_change_carrier() requires that
>>> fixed_phy_register() has been called before, directly or indirectly.
>>> And that's not the case in this driver.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>>
>> Is this harmful to leave set if fixed_phy_register() is not called? If
>> so then this could be net + a fixes tag instead of net-next.
> 
> It appears to be used if you echo something to
> /sys/class/net/eth42/carrier. It will return EINVAL.
> 
> The same will happen if you use do_set_proto_down() via rtnetlink.
> 
> Apart from the EINVAL returned to userspace, nothing bad will happen.
> So i don't think this needs a Fixes: tag.
> 
> 	Andrew

Thanks! Makes sense to keep it as a net-next cleanup then.

