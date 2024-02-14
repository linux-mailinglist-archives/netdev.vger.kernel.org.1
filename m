Return-Path: <netdev+bounces-71858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A692855599
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 23:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54511282367
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD3D141989;
	Wed, 14 Feb 2024 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQJaNPCC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F51141986
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 22:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948886; cv=fail; b=DDPuMh4D6OLOQ6ADr52VcpGtt9Wlm20/e5/gonPg0cOCY2+qqM3q2+x7EBnt5ssySxlLVzCm45bNaneQY/lRPReY2afGe273p5RURCe0DtuAcgOgkRIdSE56/PK055Qlzk8zK0z9ugjTUEHPI+pswz0jaXgPKFvhZCwc3w32K/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948886; c=relaxed/simple;
	bh=fDOIP/AEh/NM19NPXcgPXHit3GqVjoASVg5UA3NJrNM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uczruOkIG4CoU++5hLZvDgKpFizSW6Dm218+R1Oa249lXoBFqFAfBGScmfkpPJWEc24fIov5KbRNI6T07usYPfyR78yXb07V1Y4rmWXi3+E9AWaciX6+nHUkAHoVrP/YpXfgBxaGd6l3ozSi+LnT3nodFY7Ou3UtgfAhekJe0jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQJaNPCC; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707948885; x=1739484885;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fDOIP/AEh/NM19NPXcgPXHit3GqVjoASVg5UA3NJrNM=;
  b=aQJaNPCCrPlMEVJAuTOIleJGa7tWm55W5u9kAIvhUS62sIpE3mNOKfeh
   KllCY0IeMaHsiAvil7BpUPE3ZV24isk5vvs6alW/Nv39mWplvs2bPOakv
   bqxgakC1P/FHJplOROIbCvbaAesPgxUPUJlj6kcCkl2g7Q5XGKR2CD2vo
   OgOBK3S7T2WV4i6bd2EzIHiMzKBo95PZwRSXECe1yvyrq81emkAnYsRe2
   zx7jLAq1U0PPR1isq/yRgjw5mCjK26TPRy4yfSag8c9jXM8gngwPG5XTl
   uaJ9HizlBFV/NEcRTlT64ASA4O0OjOLzSR1fVP1QZCwU1uu5MKVKUAFYB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="27469569"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="27469569"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 14:14:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="34145716"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 14:14:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:14:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:14:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 14:14:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 14:14:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLvtaK0p61EruAp54PKEx30x1/7t1lTNT08sjFg3yyjE+/mcDQ5NjUP/UnR3xg0VhGNGL22xbDkMz6r0KpNgbdWlZ2M5axttCvHob0YwX+a8bYPL8AaueWID6qIEFucLubqx5sLCVA/rXs+bZHtep+oXVS22rhwVqI3FdOcn+6SIxaPPV8puipzz2j2t4NJoHwyqc4+NcG6Qh6S8Hku3emam0kN4GdL1a+l6ixCmYuExEeZOG/BKMMaMIiEEeDeO9Z6IN3iOvvdTFtbq8bKBhi6nzYUC0F6S6PgXaWojZQit6qJrqByr9I5svtc8zb7iBJtzUCENGE612Lzao4rFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BusD4BfuqFlsdmVupriwGSSs4vkpmXLy7BpRllUiOgs=;
 b=kgVtPxSjWjSWeEYnhcCpAq4x6ygvdEPs8pUewZTbB8oI7IImFjSReJwXNkyoVlHlE1fzvashigbcty0KeD7fqveo8btFh+dsgrK/0dFeXYK1B4qT0XoGQ222NzBA4iFM9+Zp9fGIGMq/ukpvXKpcHbJkYxzbeSIUEn3AGfjJzWLROni6MmaiXjMfICNkAs6ugHJbQ4v+mkv8VMMDJ4NFQ8cG83SrK/VP7CRrqZmNBE4ILAJed0YJWz6X3V1PtM48W1iVIH+zkDqt/IMjoVI9bNbB6SjmPm6t0ubZj63DV9Nb9M6ngJ/8YW1bmW1h9jj8q25hdg8JuB8LUo75/iSIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7242.namprd11.prod.outlook.com (2603:10b6:930:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Wed, 14 Feb
 2024 22:14:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 22:14:40 +0000
Message-ID: <5241c334-edba-4109-b518-e0a5ae377dc5@intel.com>
Date: Wed, 14 Feb 2024 14:14:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 4/5] amd-xgbe: Add XGBE_XPCS_ACCESS_V3 support
 to xgbe_pci_probe()
Content-Language: en-US
To: Raju Rangoju <Raju.Rangoju@amd.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>
References: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
 <20240214154842.3577628-5-Raju.Rangoju@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240214154842.3577628-5-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:907::33)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0ffb0c-4c62-4860-113f-08dc2daa5709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9R7ew3eWhnzpudX2aUPeBpTlwO5ldTYoyumED3gnAWEHh9wNF0B9F31TKOeJ+sM4XGBbHACSa3nD8e/oe60ZvZUlUuzS+jXiOpbz0N4fbIVwKUH8mkRGAmd7iR9KunB2ckVFAFsWtAQzkYHDzHOCtv1J55M4n5Fsu/o1tad7/lR0JEEjju1A2PHD10u1TQqghf0MvBhIHoe99rWSI4kiLYYYbKKgBeCHTi7oTF0/g0yFwLsdXpYujKHy8sM7djMH4C/TIc3I5TjzE5aDqqHKuHZHd3IW/6HvQqkV4/d+7xf1vmw3BNlYJzW2QnyTGqsx5lrUYEVW80S/1AhKBp5tC506VNWC1GOtMxt1y4qBCDjolUqAj5ePcLsRyo0090lI+r7I1DIZILfsWKlp/WCEqYZ30ecz2zy2rLJSigppKibEfdUHhP3MmeuPoHm4qTHCvKPKixbmZrpYQOv7mImRs0Mf4MAwGoOXjfBHHT4EySma//zbbcemr0le4T9TNueWThjPNGvRzK0ck+ag6FTPJKlBSu8FyZ5Abi34KNycPqCemkcIsBYS4R4ZApRngoOK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(31686004)(86362001)(83380400001)(31696002)(41300700001)(26005)(2616005)(558084003)(38100700002)(6506007)(2906002)(6512007)(5660300002)(53546011)(66946007)(478600001)(82960400001)(4326008)(66556008)(316002)(66476007)(8936002)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzFNMHA3VmQrd2NhUkVuUVZ0bkFuNjNpZDVPUDhkdVdBNVBIOTViZ2xnSnFx?=
 =?utf-8?B?cHQwRHNMb1A2YlY0Nm9UdUp0RG01Zm0rQ05kR0hPdVJmMjNSTWt4S2R0QXRV?=
 =?utf-8?B?cDNaZDBCODFrdG1ocWFOU25kYmhpRHllcDZIK0x5UlNsL293Z2p1QXQ5ZE5E?=
 =?utf-8?B?Qm13YnY5aGJPMjZ1UWFKS2RmRUlteHl0cnlpWGdmQVF2MGZYMzZZNG9IbmZq?=
 =?utf-8?B?QXgxUVJGR1hHL1RPNWFmK2dRRHVOTy9yVjBsS0I2R1IvWGZXN3g3UGd0ZWk2?=
 =?utf-8?B?SlpUR0dpcTV3YUVwclRBNG9KQ1BUbUh0YTJ1RzI2OHVlR0lNR09WZDFUbWdL?=
 =?utf-8?B?bVU0aW5ETHZxMSt1OGdGNGlscFcvb2Z6NEROZkxGMUQvZHVYTDF1NHBOenZI?=
 =?utf-8?B?N2w5VkFEbDhFZk9GRSt0OUlOd3JuS2s5RTNqcmVVQkNMUW0wdklkVlBIQ3Jz?=
 =?utf-8?B?NUVFM2NLU0RwbHJRODBoR3hpRk44RjNSYmc4VnZKOTNBY3VDQnRQM28zR0pR?=
 =?utf-8?B?UkYvSDZuc0dOR0ZwaGg5emg0dGZZcDB6S3M3SWhpeStCT3VJdFA4enpHRmtB?=
 =?utf-8?B?bk1RVjBpVHZNaSthSzhRSlhQeVVnRVkwZ0w3Sjh5Tlh3MzlyVTZOZW4vWXVr?=
 =?utf-8?B?bGdDQjZPQTJZakwwUGZDbHJXMmo2azdzWDdpbkE4aDlURGpsYXFtcmNJWmw4?=
 =?utf-8?B?bStYaG82cEpvNHNKNngzcmQzRVUyU3lxYTNLbS9oVTVFdGFFZmtwbnBQVW9l?=
 =?utf-8?B?d2plaTBMb1QvaGxCLzZXR0NxS2R2aVhCZkUzcUpkVC9Nc1BpUHBsYjF0Visy?=
 =?utf-8?B?c0ZNZWJLemJoNVlLQmdzTGhMZ0RXNzBZOCtXYkxuZTZadldnWkVhblUrYzlB?=
 =?utf-8?B?N1dTTjZYZVU1dXpvK0tEVCtUUytPbWMvQ29SZ1NtN1RPQlc4cUNKZ2RzVnM2?=
 =?utf-8?B?K3V6S1pkNENDVmljMzJKOWU3L3o2OWZYaHpZTlo0Z1JMcmZRVHBrZWU2dVQw?=
 =?utf-8?B?MmhFT1ROMEJDcjZHZmhiVU5pZWcrempVM2toczR4bWcvdDh2MlZpN2tlL2Ns?=
 =?utf-8?B?ZCtmbE14SWFZbkZzNzhvK2xkYkUya3M3cTVISlZSMkI1VVd4YkhzTkxaWXlZ?=
 =?utf-8?B?dlU3SWRPR1pzbmwrODBSMUE5Vjc2WkI4ZFNZRDA5ZTBCcGFCM0x6bmJKR2sz?=
 =?utf-8?B?Nm5xOU02NGRzNlBqSzZNTTl5Z0ROK25VYURrUnNyamJHS2FwM0FaeDBqb1cy?=
 =?utf-8?B?ZEdwM0NBMnh2dysrbnZnMGdtcmhSUldYSUJQWUtLOWFBb2lYdVFFN01BNitR?=
 =?utf-8?B?aWIwUU93WkN2SUU2ZmI1anFIVjNaYkhMb1AraWRYUXB2aGovU1ZvaE5Sd1Mr?=
 =?utf-8?B?ZFJjaWtZYzJuLzhWWVB6OUNPc2gxdnJ1czkzRkRFQUtuM204bVZYRlU3enJQ?=
 =?utf-8?B?OHJtcWNNQ01kQmVzWXpSTllDaFMvK1FUbnNEYU9QNXBFUkpWbGZYdnFPQ2gw?=
 =?utf-8?B?ZXZ4NSsvUGxFNG9tNUh5SU9sSlpHdlc4Q080Z0tWYVc1RDg0NWgyT2IxU1pw?=
 =?utf-8?B?bGhucTNTMTlrcmNNVzNFc2REd3UwKzB5WXA0QlluRlVhN05kQkpsbXQxajJM?=
 =?utf-8?B?M1F3NDFKUUZJWEFvejZSa1l6WUY0dUtDbnRaQzF6UENCWDdBNGdEK2RWaEx5?=
 =?utf-8?B?YWtZNU0xNG56OHE2VlFGaktHcW9QVVUrUU05cTAxT2xQUmVjS294TTRiSmM0?=
 =?utf-8?B?eWFoUHNuUmFHTEh3TWJ4YlVaenk3RDdRNmNPRU12aGZtdUJXaElhSENockMy?=
 =?utf-8?B?SUw1U3hUWmxvK0FpL0dkWFZFSW1hUUNTaFI3cFZFc0VDR0ZaQnZkbkczeldr?=
 =?utf-8?B?emtDTHdweHdkR2ZmNEVmS0dqV1Voc21MVzY3eTA5bHY4VkVHTmZSYVRncGNp?=
 =?utf-8?B?RHBFU1NoaGZLOUNjTDBlcE1LR0RrcWh6VVhCeE1KbGJwUWRDK1AvOHRQaTZz?=
 =?utf-8?B?OUowQjlPNWwrNTFhbVJzWDhMUFhNb0J2TXd6MHZxYURWMGJtWDlxaEVXbHBT?=
 =?utf-8?B?R2N1UmEvZGo4V2lsWDNxSUk0V1d1T1VJeEp3cjZXTnlPNC84VzNMa1F0RVJr?=
 =?utf-8?B?alEySTc5Uk13aDlqSWZKbkZnNjZxcE5RbWhDa2RBZG5QazI2TXBPd0t1aDEz?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0ffb0c-4c62-4860-113f-08dc2daa5709
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 22:14:40.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pVGVDE524hYS790E1uQckzCfV1ev27+qPp+8HHsFNJTalu2nTjaT99zmCUFuMgjfJXNerIku25prC6OmgT2oxJRypLPnc8w6zxLy76eyu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7242
X-OriginatorOrg: intel.com



On 2/14/2024 7:48 AM, Raju Rangoju wrote:
> A new version of XPCS access routines have been introduced, add the
> support to xgbe_pci_probe() to use these routines.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

