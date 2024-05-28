Return-Path: <netdev+bounces-98447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37B08D174B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67BE1C21CD1
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B871169384;
	Tue, 28 May 2024 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnyJ8Oby"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A936E611;
	Tue, 28 May 2024 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888807; cv=fail; b=k1E+4YwVp3jxEkVhQ5ACEwfAlA8zpvZwGMvWfPiCs+Zq6KDkqmZj3dgtrsXox2oEcFsFs6sHhCAV3aOK0Q/G6XPnMQSvUOTrAFwTnsIaLtTIz8CVweCwO3sCRX7DQQqKwnkt6aJ6iw+0TxKeZCoibXmNqHbsHMqXa6c3LlbJ/k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888807; c=relaxed/simple;
	bh=3PLPRj1ud6bVEZvuwSQvFsHUeFwCZq6nWpPCe+j+y3M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iYhXfCFFB5Mnaild5x79I/4XSGRx8eE3rIoz4pRTfzODq3FKdN0qhecQcal+bR8NxGdEcw4F7aQh8ZzrWr+AUVyvde0nJZoZdigf01jHzN+a4/yG7etTIo76GrCRNA8HNIzyAIAVnXsNKa8t2p+RFG9ECrbsaZVKv/eBH5V6CQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SnyJ8Oby; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716888805; x=1748424805;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3PLPRj1ud6bVEZvuwSQvFsHUeFwCZq6nWpPCe+j+y3M=;
  b=SnyJ8ObydUnY95P4yXxTxaNjrkptNSr9w2q1wjm6FllxoEkVnAl7h1Ay
   iTlWk2z/7egdT4WpA3Ce14xyAt6jb35MHLFfmUkyL106iSc+XKzL/sdRc
   JmJbjbJTZ4anxkhY/G7g+e0WfVqPbCPpLH2VIvP6XpFAPhIwD+pWCUu93
   XNu3HVXqpW9qs7MDc5OhSGDGaJF1poFTOhmg+cqjnaiw6fgjA1lM2HzAb
   RmuM0DyEFOBUBBjYOlsT9Xaf9XqEhqWajtI2yvaSWCItr+Jajc805uqyA
   V31eNK+5hDzDx2TDkEJo01at597YkMm/3aeW9aHSP8CRN5FKTSXgjD3VM
   g==;
X-CSE-ConnectionGUID: 3pwtkC+ESEmh/iN1ZQ/3OQ==
X-CSE-MsgGUID: +xXs/6VmSKyerSfHCRNd/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13047517"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13047517"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:33:24 -0700
X-CSE-ConnectionGUID: sCA0t7gURLytEJX0UWIofw==
X-CSE-MsgGUID: iA5y+G9lSl6uk0+1x23DiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="35494987"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 02:33:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 02:33:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 02:33:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 02:33:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4HGBh2ZP9GJbn+xRbZJjKnwtQcdGJ2g2QrhJzeDJrpxt0aKpuRUEO1TPlkaci+++M/82Je1ZVOytWQJ+gWgE1K+UZloxipMstKTIpp4ZFP/OSPO52PZHGfmshxdAEWBVgABuZ6QhAMcg5N1bQPyjHnqwcOxmKiW5mR7s8L1VUg59v3ohCnixjgRQ3M8QPlrSSnB7j4M1pyhhcR2T26vqhKpYBJ0pslHBVWO7nL+zCJwusYH1h4RmwGoGGNAa7P3E1IIxxUi78qSUp7rQObLiiKtkFnqof1znqFCjGUF0BtHfme+K4r1eS7v+LAhzi32epLb3xX3VT7eO9ciXH4fLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpF5zJGkQV6ODqfZsBkKHuqx3Vtzv1Y8TLgeNL5ocis=;
 b=WKrcHeE/ocTnsRD7TA3n8Ny+SmIdZJB3SW5ydP2rJ6XhdF3DIBm84PqIe9ynusA7VEBOGbLYJoxyVF6Jr391IvJ7WIW0XkEWVs4ZpH0tgLjrn7NHvqUAj3UwjbOR0Ovui79DqbzWitmvtqVAb+AQixFINGF+qHlCIN35ovaPA1ons7umkK8C0UGPMXoilVdE+2EQZisK1ioX+0VAjBHk8SX/NXgTWfHuxtECLMNDh1t/3n5fL9fpcv4MZ8280Q2SjYzfj6eTS1Y7MgOMRb+FOB5BjqJ0+LmZJFK/nJG80t5R0WGb824HCCUuuvpim+vvqItIXKsYqaGWgGd4TQJ0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CYXPR11MB8731.namprd11.prod.outlook.com (2603:10b6:930:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 09:33:20 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 09:33:20 +0000
Message-ID: <d104a345-7df1-4fce-a9d4-05f539fc9160@intel.com>
Date: Tue, 28 May 2024 11:33:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: phy: xilinx-gmii2rgmii: Adopt clock
 support
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>, <git@amd.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <harini.katakam@amd.com>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <michal.simek@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240528062008.1594657-1-vineeth.karumanchi@amd.com>
 <20240528062008.1594657-3-vineeth.karumanchi@amd.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240528062008.1594657-3-vineeth.karumanchi@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0069.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::46) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CYXPR11MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ee7638-b402-4226-432e-08dc7ef935f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2grYVpybHFEclNmWDZWM2N6QkV4UmdyN05xVmJRWFB6aUMvRkpPeUhraHBZ?=
 =?utf-8?B?NzBOWC8xUVR5ck14TnNhd01ja05FUVo4V29pNG16OVN3V3BkUkNXK1IycEd1?=
 =?utf-8?B?Q1k0K29tSjc2L0s5dW5EWVVNd1ZWTWo0RktudEhReHRuRFBaaEl3cDBpc0Zt?=
 =?utf-8?B?Z3lKS3ZqRFY1VUh3S0pKOGlkWHhvVXc2c0dUZG5xRVZPUElqbHlMZ2k0enp4?=
 =?utf-8?B?bEtrT05qWWM0MFVBQm1iZkZvai80RHgvMjJuOWdqS3dKUFE0Mk9HNjd3Sjls?=
 =?utf-8?B?eW1LYjhoMlBPaDRHTlFrcVNoQlJvSXZuR1FnbkNuTEdxQnJVeTBmZk1vNFBq?=
 =?utf-8?B?d0loQmRsSGZ6cjdLbitEK1VrL3QwTllNTmRLOVUzNjZBbnVqQ0RVVnZUTXJx?=
 =?utf-8?B?ZUIyNEJ3ZTN3WjZxb1Y0eG1xc00wRmlKeGFMWUcvaHc4NHg2bVZuRFFNMkxj?=
 =?utf-8?B?OVk0N1c3Wi93MEFiQ0xNNzBFZFFiQ3JvV0hyVDk3MStQQU9ZV3hra0JsQUpZ?=
 =?utf-8?B?ZlBKZERzZk1vdWt1RFptRTIzaUFiZ2F1d3pHMXl1ZkN2Nk5qRG9mcFJYeC9m?=
 =?utf-8?B?OU81Q01PK1hQZUhxaXBiZ2VQNWRVdlRsMWQ4NHpjS0hNczVKZE1WK2duN2xO?=
 =?utf-8?B?RWdlMjdMYnRXZ2xRemFQYndaN3A3ZHhMbmtPSUdqdXMxd1pnTHNGSVlSQW96?=
 =?utf-8?B?eTgzY0VhSlJnT0w5YUZURlBSK1BwejFjcEVlaWVGRFdHaklhL2J4WWExc0hX?=
 =?utf-8?B?SE8zZG15Q1FIaE55WklwNENxd1p0dTMxZlJKS0JkK05XVXFneTB0QjNCRXRJ?=
 =?utf-8?B?NitESk9CNEV5K1RuZGlPdzdWeitYZ2NUTXh4K3JtTmgwR253OVRjZ3R1UEM3?=
 =?utf-8?B?bGRrUHpKMkxsa1UwcW1MZVR5UU5lcEhQd2xIVzI3aXhvZnhIRnF3TThEZFVi?=
 =?utf-8?B?eDkzSGgwa3ZhSklJZDRhK0JrNmthSktKcG42MnRVNVlZTGl5L1BBMVU3eHBM?=
 =?utf-8?B?dzZkUmJwbzc1Z0tTRjRWamt6S25MM2RrMXplNlN6Mlg4WGNhSlR0VGJidjNs?=
 =?utf-8?B?R3BHK3hsb21zUWtPU2pDaWtmMzNtWnJJUVI2WjJ6dkduWXJaeHZIbHRHVW1m?=
 =?utf-8?B?QmhFUVl6aXJrOWt3ZS9pNWhMWm0xYzg0K1FUUVBlNmdDQ1NnVU5Ud2VUN2hp?=
 =?utf-8?B?SFdrelBPemFrU0xrZzU5NWdjMkxXMkRIeTVQcXQ5VGJGdHhTdlZPSmZ2MFdi?=
 =?utf-8?B?QysxYW1FTUJLR3MxT3cxTFJXOERodlFUQkdBUHhhYWs2NkN0Y0VoazZRV01s?=
 =?utf-8?B?QzhScy9aNDZESHJIUXhTYWFQeUZEOE1VYjVUWEFUU0h5bnRwaDBUNWJvd0cz?=
 =?utf-8?B?OVBBN2NmQ3hNRnU4STBoVXhRV0haL2phTitETkUzMGlIMDhRN2pISm9SaDhK?=
 =?utf-8?B?SmtSU0dLNlloamN6MGJVYVJvU2ZFOGNTMFk1QmExZlE4UUlIZWUwcXE5YzFx?=
 =?utf-8?B?dHVPMTZpb0N4dXo0bHRrK0FsZ0pIYnNwWHZJVFFVbXliMTVVRW1hdnQxYzh2?=
 =?utf-8?B?cStjTGhpcWhtV2pBMzRLQ3JFMHFJNE9QNWc1R1JrNk4xV1gvVFV5VU9NUzJL?=
 =?utf-8?B?Znh3eFdnckluYlVxeXduT1hGRGkwVzVuRmZmc2VVVzJJd0lPMkNmVko1WFAz?=
 =?utf-8?B?emFRdkQ4YnI5Wk5pNjU5RWI4ek9Ha0dxd0ZvWFI5SzFGejBVd1prTnZnOVMw?=
 =?utf-8?Q?su6VpL3ryJX0eKNopQiosIXUxfEtJS3M+j/AVaT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNiV2FQaTZpdVpMOEg5OUJlSjdKRnVTTGFwbjNiejhya1VVUnBHR1ZIYWQ1?=
 =?utf-8?B?SklLQkZJQ2lhVEgrbFZSRmNBNnkwdU1DeTkwQjhtaW40L0ZRUVFrbzROZEF1?=
 =?utf-8?B?TUs2dUhlTVpBRklLRXIrRW1yTkU2bWlaVk42VDV1QVlzVFB1bEZSMlkzdjJ5?=
 =?utf-8?B?RlplR1FGZTB0ZllhMEV3VnNMbFJFejZrOXFYNEhMd05JM2tzU0FaMXdFK3Zq?=
 =?utf-8?B?ZFM4OEtQUGZXOC9BSm13SmJTYWJsY1loeEduLzFyR3JlYWc3cUZzdSszL2cw?=
 =?utf-8?B?ektBWHU3V0ZSSW5MSGhiUWFMaFRqSHVOUWZpdlkxelM4dlFmWTBCVytCS2FV?=
 =?utf-8?B?RGxkRmZOVnRkK0RVRWtOcVk4blBiTU8xVnozYUlyTkZOSXhCVGk4cW1mUlAy?=
 =?utf-8?B?akZIT3kwTHY4YU1OYkFDMjJ6OWN1dHJZeUNZbnZ1RDNLNjRtUUdWenhySC9R?=
 =?utf-8?B?S0ZzRkhkcVdlbndzODdnTlNUYlg0aHhqeVhmRDZCVHVjbDVHYmVqOGd2Wjgw?=
 =?utf-8?B?ZjV3NU9iMGJ5eGMya045bjQ5b2NSUFVJcXBYZUN2eTBsT0gxTGhmZzVDbCtC?=
 =?utf-8?B?eS80MjJoWjRzSm8vN0VxQ213a1VYcExQUlRFUmlucDhQM1NyTFFrY3lUQVYv?=
 =?utf-8?B?ZnhxUDRNRmVGQ1ZiUGFuVmpQOHdWWkZCVTNwVlg1MkVnTEtidll3VjFOclpx?=
 =?utf-8?B?d3oxdk1EQ3VzUVhtL0VJM20yNkRvMDlqUFZ0U2dWckZ5NkNSbDE3cm5MQWUz?=
 =?utf-8?B?Rmp2dis3bmZ1U0hXUExoYmFiREx6WnE1K0dKRlZ6R3FKbDNBSG1tVTZON1pE?=
 =?utf-8?B?NUFUSDUzeUZlWER0R29FN0tIVTJBTVBGMU1qcHJJK01Ma0liTlBSKzRUWG5B?=
 =?utf-8?B?K2xEOUtnT0p6L3BVTFVxS1BNTnlFN0dVUm9Ga2xkQ0FSR2xENXZvS2Q5WnFq?=
 =?utf-8?B?SzMwNlZpYXZoejVVWXpQRndhWUVWbkcwMExTSkN0dmRreHBMQysyWEJHSUox?=
 =?utf-8?B?dlNmR3lZalFQQUxEallLVlI3R2V2TXRreUowcWlzczlnV1BZS2F6SFZEajVC?=
 =?utf-8?B?Nk53V01pa1U2Q2ROSTJpL0NsOWtPbGFnQTlCQk5JVTZrTDJtMk5nc25rYk9N?=
 =?utf-8?B?KzU0OGlQUUV2c0laK3BaS2c0Rm1xWVRHc1JZY0tKbEF6VU9weEdoOHB0TU1N?=
 =?utf-8?B?UGdtN0N2WUp3SmxldFkrU1ZTUkp1amNOU0hsUDJzVE14WWNFSHNYNlB1NXJ0?=
 =?utf-8?B?enZBSGk1TmRpZ1VGemo1NE5oMHh5UXcxUkduMWluM0V3RnVyYVI1cm85aWhm?=
 =?utf-8?B?VEFMMkpXTWRxN3ZGejMxa0ptc2EwYzYrb0x3czlwV1BUQmREWlJSY3N3cGdh?=
 =?utf-8?B?cW1uNTVhcHBBZ3RGNkI0ck1OWlkwMGdZVkZuZEFzaTd2Nlh3emhKRGJqSDJ2?=
 =?utf-8?B?TFhUeFBOR3huRVVUb2RYRjRPdHE2azM4OVFGZ3dTQnBoSmlVeFhGeHdDREtx?=
 =?utf-8?B?Y2haZTlPTHdHWEZwbDBNOTdWZ2wya3lReStKdGpKckU4MGVmdDZUZWJqdk1h?=
 =?utf-8?B?MDNDTWduSzIvWFIyUkU4Z3ZIWnFpcEJIeTZlY2hOc0l5c2V0TnFBa2J2czNB?=
 =?utf-8?B?WENpQzF1MG9jSjBkb2pGVU1lSi9DY0tEdkFJSkFaTG96ZDlJN05YMUFrVVRu?=
 =?utf-8?B?UmVvcVNZTTJqQ1ZOZ3ZIRE9jRE1RR09RNlp5eFcwYUdmMGxhUnBxcmQyTEdu?=
 =?utf-8?B?MzlKZGlmaWtYSWNtR1FEdmNSSnYwbHhhQi94VVRKUEFCTzNPaG5tYXYxMWd6?=
 =?utf-8?B?bnA2aklUZG16NmdoZFNCZ2RxSTdwakdCUVZVNXhkZ1ZyVlZCenZhaFRIT0RD?=
 =?utf-8?B?ZEk5YmFnaU5VQ2pCeGNoUVV1NjBaWVVvcG1nS2dIbmYxMG8zMG5TbVJ0U2xH?=
 =?utf-8?B?Z29wUEhINUN2SEkzM2cyaUhtVXFnd0NrbE9VNmVwa3lBbVNRMnprS2t6bWtt?=
 =?utf-8?B?elBhbHZtMjlkbkRkejBiYmhpL1FWS25kOElTRHNDZkNmaFA1cUprRGFLQ2l0?=
 =?utf-8?B?dVlORG5oS0pPRGtzYjhOTVFLNEtDMkswQkF0cjZTS3hEVUVXNDI3a09TRHBD?=
 =?utf-8?B?VUFGeExrSVl2WjhrY0pjNktiSnJmY1ZUT3RGYWM0UVM1NjVnY29XdlFtbHRL?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ee7638-b402-4226-432e-08dc7ef935f9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 09:33:19.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLk0pJ4glgc4pkiCOnYtFMDAsPu7qgN2hS9mrisxMTJs4djcFVFmu9YZRQD3J8RMsAnZKdkzc5bD05dvthHdknTcHU2K9kETaMO6Tj0HU+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8731
X-OriginatorOrg: intel.com



On 28.05.2024 08:20, Vineeth Karumanchi wrote:
> Add clock support to the gmii_to_rgmii IP.
> Make clk optional to keep DTB backward compatibility.
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/phy/xilinx_gmii2rgmii.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> index 7b1bc5fcef9b..7c51daecf18e 100644
> --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> @@ -15,6 +15,7 @@
>  #include <linux/mii.h>
>  #include <linux/mdio.h>
>  #include <linux/phy.h>
> +#include <linux/clk.h>
>  #include <linux/of_mdio.h>
>  
>  #define XILINX_GMII2RGMII_REG		0x10
> @@ -85,11 +86,17 @@ static int xgmiitorgmii_probe(struct mdio_device *mdiodev)
>  	struct device *dev = &mdiodev->dev;
>  	struct device_node *np = dev->of_node, *phy_node;
>  	struct gmii2rgmii *priv;
> +	struct clk *clkin;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	clkin = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(clkin))
> +		return dev_err_probe(dev, PTR_ERR(clkin),
> +					"Failed to get and enable clock from Device Tree\n");
> +
>  	phy_node = of_parse_phandle(np, "phy-handle", 0);
>  	if (!phy_node) {
>  		dev_err(dev, "Couldn't parse phy-handle\n");

