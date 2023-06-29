Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1C5742B89
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjF2RuN (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Thu, 29 Jun 2023 13:50:13 -0400
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com ([40.107.243.53]:4688
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232000AbjF2RuG (ORCPT <rfc822;netdev@vger.kernel.org>);
        Thu, 29 Jun 2023 13:50:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6l4lgmmzOR5F+bNGSy+BESNiPSh6NPGlZnigm3FmGO9xTH29r+FbdhfGxudTBvzRcm8fT4yJFSNPlqFNiB5ztOm59HBcn2ENryfORVuGpz155CsFQ8Kw3rN6UrhVPw417VEzGw9jeEqA2D88GFxb817XiGG1Srm7NoSWk4DBgpbTLTmq1NGrQbjv4V7pjawqUGTc2MO2jljRrrhh7lPblcY+Nzq/aQ46QTOipJUYi1HnjgTGmXK2K/ZrPqQwhOjHxP4gbrFoPQSYB/OCb/qqQeX9Uf4ZRjKlht6OvNfomZqvJKFpZB1/NEMc/WTf5GiTNr8O+1IvYYm7wW1zWHnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GAUgDmlrm9a3BbrZUEWf1qffzhBk00uiJqLv/R2dm4=;
 b=E9X6yf5fcrAbSzpp8rzr5DBh1WqRYvcqxC22lSVw3YrtLjKVWuhtJkC2ggI7/ZpAj3bmJ6d2uBiN+GM2iDQgCq5oCbfQFgsW4Y0FK4PX8k7OiPrererDd7Rzyk7ymv/vDmeswtGCU1q9cmQi8oNert7kjmYEJK9NRvjip8NMXfnYYU+umP3bnuOi37O24cNuQoOHVanS+I3FpnYsqOwdk7cOxsng2gvAS7uEC8cf8VyRDzBjnhs3z70DJkvQ95av9T6qfx70Qq3GVEZwDFaVyJz+aMfqCQxTbBfVrhU7UAdY1gykWwL8K3B/mh2zzIFDapPEXLFAE0XDv0p/KeRUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GAUgDmlrm9a3BbrZUEWf1qffzhBk00uiJqLv/R2dm4=;
 b=fZLnRu49Yp2M1wLvQvhmcwAVV8+XJH31h9+AoTFKG3CwuRu5kPVTBRWKf3rsVnDaTPqEsVjkLVhOKsQGuHD4X4Er8O/pOJNfHaLh1isUS6rdVgMtxwr1lx3LAXP+cMR2jpq+Qp3JIphY8BQXByC9jgZ9lXaFjmDBlC4cLK13pEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Thu, 29 Jun 2023 17:50:04 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6%4]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 17:50:04 +0000
Message-ID: <6bcbb3e5-e370-39eb-d96f-21b7fcfd62de@amd.com>
Date:   Thu, 29 Jun 2023 10:50:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH net] ionic: remove WARN_ON to prevent panic_on_warn
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "brett.creeley@amd.com" <brett.creeley@amd.com>,
        "drivers@pensando.io" <drivers@pensando.io>,
        "nitya.sunkad@amd.com" <nitya.sunkad@amd.com>
References: <20230628170050.21290-1-shannon.nelson@amd.com>
 <CO1PR11MB50899225D4BCFFA435A96FB6D624A@CO1PR11MB5089.namprd11.prod.outlook.com>
 <1b33f325-c104-8b0c-099f-f2d2e98fed66@amd.com>
 <20230628140612.4736ed58@kernel.org>
From:   Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <20230628140612.4736ed58@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0062.namprd08.prod.outlook.com
 (2603:10b6:a03:117::39) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 267ce78a-b3e0-47b4-6034-08db78c944b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnQJ2Nv6yjimPLRCZ8IaIrjq+rj+dO/ADxshxxuYd44jiSOLEOIztW6a59FrUepEnFKbK+84QVM2wuWRVavxl8+PYVvgKnxC47RPWC7JNtPfGpB1IX5aR1M1yNdrIhV3AicDiZuCyEZT1roQOvngeqp/zN3ZfjtEI1VMsfNtW58f84p+deWBlcsL7URf9LAqg1eFfW1aMz40na+YEgXQqzHCmXHg1T5ZmOy5bBI/SyM2UiZQ7BXeztU46TKjFqff4tZzECI2fTmcyP6wDKZOfczu39UPZDlAM9VUC0n009TFrMq6i21EyuP0YRaFS8+WensKA3Nn+4HPkG+LQkDs+5S+Xw9mIs0J97YSBxb6vVxIDZvsP5ZJtoFAWtmm8OgqaIwBv6fPMhY0sACGSfYJd35C1mt3mG8bBYgs83obxXjgL41TBZi8Lza3wVDi4wWETp2eNff+LM3gPWscfgiSRRRctHNlwt7cbf/IbJWr1VE1+2qgv2u1LT61M3NbRdHDJyjh6DTmQlGzNDz07PyjJsRcaLXqrKkkKHSV1oX8DoGm4aEYyQrTEM1SIpeuTrppXVtxXcQmkk5b3OgCx/JY9Q8uucRv9bO/eCVUrD+OIygTgpyPQdZMNSN6T80/SrcV/+Vuricyr/HbQypSQoqqhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199021)(6512007)(6666004)(2906002)(186003)(6486002)(86362001)(83380400001)(38100700002)(2616005)(26005)(53546011)(6506007)(966005)(31696002)(41300700001)(54906003)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(31686004)(66476007)(6916009)(44832011)(5660300002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0dISFI1OWJPRGR0VTRaZDJuTU5TZXEwU2xUaEk3OGJsSkh6Z0tnNG1EOWxo?=
 =?utf-8?B?WXc2bVpvNTBUeEdoakRJU2I0RGgyZGJzOFkzQllzZ3JXTHBFWUpXWHlTUFBY?=
 =?utf-8?B?ZTlhZHdyamFwVXRvR2I0K3EvOEJyekFrOGtDL0ZDbEVPeTR5TFlpNGhpYkZq?=
 =?utf-8?B?bU5VSDVYMFRkUnlYUXgvR1dUZU1zMHdHYUVZNElzRUxxT3Y1TjJNT2RSdW0w?=
 =?utf-8?B?TVRVZUZZOEJRM3ZlaEd1QjVnWEtIN21pSXdWYksxRzlNdVlXV05MNUl6YVVD?=
 =?utf-8?B?WGVrelY2b3U3bnEvS09IZ1pDakVLOUhJckpZMDZiOWhINWdFQldKdVR5SlVt?=
 =?utf-8?B?bzRBd0hpTVgvZS9sMVZVY0hsRllrQW9vSE9DT21PREJhWVRtU3lxeFdFVEZ0?=
 =?utf-8?B?ci9lYVo4TENGRElpY20vRTFkNHMzUjlidTU2L3Rub2pvMmtpV1BVQ0J2Tmpm?=
 =?utf-8?B?dU1lMnpvQjdxM0JQK2NqUUhCdWttaWlHeXozUGZsY3lSR0ZBVW5ZVGJyNWhZ?=
 =?utf-8?B?QzBMZnFLU1dGb05CMFd3N1ZEcEJKZWFPNThtSzBUbGNrNExrSHJnL1VXbzFU?=
 =?utf-8?B?OUNtRENPTzZZYUlIZTZhUld1RXFWUjlKd2k3UHRjbDZRdlZhT0NFalVyd0JH?=
 =?utf-8?B?ZzJVQ2UrUVF0YXZ5R3RtLy93OEtjdnZKQ2Qyc1E0allYbVdPWTVUYUhVU2px?=
 =?utf-8?B?WWxhcjdSalR6M2tDRk9KcUVUQmV0aVhTV3M4T3ZjMksvNTVLUGphbEZGdyth?=
 =?utf-8?B?K3JvU0RxL1lwQjEyRzh2UXh1WU5wS25QTGk1ZWIxRENsUFRUeGVHdlE0VEdC?=
 =?utf-8?B?N1RTSWNUZG9aVVJsN1Bpd0dua0ZHa01GZmJnUTZCWk43Y1dxdjJSZi9FUlRi?=
 =?utf-8?B?b3dzbTZSZVY5RnE3Z0dVcmJNaWxZb2IyT2pIWklNOXF3MmM5MXBsY2lUUWVE?=
 =?utf-8?B?UFNWMk00S2V0bERXTHNOQVZaVTVoaVdHNk5ONHh2TFdYQlFvbmJLRW9IQTRI?=
 =?utf-8?B?VkdlTTAzWTdOaVM0ZlVqSUxyVlNZZTJRYlhJUk1ZSkJCRGpEbjBPOTFqQllo?=
 =?utf-8?B?aU1IUG9xRGU5VTArNnBKTVEwUElqTENmSHp6WGRyV1Bxd1A2RXZXamd3N0JO?=
 =?utf-8?B?UG5ZVHMwelo2RWZxY2xiRWROd2VHU3ZuQkJNa1A1bUNjSzNEaUs4RTNSUkJy?=
 =?utf-8?B?end6K3FGYUJnS3BleWd2NzRtU3JJbEJtdXlrQk1TbnpvS1czZ21xRWhTbUtq?=
 =?utf-8?B?STJUNFpUSGlvdC84cVVjSUkvVkwzTDZ1VTRyWXh3ZGEzS3JKNmZySEM3MzV5?=
 =?utf-8?B?VHhSR2dUaTRFSHBwbXV0Vk81WXhXUzZPeC91cWNQaUFJQVlFRUdUN0xPeTNo?=
 =?utf-8?B?SldNTWFpTW9hOVM1YmMyTE1QTjRYdlN2K2ttM0Z5S3dFWmZMOWx4dDhtNUpS?=
 =?utf-8?B?WGFiSWoySWIwVmtjYmI2SWs1SHpXa3I5djZGRzBvSlVNc2o0M0RpdjhSRDA1?=
 =?utf-8?B?WVVMWnRXeklPWDM0dFd5T1V3VjRZUVM1MUlOV1BsbnlrZXlVRTVhNGVlZUcy?=
 =?utf-8?B?NytuVHN1WWRPVUlVOUFBQXUrYUNjZVpab2daS1RwcDUwb25nUDlqSjgyODl1?=
 =?utf-8?B?UlAwcHJtWGVCZTdjbENUcWk4TEluNEpubGxqV3lrMnhISFVNZDNDOFJOR0tk?=
 =?utf-8?B?SEJYUThRbGNGam81eXlmampsbkdzclVHc0w5aW1wR2Nkam92RnFNaVZKbUNa?=
 =?utf-8?B?M1h4Ny9NeDB3Mi80NEF0N3hOZG5WL0ZtNTJOY2FGQXZKNitTQ0ZVNk1XYUZy?=
 =?utf-8?B?Y0c3cnd0QnVzSGc5UnRuUEdKM3paL3ZwN3d2Wm85UWtpbnpyRXpJWHBvbjdU?=
 =?utf-8?B?QUdpZkdVc1dQelBxeWE2cG9hT1MxOXlLR2xaV3F4L2cwQzFyVzBjY0pPU0dQ?=
 =?utf-8?B?KzAwWVVERUQxTCs4Mmd5ekl0NjZwMUdWYURkYU5PNDZrSWI1R1RhcnpORG13?=
 =?utf-8?B?MVk5VzJ3TmZJWlU2RTBUTExiWFo3N3lrMjRtbWZqNTJFYnN0b3h3bEJ2bUZJ?=
 =?utf-8?B?alJSUmltckZVdkhEUldPSklGQXNYUGsvYUFiNEE2Y1Rrd0Y0TWpidHNWdlRh?=
 =?utf-8?Q?4jd/p6SNw4qonOaaVlksYnS9w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267ce78a-b3e0-47b4-6034-08db78c944b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 17:50:04.1271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aav5Uo84PhhzbMIRrwFLm1DOv3PmD5UNTU+bVDJipBA2pfF4E7TcK7XVmW5JSQ2fVuHUTVTzESnQ4hBCmtRbcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On 6/28/23 2:06 PM, Jakub Kicinski wrote:
> 
> On Wed, 28 Jun 2023 11:26:18 -0700 Shannon Nelson wrote:
>>> This message could potentially use a bit more explanation since it
>>> doesn't look like you removed all the WARN_ONs in the driver, and
>>> it might help to explain why this particular WARN_ON was
>>> problematic. I don't think that would be worth a re-roll on its own
>>> though.
>>
>> There has been recent mention of not using WARNxxx macros because so
>> many folks have been setting panic_on_warn [1].  This is intended to
>> help mitigate the possibility of unnecessarily killing a machine when
>> we can adjust and continue.
>> [1]:
>> https://lore.kernel.org/netdev/2023060820-atom-doorstep-9442@gregkh/
>>
>> I believe the only other WARNxxx in this driver is a WARN_ON_ONCE in
>> ionic_regs.h which can be addressed in a separate patch.
>>
>> Neither of these are ever expected to be hit, but also neither should
>> ever kill a machine.
> 
> An explanation that this warning may in fact be hit and how in
> the commit message would be good.

Even better might be to dig further into the history of why this is even 
here and see if we can simply remove it altogether.  It is really old 
code from early development and probably should just go away.  We're 
checking and likely will followup with just a straight removal of the check.

sln
