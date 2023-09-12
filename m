Return-Path: <netdev+bounces-33378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5855179DA2C
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 22:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A2B1C20CAF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8168A92D;
	Tue, 12 Sep 2023 20:37:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E14D8F4B
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 20:37:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E546E189
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694551057; x=1726087057;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NCt0qAFG8qbazL4FG2+IudoyuXGTo3nshuBY2i7QDI4=;
  b=FnJ0BX/QIv+qLYdnvSTDu3c8hkuzN5b8qz8BP2f4w08GIL2GjVvk2vNt
   fBBnXU4g0w1U6J0DuI8/7uh/MsjQENXI0n0rCibbGtKIqKsxn+eq6iisJ
   HlVnwJ5cJl8QMUF9znHR7GVq1VretAUoQAZUEbJR7WrYeg+bx1uQf/rua
   3tdLSL4i+4vDHuKm31pOYTOn0yCZlHmCpJy0dLHFFrSkIiAYd7655vlK5
   GfaVHFb6AphuGHx9WkEybBEJ2XoNPsURflSZ6YulkvsoAu+m1M3Bcot3n
   ja2hEyHamr+b3DAhwCpjzvqBIhX+RuQXPNPxDvLL+GCv/GodjLXMsJt+E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="442509930"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="442509930"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 13:37:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="809410129"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="809410129"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 13:37:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 13:37:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 13:37:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 13:37:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 13:37:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LF+jWPvpErZfeKAmKBR2b6rH3o1iAzeZLXEAPefakEXI1vJODkFtQepkxU6rD65l4WpAU6o/dNg+1YQwJUDV2qXRBVxQb/tmM9DiXwa2CmIkWQgp0sTXV6BT280Y8seHTjf6SDxvV5jls91v9p9oc0UOfPWZ11tny++HYKKg3UhmyOSKB2WKgXtfBmFN0GMJVqHhlRqutuJCn+bftNIJYJV7oN3B7NlKQIaMeBEVAj5BZ75r41/+zr+eKAXEXUgkFMnpU7UfQk6vPpWUcicOgw7SHLdDCCWi2lX+VCAtIT3yQLwluCWbwXlbhN/P2h/qPLPeNhwW9FGSelUP9WVgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79cky0N69lnf+oI1nEQDE/G4OZw6v8FmJlGSwwpU17Q=;
 b=btF60V80AnS5ORopegpIoT+9DuHsHx1OMDV3pwyXsU61v6FW4XCZ8aOly7ij68wgS2XRkrvYcrJruFLAi6W/MWG6QOjUbS0IT65HvU5Kq4ZGFWEKgaPKO4DWUuyxYJ6GVdTFL3X6YvT623a/EGKa/6c0UVXDlnfDVDMCQuHJIO/R52xIke8z9VFPvTeVm3D0Tmt3CLkLUBC93jxMlvrBlyKntl163mAOqe4cSAaUOUBeIDe83WLpmYtnCxG9+/BtZFp3MjShvqvfD9eCvf6U/qqLiukbSQ5WbcrSb4OMuwlNKOBkOgY5nTPyU2ddfGgwijN/ATYEqxccRlnuvHd/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by DM4PR11MB5358.namprd11.prod.outlook.com (2603:10b6:5:395::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 20:37:31 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::6add:b67d:5d6c:6439]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::6add:b67d:5d6c:6439%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 20:37:30 +0000
Message-ID: <f770f4b3-f4f1-4ef7-e80a-d7c75c8b18e0@intel.com>
Date: Tue, 12 Sep 2023 15:37:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH iwl-next v9 00/15] Introduce the Parser Library
Content-Language: en-US
To: Tom Herbert <tom@herbertland.com>
CC: Jakub Kicinski <kuba@kernel.org>, Junfeng Guo <junfeng.guo@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <jesse.brandeburg@intel.com>,
	<qi.z.zhang@intel.com>, <ivecera@redhat.com>, <horms@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <pabeni@redhat.com>
References: <20230904021455.3944605-1-junfeng.guo@intel.com>
 <20230905153734.18b9bc84@kernel.org>
 <CALx6S34B_BvkNuqALCCT+2V2dL8rwr9n_DnRfevjkW4UwMF=pw@mail.gmail.com>
 <8df3c9c6-19ed-acc8-f2ac-1826a81ab53c@intel.com>
 <CALx6S345sufnhn6zVO03ZauDiU52F9SbbZTgaGm6xxr=yKyPUQ@mail.gmail.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <CALx6S345sufnhn6zVO03ZauDiU52F9SbbZTgaGm6xxr=yKyPUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::13) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|DM4PR11MB5358:EE_
X-MS-Office365-Filtering-Correlation-Id: 83fee7ae-0cc1-4edb-3d2e-08dbb3d015ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYKFjRLNwZdwZXuJI96yQqj/Wmr2C5Pek9uinzVVxkWClwhLPsZ6te5OYSFkRt9MToEUKADMmmNl6xuXNRUps+iznk4sNEnXO9CkLirrnHGJ9zU1Vhrj8GKo68QPVeNaWtzJxRTJfHBsAKeBqDdIXav5JB75IF/vo5alSyxK7g4RFsyNAAqeL3gz7DRQzUk8xC+7pE8PmHcXvKBa/g5pHzGq0wMZ78+/iJgiZWNQF3f7ZvdqBDaonDZCimGgOqBl2ecnqtWEkwN3WdPDMCo+vFhyMzUo3e7QfUf3AipVIUXBlKgum/s1iV1JSUhS4mrP8N9ebHbxVciNf056syp0n4n5vaORtkX7tuq3dwE/cLOxs6sjTWZv+S/P/RsS2/Lw4IuKAkb3kd/Zh3hBIQbkOmpwzOjVsh+Lhp5e8QwhJi29t+nn2dUZSiDGdPcH2a5t/uGfQDFr77KV/HXWKyU7lvfFmX+PTAzFdt2bAfyR8B9QNepwlCJXgOvvFIjsYmOgwLwryEZC/Hy3nEks/8COLDDehSMtwT1j9UyEtOIwb5u5MxADIM+FMGQc/5poZzqe0Dh16/BUzrxw7zXdq2QEPpyS3rwnjzE/tCu6nSAWAxCLifDYLtoPJokol7d1hX8nWIcbcRTEPK6TWv1enbLfeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199024)(186009)(1800799009)(86362001)(31696002)(5660300002)(8936002)(8676002)(4326008)(2906002)(36756003)(6666004)(53546011)(6512007)(6486002)(6506007)(26005)(2616005)(82960400001)(38100700002)(478600001)(83380400001)(31686004)(316002)(41300700001)(66476007)(54906003)(66556008)(66946007)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?by9lS1N6SzVMdUpIMk5UMndPdTdtSUxHU05kdW91RzFSa2U3ZS9SYmRvbTVi?=
 =?utf-8?B?WDNwS0FkOWhncjlBOXl1L1BYNHJJTVN2cnk2eTdSNGtSYjR3YjZ1ZU9Zcm5z?=
 =?utf-8?B?V0t2SkEzYUg1VjJiN1VXNmVNWGQwejA4TXJ3MmZBbUczRk4vb2JQSUpqbk1v?=
 =?utf-8?B?a1diVDRYVUFrQlFrekZISHBVVlFaZldrTVArSHZtNU1Zb0NpY3JjUVNGQzJ2?=
 =?utf-8?B?N1IxRlZUSVVVT1VYSWpQNGNVdXBNT09wOVJ0elhlaUI0S20xYk5iNnJHSlQw?=
 =?utf-8?B?b0c0MEhIVGQrdE55WDdrT2RrNVIrQUJJZ0N4UjIvTVJrVkFTVHY1WStCekVJ?=
 =?utf-8?B?SmxzMTFlS0JXZ2VrdVpwRXB5bzI5QkJTYmx5MUM1eVRndkFodHNOVnk0OEpF?=
 =?utf-8?B?SFFSLzNQSm84WlJEMmV0K3NEaVcxU2FUQUg3NlNVUGlvNTJNM1pVMTBTVU1G?=
 =?utf-8?B?Z1BBaEZjcG9IRU4waWxESTU1NWdRa3cwU3hDS2x4YXNKM1E5Tnp1TVplWG9i?=
 =?utf-8?B?Y1dDT2IwckhOZVRIQnc2ak5UeWZ5T0FRcnUvdmtCOUlQaTRPV0xHRkVEYzJs?=
 =?utf-8?B?UitjT0FpZkp3TG1tVjJFc215WXhkNUNOMzJ0Tjg5SG9nS0l6NVdlR0pOQit0?=
 =?utf-8?B?N1NrRDVWV2c0d3YzdThGZ3NxdExiOVhBT1JjdnllWGMweGJCb0FQTXdEK0tB?=
 =?utf-8?B?VXZiUGVOK0ZiNmFRUTZYaWFBbjN2UVh6R2pHZlVYSkF0eFVkRlR5N0Q4djJk?=
 =?utf-8?B?cnZ2LzAxRkFkekQ0WVFqbitYQktrWkZ3bjdpTzdlbVFzQWh4WDNWay9tdTZZ?=
 =?utf-8?B?L3FLSXdNNnNjSllWNFRSQUlFZEpBcTNLbXlvM2p0Tk1oeU81ald5U0dhVThN?=
 =?utf-8?B?dUhOQzV5cnBzOHBBNW12S1VBTEpCbVJDYzJjYXAwdFkyS2F4bEpnc2hSaUor?=
 =?utf-8?B?ckUrMDZlUW9mUjdsVXVqNXhuVm01OThvcmM5OVlWOStHMFdWT0I5ZkhVSmhT?=
 =?utf-8?B?M1FsUnJDWHBLWTcvU05pQndkRVRxbnBHVmZzVnVvbFFqdjdFMUJDOE5qVTVL?=
 =?utf-8?B?aW85VjdFOUlpbWQrWGFZdDlhOGdqbnJRZStxVDB4b21ZeTgrdzc3a1JoZWFr?=
 =?utf-8?B?cVFBRkZvczN4dWE2S3NyTW9sRmVJa3JuK2FNVzNYOGYxZytMaXR4dWE2UldZ?=
 =?utf-8?B?bDFma2l6UVNDMWc2T0JPaXVLaUN0cEZDYllwT2pEU29ycjR2ZHNaMmZjSkFY?=
 =?utf-8?B?blRubStUazhYbEVPZktnYXkvdUN1dlBCRTIvT21RZHVidHRNM3JHZTE1d3cr?=
 =?utf-8?B?emtYOHQ5N1I0NlJqVGEyc004TTd5ZUQrVnBSNHhUTnlIaUozbU44alY2Uk1z?=
 =?utf-8?B?TU4vSTIyUEVuMTNqUWNrNGhFWDdrNTFsSVZFTi9FK2dyaTZ4ZnRjTXduYndw?=
 =?utf-8?B?Y01NcEtwRWNsMjRFUGI4bEtvK0FqSEtQN25FYW5CNFk2d0p4aGZqbHVja1A2?=
 =?utf-8?B?c2lGaVoyQ3EyTXIrNUFHaElQdDhRcCthQ2dzKzhYVkt4Kzh6RGNGc1E1YTIx?=
 =?utf-8?B?dXNqQzF1aGJrRHl0Y2ZDTEFzenlic21FSy8wbTZqdWIySFhhZXhIWGdmWE0z?=
 =?utf-8?B?Zkd1ZWVzZFRMYlY2aVlKb05VSHo0TkFaRTA0Y0I2WU1PRTNnWW9Vc0cyTVBI?=
 =?utf-8?B?WnRFSTYzaXRUenY3dTlwYU9YSDhJTWpESS9zUFlaODZFQVZMVWgxQjg5UTZN?=
 =?utf-8?B?WEVKbWJsclpMRmt1SmtiTlhVRldaRDhGcjRnNERWRENYM2MvV0wxamJvcDMr?=
 =?utf-8?B?QmN4TkxSTEVTeTNvaTNLYjdyd1h2NlU4Vkc2NnFhR0lFUytnT1dVK3NVL2xW?=
 =?utf-8?B?Z25wWkFGMnlnOHk2SlZHVk8zd295MXhHL0UyQXRNZ1Nkc2VQZkh5eXlWd21E?=
 =?utf-8?B?dWJ6bkJmTThpemo2NnZWM2drNEwyT1RZV0l3dzB4ekpGWVM5NWdDTDhmMi82?=
 =?utf-8?B?WUlVWmo4c0NBK0orMXM2ZmVvNElaaXJ5L3BwVFJnd2lMRXZnUUpHV0l6TU9F?=
 =?utf-8?B?VlJoT3ViS25uUEZjWitSa0Q1cTNVMDFmRUlNQTlzeHJDa1JwVE5ZODY0d1U2?=
 =?utf-8?B?QmUveTVvU1NiK3Z2UDlPSlRyMmFZdWR5aDBhNEFTa1JLWW93MGZMaXlGZDVR?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fee7ae-0cc1-4edb-3d2e-08dbb3d015ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 20:37:30.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUCTpr0NmM53fxfwJyaR0/jq13Q6r0zoH1XJ51oOOrcKqTTeSEEdpU5KpGPzT0F2ZnKPxEaY1s1i43xn0mbMhptWTM44YaGzc6hiWMoI6tE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5358
X-OriginatorOrg: intel.com



On 9/9/2023 12:34 PM, Tom Herbert wrote:
> On Thu, Sep 7, 2023 at 12:10 PM Samudrala, Sridhar
> <sridhar.samudrala@intel.com> wrote:
>>
>>
>>
>> On 9/5/2023 6:05 PM, Tom Herbert wrote:
>> <snip>
>>
>>> Yes, creating an elaborate mechanism that is only usable for one
>>> vendor, e.g. a feature of DDP, really isn't very helpful. Parsing is a
>>> very common operation in the networking stack, and if there's
>>> something with the vanglorious name of "Parser Library" really should
>>> start off as being a common, foundational, vendor agnostic library to
>>> solve the larger problem and provide the most utility. The common
>>> components would define consistent user and kernel interfaces for
>>> parser offload, interfaces into the NIC drivers would be defined to
>>> allow different vendors to implement parser offload in their devices.
>>
>> I think naming this framework as 'parser library' may have caused the
>> misunderstanding. Will fix in the next revision. This is not a generic
>> network packet parser and not applicable to kernel flow dissector. It is
>> specific to ice and enables the driver to learn the hardware parser
>> capabilities from the DDP package that is downloaded to hardware. This
>> information along with the raw packet/mask is used to figure out all the
>> metadata required to add a filter rule.
> 
> Sridhar,
> 
> Okay, the DDP includes a programmable parser to some extent, and these
> patches support the driver logic to support that programmable hardware
> parser in ICE. It's still unclear to me how the rest of the world will
> use this. When you say you the information "is used to figure out all
> the metadata required to add a filter rule", who is adding these
> filter rules and what APIs are they using? 

The filter rules are added by non-linux VF drivers that provide a 
user-api to pass raw packet along with a mask to indicate the packet 
header fields to be matched. The VF driver passes this rule to the PF 
driver via VF<->PF mailbox using virtchnl API.

> Considering you mention
> it's not applicable to kernel flow dissector that leads me to believe
> that you're viewing hardware parser capabilities to be independent of
> the kernel and might even be using vendor proprietary tools to program
> the parser. But as I said, hardware parsers are becoming common, users
> benefit if we can provide common and consistent tools to program and
> use them.

Sure. But at this time this patch series is not enabling parser offload 
or configuration of parser. Only makes the rule programming to be more 
flexible.



