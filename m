Return-Path: <netdev+bounces-46701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F6B7E5F49
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 21:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F40B20CFD
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 20:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4F41A5B9;
	Wed,  8 Nov 2023 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iu8GuUBM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88F32C65
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 20:38:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB032581
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 12:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699475887; x=1731011887;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qMW89WISyP4TWczt9IuXs79xTosPRTicXgCbI3jXVBU=;
  b=Iu8GuUBMqIJhhJxJprm6iMG00B0mijSvqyq5wOvy7+4juKJWFuo5g2wA
   G3dXdiXAYWLbP5ltimryo8MGYM8ZzHUWucBtmnCNWtLs5ScTGfHdKqB60
   VGOkYW0PB44KzDmvDH/xNKU3XaUQFZ+2zUBCWZ92UjbLpk+LJHq3AvDdk
   uQhPjb07U5qbV7eFBCwaJbYIEkjr7AkfJaFznBbIUEZjpY8+qxsso4tqq
   e0Ew0MAqugJDpN8y1NH1qzL6Yg7/x00bFtHidxl5rnzZ1ym+n3uDRi9jo
   eRS2U/1BiChtRt29ZrOic8nPEMdwoE/Gu2hpnxGOFExs8aBRR2fX9QaXJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369188598"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="369188598"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 12:38:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="833595728"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="833595728"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 12:38:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 12:38:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 12:38:06 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 12:38:06 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 12:38:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfL2Wqekl5Pq4qR5f8l6Zj0BFc0T0MHxwoc9FhaNqmyqIoZX1iGVcf4Ub20wm9CfYKEYupwPC7tHinGre5xyvyj0dK/XFJMNOlNX63flymVgx6oxcjHPtItwoGgqK34tHMv2nFg3MPDyXJeG9GetqZLOt7LBCmy/3kR8Q+sfFyJXVlWvrQS3limldha6cECKl+eMkFncgokaPZo3jCR/CQ16AqYM2uNGKQQgaZPg3EKZSIpeqwv4OD7vvyMXZgrmCyIywqwdBQUQzu0Cqbv/PIzrxYnLNEt27YFRJ5UdTrFTMt2DJ+MW5S1G9b2SSdU75qaOH04X5hXwyCwjk0HMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SvnDqSS9iYBwPqZZ2auBQ0vsEhNJ3XnnIaCehR7j1E=;
 b=MF253T1QVY58czDX16TCqQ6Knl9wXcZlzSfXnmqKBupuxHcjlvR1QoKzNobsmfGMiQ9u16HniPk3454g/oDArPZpt0yT3X5FgvtbATrmr/U77xFVn6TxQZXvQwK3QYIGSyby/sYMv6fjO9VJfbdxaxgEVxs0vX2iGchvIPTBXvWYCHWtBHcVwBa2LTibZ0UuL38TW/1/qAbhMXoaurIujcWTmOFIAuQ1Zw/2uuoxGJoKt5Zvpt18/X2MoXJj6FYNbWurXufIuXz1RA5hoolBKstGT+pqNpu/526dqkEC16RTpkr6yaK0eRRjtAO7szG/gW+3rDMl/Dqy2q0IFRwpAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 20:38:03 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::8e20:31f5:2a6e:9bdd]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::8e20:31f5:2a6e:9bdd%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 20:38:03 +0000
Message-ID: <d6114f2b-4ac8-ce15-19f6-483965daf3f3@intel.com>
Date: Wed, 8 Nov 2023 12:38:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH iwl-net] i40e: Fix max frame size check
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, <intel-wired-lan@lists.osuosl.org>
CC: Jacob Keller <jacob.e.keller@intel.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>
References: <20231108151018.72670-1-ivecera@redhat.com>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20231108151018.72670-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:303:2a::22) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|MW5PR11MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 944ecaea-c227-4686-f05f-08dbe09a9a73
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7ELGmyYjmKBKSg9wGu6ZfkwfA/otI1k15dYoZoAPoOL3scIvnhFq8BBdHjnz6w6pfdj60Lr+0D3B9YWZtwNYtDkfq6o715Aq8P4ROlx+LKX/DPWaVGs9gysI3Q3bqn1i4/t0og+BRiabc0A1ATEVsGCW5cfVG6GCgMb75Qw2ECCixqj8CtjkT6lBjYxIKpvma6vMCEeHXlhDmvBckdldDEq8FcN8rLYdMafjHRHbkYSA/XuPxwBd1Ugu+ryy4s9uK7M/5Q5KapxpXT2WZ3ViMe7Xi6UQ053x/RZwrUPXIvuzAGCMXWT6gx6RXROW8zmpvKBkFQBzcZ8w4fb7c2gfEWFjgRHFy7VpGas331LnmaALRVCFQDFWpvDEmvQfNXPC/jARucIy38ueg0dpiE497zDwdELR/1hlOXAW6r9f0N8NRvOzaX1DHpL6kuz2X6YpCN0ih5o25UVaojZGr+T/OWmqfsET5VB+doIxyt4PP41frKtKeMHi2ROKaqePjloGuzVTGo931z3C6T1t3m1HXwhtaEo+rp5QCqATTwDmcTVFEE9d1fXiUv0Lc5XfUzEdy1hMnHGRQHrceG/BFkPH7eJwTyYrJH4erFSqqXozoIr69pOhNbUqjUfwDtZYaWUk6Rqz2BQbPs+UJa3zMQ9xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6486002)(5660300002)(83380400001)(2616005)(38100700002)(26005)(8936002)(2906002)(44832011)(54906003)(8676002)(4326008)(316002)(41300700001)(478600001)(6512007)(6506007)(66476007)(66946007)(66556008)(36756003)(53546011)(31696002)(86362001)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0lSb2o3Q2NOZm5PSDM3TlZFQ2duUFg3TG5DV2RoaG1scytobEkrWUtjNzg2?=
 =?utf-8?B?NC9EUzJpT1RuUG1pUHV6M2FwbFRWQjczUDQ3S3N3aVNPSlc2TWhZc0JrZW11?=
 =?utf-8?B?VTBLQkI4dGV2UERUTDBuS25scVdGcWw5Nm5hQnFHc2FSWDRDOGRXWUdQRlFP?=
 =?utf-8?B?RlV6OW9rNE5iRlRmTmZ2MG5BTE1vQ2pXVkJvRnc2L0VIRW5QTkhMbWhsWWo5?=
 =?utf-8?B?Z0VkbEhIWldtNGthZTkvMkd4OXdFelhCNDBCTVFTd3BGckNwOGpNUWFjRHg1?=
 =?utf-8?B?bUJkRW52TzdvRFRHenVqUXFmWWswV3lQTFRDSldYTy83SDl6RkFmNW5OWG40?=
 =?utf-8?B?RWtIUmhKVDFqbkl3N1pTYnBUaFRPNHJhNEs5T3RMV0JhK1J6K1FVbkNSMW5Z?=
 =?utf-8?B?d0kxazNOblQ1WDQvY3NZWUMvSnBPOGpkNDErOUxQRVlSeUhraDVualJtMlpF?=
 =?utf-8?B?NjltSThiYlNab3pUK3l6NGdvdlg4ZGo1K1ptM3pWZTRMSU9id3k0MlhTN1VL?=
 =?utf-8?B?ZUlvTnV2ZzFNZm4xZzBkR1RkVXc3UHlydlZ3V0NjL0dRbkkyTHZmZ3FiSmwy?=
 =?utf-8?B?NDdrcFQ0ZmVMUE1RRnhBbEVGeVZqZUpWaG1jVGk0TjFxT2NxNUtYRzZ1U3Za?=
 =?utf-8?B?cVpsaFVNQmpEVmFaL0N2dHQzYnkzSzQxQ3VrMHI1Rnk0NW9OU0tKSUV3cHJr?=
 =?utf-8?B?dC9SSW8yL1BhOHJSblk5UDEzekFEYTF3K1hzTUFTMmdtY2NLNitPcHRJVTYz?=
 =?utf-8?B?WXREb0xjT0orZ2E4aXFkUnFIYStOQ2dQWnoxWldoQWNhVXVUOUN6UW9COG9a?=
 =?utf-8?B?U1EvOXgzaTZoN0JYV1h5QVRHOWtzWTBSOUVGaU1jZXVDRjAzSXIyc0xyVW9z?=
 =?utf-8?B?ZHp1Rm9BclZ2NFJaczFERUtNNTJjZzVXcVZJbHBlZit6ckVKM1RBbDNNcExk?=
 =?utf-8?B?Y1N5QzhhR2dlZ0hXcWxnTVhUUnpDTU1CQW15blZiYmU4bGxqMFRUNnJzRjJ5?=
 =?utf-8?B?aHE2c0FZcVd5cWVXNWx1aVVMZytOd2RUQ0tXTmZLYkFQeVhIcmVYSUVZaGlk?=
 =?utf-8?B?MmlkQWwzaUExbmd5aVdhL0gwbkZETUhUazhXa3prYlhjYzVzcmFiZ2NqVE1R?=
 =?utf-8?B?YlRXdTQ0ems0NGo5aXV3U0drRDA0Q0NBVzJuSTRWMm1Hd3RDOUpZWG5GazRC?=
 =?utf-8?B?ZStJMzF0Q1kweW1uQXllQXdEWXdiVk4rZFBjZEIyUnZ1QXFSN2hjdEpFeHlz?=
 =?utf-8?B?eTNkTlVqSU4ybVIwVDFxeDczMkJwUWN1VjdXL1FLL2ZSaDBGMUxtajZXL2VO?=
 =?utf-8?B?U1p5OUFZOWFIYmczeTc1R0xGdFltc29zWFFTckFhOXZXd3RLT1JaNjRSQW50?=
 =?utf-8?B?c0FsZm16Zzk4YXJhRnlFZ291NUdSWGtjRndXZTZLMlI3Z2hqSHR5MW8vTTBT?=
 =?utf-8?B?K3R2aTBZZGZtN29SbXRsUkRaKzRDL0pNc3dRRFJFa1JkaXZpMUNLM2tvQUNn?=
 =?utf-8?B?VFpvdVFLc2JBb3M5d2gzMjdoV2ROM1haNXVjVllhdzhrS3l5RXVxRXN4NzdI?=
 =?utf-8?B?TG1yWU8xWUkyZHh0OWw0WFVtbVlWaUFIemVRMFl2dzc1TEVEODBXMktCRXBa?=
 =?utf-8?B?bngvTnNIR3ZrUlF2Nmowc3Z1aWRpdnFXTDhuL0w4Ym1tT1RjRUVnWXdjeEph?=
 =?utf-8?B?N0YvVktQRmJ3NmhEcWdRZ29iMTdyQit4VVZaaXM0S0wxS1A4ODFibFpZS3VE?=
 =?utf-8?B?RXFNeWtvUEliMm1VUk10elRmSms5Y0pzUDZKbXZzajd0MXlWYzJaVWowdjgx?=
 =?utf-8?B?RDJmbGN5MzErdWZTMFhmU0RkZURnbitRT3MzRGRBOTZ6c3FWYWVxUjlLdXdW?=
 =?utf-8?B?ejF4dUJCeDN6RnNsOXlkaEc3V0NDUXhhUjErTkY4YzNjUjdscVpiaitnM0tK?=
 =?utf-8?B?L2xOUFordnUyWTlTMDVOaTFBZHZoNHFWdGY1VnBWNEVwdWNNbk1tbWZMcDBT?=
 =?utf-8?B?aDRnRjFOM1dMc3BLcCtqQlVjZkV2alJJQXRrU1lBbndLY1krMXkxMi9qQVky?=
 =?utf-8?B?VjRiSjgwWFZ3NDRQdDJGOEdtUy9FU1FZd0FpRUx1M3I1Z2ZnMS9yTWhTT0c2?=
 =?utf-8?B?eXg5aEdKTFFGYXlpYWUyVWFFMnR0ZTJUR0VIY245a1BRdHBUb0czWUdkaTZp?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 944ecaea-c227-4686-f05f-08dbe09a9a73
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 20:38:02.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doKcIny5XjoSr4cDcfFraq5365djSY90GcVGkszgIdUBBtoOjODpBbU5RtRRdz07NqKiIB8V3Tp8Ol9NMdILn1TQYLR4JVG1M/qXfK+eFqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
X-OriginatorOrg: intel.com

On 11/8/2023 7:10 AM, Ivan Vecera wrote:
> Commit 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set") added
> a check for port's MFS (max frame size) value. The value is stored
> in PRTGL_SAH register for each physical port. According datasheet this
> register is defined as:
> 
> PRTGL_SAH[PRT]: (0x001E2140 + 0x4*PRT, PRT=0...3)
> 
> where PRT is physical port number.

<trimmed lkml, and a couple of non-existent intel addresses>

Was there an actual problem here? I suspect if you read all the
registers for each PF's BAR, you'll find that all 4 report the same,
correct value, for the perspective of the BAR they're being read from.

The i40e hardware does this (somewhat non-obvious) for *lots* of port
specific registers, and what happens is no matter which of the 4 you
read the value from, you'll get the right "port specific" value. This is
because the hardware designers decided to make a different "view" on the
register set depending on which PF you access it from. The only time
these offsets matter is when the part is in debug mode or when the
firmware is reading the internal registers (from the internal firmware
register space - which has no aliasing) that rely on the correct offset.

In this case, I think your change won't make any functional difference,
but I can see why you want to make the change as the code doesn't match
the datasheet's definition of the register.

That all said, unless you can prove a problem, I'm relatively sure that
nothing is wrong here in functionality or code. And if you go this
route, there might be a lot of other registers to fix that have the same
aliasing.

I apologize for the confusing manuals and header file, it's complicated
but in practice works really well. Effectively you can't read other
port's registers by accident.

Here was my experiment showing the aliasing on X722. You'll note that
the lower 16 bits are a MAC address that doesn't change no matter which
register you read.

device 20:0.0
0x1e2140 == 0x26008245
0x1e2144 == 0x26008245
0x1e2148 == 0x26008245
0x1e214c == 0x26008245
device 20:0.1
0x1e2140 == 0x26008345
0x1e2144 == 0x26008345
0x1e2148 == 0x26008345
0x1e214c == 0x26008345
device 20:0.2
0x1e2140 == 0x26008445
0x1e2144 == 0x26008445
0x1e2148 == 0x26008445
0x1e214c == 0x26008445
device 20:0.3
0x1e2140 == 0x26008545
0x1e2144 == 0x26008545
0x1e2148 == 0x26008545
0x1e214c == 0x26008545

lspci -d ::0200
20:00.0 Ethernet controller: Intel Corporation Ethernet Connection X722
for 10GBASE-T (rev 04)
20:00.1 Ethernet controller: Intel Corporation Ethernet Connection X722
for 10GBASE-T (rev 04)
20:00.2 Ethernet controller: Intel Corporation Ethernet Connection X722
for 10GbE SFP+ (rev 04)
20:00.3 Ethernet controller: Intel Corporation Ethernet Connection X722
for 10GbE SFP+ (rev 04)

Hope this helps!

