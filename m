Return-Path: <netdev+bounces-65176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611E6839713
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1731B1F26663
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765C1664C4;
	Tue, 23 Jan 2024 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myYSkVnI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DA6612FA
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032663; cv=fail; b=BpTP47V5AZuJPrxm1pllU/Vsp2v6FNti4HK2tCgWrZTxpgR5OwK+l5yiSeHwPETYuaffScEnD4BqIqb5JmLEc8Epqc99E13bSOzy8ZlGBT+ztubd6J6IvTbhbZ7PCZVhoUJJ8jMTkz15J3r+w5M7fPV5U6b2qKjxXF63VEAAO8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032663; c=relaxed/simple;
	bh=O4G9nDnhzqGyFO9YPQheJy1NRVV7CGkxR4tQKFfA8bI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kqdljUDX/K7hz1LI36VL7lkPRCijMIevAHXraFNv2wtv6/AibGo0aANF3XP8f0WBw9vUBMIzYA/nosADq4aQDiRUCTng96Mxrts7wbFODQNPwgSPjIbhYyYd6WyMkqkXrjo0BIr6NV+HKhC+0QFkm7H6hCxxw020aTcn6CES/N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myYSkVnI; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706032661; x=1737568661;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O4G9nDnhzqGyFO9YPQheJy1NRVV7CGkxR4tQKFfA8bI=;
  b=myYSkVnI6zCeO2LQy2UngXLqttb2Asf6x2MSElWHiXWjxfonLd/ceiWr
   WKKeB6w4BT8d22o1MnDXnKAG9TZrhctz6qJBqAUep3fCd0xwifQ/90OzN
   wiv884tdrAFUvkozWkm3JUNQ2JluKFoUpbu4uMTth9/mfj5lh3RJXqeZc
   5vXUg6HOIMEuWJPM4AevM/JFt/qFweeXbOz7s6O1GTnJ2IfirXkwLRgHm
   hcguGIvMSCLIdSqnzkxz4TMe5UF0zml7Ia/2s7WmlxuGTHXYYve+unDfK
   Lr3rywJSPBePQ+lkk3YF9eOT3RUHyxZV/LCnuc1em9fbKcEyaGTDLmuCe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="392022080"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="392022080"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 09:57:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="959229743"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="959229743"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2024 09:57:39 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 09:57:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 09:57:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 09:57:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVKqE7O31wcRttZCnLzwq5b6YNQa/fc9Zo/0mpiVl+whKQj/u/DLmbkNdu+Ci9HnVeiKkcrNCP//o1gF0XHTPe57Y5/1qHx7wWkx0rOsavDrI5fCUvGDdiVKuuszxllicYPUt4a8Ih7RtaVMuUR7YSRqUkvQd+cpN5Mp2Ivu8C66MscM07rrIZn30dLbcKVkWDovPgoKXtZ6XmrVO+Rn5zWn+c74nwV6QSFPO9LFpmsdi8qwiTE9rYSiCsf+7LidxjEv0gU7mkrZB1DpYXQdoRCfSRQSbM2Y1agX+kgpoArclxgtoDEOG/oQPiOa7l5ArwsbqGBgS08mHU01N4CZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auh27OZJv7HyQ3Z6lKUsozdC7MhRCflLkSoH7z0Eycw=;
 b=U8sRg3c9nT/rlvegY4hodwec76H2YGr73lvUxtMuo+UV/HXqmh9DNJu2nDBDkIkYO7GFh4cl602TedblE1oEAxLXP0gkTG2Y/npUJ0jsy2zvhyLOlBwiETcYkliMFwaYqBU4TTDIHcvgCPCewv9Qbu9lqvYG7mxPPt0XOhG7Yhbl1M7GGyvgqoz/DtoWFlN84/X5NysK0Wp0FGWGOi6keFR+NAF+QjX+QNK91tFTI5If3P/ijZFPMJRll67RgDcEJrjCUjSuGFDnF06Q0nAqrF8JF0z9YqZ1LU9aEx5M8rkkZqDB0CDqMn9P8nVnyIzO5/QA3pAwuzbrrQ15O9nftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8431.namprd11.prod.outlook.com (2603:10b6:930:c7::17)
 by DM8PR11MB5606.namprd11.prod.outlook.com (2603:10b6:8:3c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 17:57:30 +0000
Received: from CYYPR11MB8431.namprd11.prod.outlook.com
 ([fe80::420a:4281:678b:88a7]) by CYYPR11MB8431.namprd11.prod.outlook.com
 ([fe80::420a:4281:678b:88a7%6]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 17:57:30 +0000
Message-ID: <f4c9a583-4f66-452d-a4b0-0beec14ac591@intel.com>
Date: Tue, 23 Jan 2024 09:57:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] idpf: avoid compiler padding in virtchnl2_ptype
 struct
To: David Laight <David.Laight@ACULAB.COM>, 'Tony Nguyen'
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "willemb@google.com" <willemb@google.com>, kernel test robot
	<lkp@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, Simon Horman <horms@kernel.org>, Krishneil Singh
	<krishneil.k.singh@intel.com>
References: <20240122175202.512762-1-anthony.l.nguyen@intel.com>
 <87cb8a4405724ccb9a00cd23dd07915c@AcuMS.aculab.com>
Content-Language: en-US
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
In-Reply-To: <87cb8a4405724ccb9a00cd23dd07915c@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:303:dc::16) To CYYPR11MB8431.namprd11.prod.outlook.com
 (2603:10b6:930:c7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8431:EE_|DM8PR11MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c1cb00-dc3e-4ec6-4a29-08dc1c3cc4b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ednBQi0lhkE0qC3Q0R2DveRXVM95tSIXP2Nmv4I/qfAudAOkIC7ZE4oDQPwPW1+enxTn1lqPRnncYv/lp17dvXOCDJqE3OnGJFL3FnbuZnrVj4at+9HZRr8GggaAukKW/drV/2zhwqDXQBgg+nZunZXFLxS7TvFwV4CbZWfhP6+qj/J6KO7lw7vxvRhhkZBl8FrODrTZbLv3m3xLsU463mzH2fciOay04RDZuGI3ezkI/5xZkbYVvTQYLd9snx4FV5jE33L2medFHdQM6SFaxZ7xwMIfrLkHfObQcD5xD1DIquc4CBYNDnL7V/bVOWfAP1tk/eGdZ3ck0FTP+5lC0hj8R6KGabZ9PPB++4Ek/WyG4r5pAJhne1i2OMmooyAMnUOTkNJpU7aX1zjEi3sIT/fxluVp6xrHlEHFwX3nrDNVc1VYDuaCipFe0Atsmvepv7c3RcNtEZZSgsqY9QVLMAofbqxBZreEhutcalh92HgKIFX85/rjLZOY5XtnhMZr2Z+GTmPKTyATgEA++/rR3sktBC4b6skTCnV7huMt9G2wTdtfguRQeKHCIImxLvIjSbvEPUnsb4LcnCPYWvomDuRXfQYBEOPJAIN7L3rdlR/DEWaLD3hhAnhu2QSDp+aJM75e9CQiEilp0LPHnlq7pyTlbroW0M+Jr8dCM7S5sZC9RXkgnYb8XpPJNy5UTREJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8431.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(31686004)(41300700001)(8936002)(2906002)(8676002)(5660300002)(54906003)(316002)(110136005)(66476007)(66946007)(66556008)(478600001)(6486002)(53546011)(26005)(6506007)(6512007)(2616005)(4326008)(36756003)(83380400001)(38100700002)(31696002)(86362001)(107886003)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlF1M0U5Um9wNzRCK1VGeTFJQTJ3WDhuUlZUSGV3ZTdoaXB3bFY0YmVOT2NW?=
 =?utf-8?B?Mk1hcW1aZEQwY0lpTk1qNlFlT1ZMYnZQTHpLaDFScU9MUENMVmYxaG9LMVdl?=
 =?utf-8?B?Vmd4T25lZzY2bnU1MG1FVzdBbEN1cmQvRDdnTTB6eThLN002QlpMVUMxeGRk?=
 =?utf-8?B?T2dGL0RlWUhWbVNKTjM2dzcvcERtY2luR1JKNTRJT2FaK3cxV2cyWWp2TlQ5?=
 =?utf-8?B?MWVEQitoc2VPSWJ1a3orNEFSQmNlYkZBUURTQkFXLy9lL1FoVmZzdmtJUk9o?=
 =?utf-8?B?SGVJYU9QRTg0WGlKUHlOcHRIM1dtVnc0RUZESWJqZXlnZFNXWjRMUlhseGxT?=
 =?utf-8?B?dmVEaDRVT2JvWCs3YXdXWGZqVzlvcnVsZFFkVEVaQnlSR0ljWkFUNTY1aW03?=
 =?utf-8?B?bEFRbFlGNytGRmd1WE5XUlM0aVFrdHNrMWdmelEweXk3Uyt2SFVzdENnanZU?=
 =?utf-8?B?cThlK2VubGRKWWVsalliTndUdDl4SHRwMzJ4YXphRWl6Z1FOQzdpTVNHMEl1?=
 =?utf-8?B?bnJEQ3pIb0c0YmFYM2srZjVVVndWS1h6MlFWZ2l5bVdzQldZR1RsMm9ldHVJ?=
 =?utf-8?B?SklxbldtZlZMRmJlc3pKdGZLT0w0NFFsVzZNTmFEMVdmU2ZTVnNJS2VOcExx?=
 =?utf-8?B?Sk4rZ052MlFtL3BIZmFrMlg4UVd2TUQ5ajhTdk12ZmJCMFpvYmZYbERYRFBR?=
 =?utf-8?B?N1E0N2NSOEVrclNFQzJGZ1ZBNktIcG1uT2U2RFhvVEhVU3c0UlVhSm1YZ21Q?=
 =?utf-8?B?TnM2SytNUThkK1ordi9RM0IxQWR1ZTUwVmxNa3ZGY250Y2F4cFFTbnU2My9N?=
 =?utf-8?B?L1NlZlJMOEpGNzlORXUzd3IrT2xnaWZHOExZUkR4dS96a3VYYk55YmhVU01C?=
 =?utf-8?B?bEh4bmdQZlRjWksyMVdnRlpaa2ZtbVNZMFZKQXJtTTJXNzZxSDVtREhOL3N6?=
 =?utf-8?B?S3NWaFFkTll2b1BCQ05GZUhsS0crY0wvdkRSWURoY1pqNzRrd1dZVTBQd2Z2?=
 =?utf-8?B?VGV6YXhraVZxRms2UWZ1b01xVS9VODhiNllVYlFNaXZlVmROMzBLNDI1MTJO?=
 =?utf-8?B?T3l3UElBOEVMdXhZSU9CcnN4ZFlzWnByY0NMNXVwa0w2ZktnWHVIOFZTQUp3?=
 =?utf-8?B?T3htUk5BREM0U2VNdUtYTm9QN1MvWmFZYzVOZWhDdHU4ZFNEZzUwdkxyUCtX?=
 =?utf-8?B?cmh5b3ZHSnYyVUlINSs2cDgxT0lDYWxsb1E2L1R2dHRXMnB6VW5uRHZyRmI5?=
 =?utf-8?B?RG5QNkMzWktiYzYwNmR4WWt2b2MrT08wT3hITFAvWk5EcWp3eFlkckdtUWN2?=
 =?utf-8?B?cHhXVzFPMXpsQk5jNnNYTXgxV0xyajU5SnExTWFScXNaeEJxbUxkWUxNMlE4?=
 =?utf-8?B?SmhWb1NqUlAxS2NoRlQwYmRSMHZ0RjBvWnNoSWY3RUxHZFVlOWdqME85L1ly?=
 =?utf-8?B?aVFLZXdTbUVhajU5N3EyUGlMRWtqaWFleWRLemdBVHVsL2tLUUQwcVZldklG?=
 =?utf-8?B?TVExaENUU1R2Qm92bFpiM1RPMkczaXl6Y3Y1YVBHMWJsSHpPcHhzT3pMTlRG?=
 =?utf-8?B?SFNXT0QyZTZxRy9IOFAvZENaQUhCZDNKeDVNcWVBK3RzZi9iRDlpSWYwWHpx?=
 =?utf-8?B?OHVKRVorNXJZcGdOZlFGVjdDT21rOThVeklJLzRaRW43YjNzaW0zb0FsQXJm?=
 =?utf-8?B?a2xSVUpLejZXRFBLMEZySGFvK2RIR0FyaVE1cjMzMWxUcjJ0a2dxOTVLOXVP?=
 =?utf-8?B?RTU2WUtUbWcwV1BwT3pDVkhvU2dUY3lXVmhaUzJPNFBLeDFsWm05aXpLNHdk?=
 =?utf-8?B?WUoxOFMvaVd5NFd3MmgxWTFQTXNzNkQzTkFMdmpxcnNYVlErOThvL2NvZXdX?=
 =?utf-8?B?YmNvZXYzc3h5S2R5aFV0NENoU0tRaGd3azBvUG0xSXNIeEoyNTBtakpEMkJk?=
 =?utf-8?B?dFJXNlVyc3c5QVU3MUZFUk9RVXR6Q3dLZXRHK3dtNnpSd2l0MlVkTlR2SGRS?=
 =?utf-8?B?L1pqbkhBc1paQXpVaFd6ZWtxVEpTbFp5U3F5WE5yRXJFUkxwKzNyVWJYS1gv?=
 =?utf-8?B?eHFaN3N6eDZWcU1MVHZVNzJKNHlPOEEyWFNyaXBCZGN1clJEaUtLZlJSelZH?=
 =?utf-8?B?UkQ5SFRLZm56TFczb0NoZ3lCRzFoLzVieC9RUS9CYzVHVDg1blRuR2ozaGhl?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c1cb00-dc3e-4ec6-4a29-08dc1c3cc4b5
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8431.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 17:57:30.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7n1SqWi9LUxKKnTpOyq5sNHs/V+9P9PyLR5pG2ud3drJO30Uf4Vzlxhla0EsRHTx2MmKSlSixJeU6HZIitoY+gU4o/oOWj3YilFXTeCfJ+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5606
X-OriginatorOrg: intel.com



On 1/22/2024 3:01 PM, David Laight wrote:
> From: Tony Nguyen
>> Sent: 22 January 2024 17:52
>>
>> In the arm random config file, kconfig option 'CONFIG_AEABI' is
>> disabled which results in adding the compiler flag '-mabi=apcs-gnu'.
> 
> Isn't the arm EABI pretty much the only value used for the last
> 15 years at least?
> Doesn't it also change the size of enums?
> 
> So perhaps it shouldn't be possible to unset it?
> 

Thanks for the review. The following is the only warning reported by the 
LKP with the random config file and I am not sure why this option was 
not set. When I set CONFIG_AEABI, the compiler flag changed to 
'mabi=aapcs-linux' and this issue was not seen.


>> This causes the compiler to add padding in virtchnl2_ptype
>> structure to align it to 8 bytes, resulting in the following
>> size check failure:
>>
>> include/linux/build_bug.h:78:41: error: static assertion failed: "(6) == sizeof(struct
>> virtchnl2_ptype)"
> 
> And turn that conditional the correct way around...
> 

Sure, will do that.

Thanks,
Pavan

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

