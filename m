Return-Path: <netdev+bounces-78559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE78C875B75
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 01:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235FE1F21EB0
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 00:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CB6163;
	Fri,  8 Mar 2024 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gaEfJ6OR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864DB363
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857030; cv=fail; b=B3sYpbHuxNlFdMF1dDJpjM709+ElVfl6hv5lNjztxGlzEWrYHQb8V0u6W8h8CtLNLMijM6XS70BOEWXfpfIaHQ9yORgKobcEND0UAcJsWB0/Dg4rvU6O92Pp7CsADcdt9zByhBKCDwBTTcNhyARCH8tl2Wlt+xu9hDXK6Lnb0AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857030; c=relaxed/simple;
	bh=QL7GPIy4hSoL187h7FQfz8YPfh9lKX4oaIOFtB1tIVc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WtuoUA327PTk8nb1tY9pzrYG8ByXdMyJlmBcG+hL9PpFt5YoG0YJsiUu0vQQtLTKbFlAWPGbaRcor6B1qZaOroIw1aPSZv9dUJOtRyvjusDYjg1JKlXOGGeuMiidpfSm1AErnVJHdksVI1ycPVzBhhHyiEUWenhcATjgOTUJNOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gaEfJ6OR; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSSG8rBO7csvAiW6lB4PLRitfe+UTF90n1S6aPTOPCi/BsRbb4jdk8exvwd9gu6WaF5aor+2uIMgqx3VGdrZAAADbkHgRrZ8/AIkZwNuCtzmhSTNtPkwOPGA0dq35slyNQ8hg7HurQmpHtPu4GL7Vk8+ra7IkCTxySsmi8EgI1vrGh9OtTzld1Rx3wTnNYtJUP0XBeEmrGgQzGWHQVuIfQoECHh87dCwNX0wWB7p5iGYaFxiNaIkTKos48BlxsdeyUZrSV9UbcnnF6YTtI6dAKxAW+wCCXzF71ckbEigy8GexO8JdsJo8L0JkFbkQSpBOznsSRDUdHk+Wzpg89Jn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CgDu6acfleW8FoSfw5k0Pp6/H1OfyepPEamQAsPJUE=;
 b=MZS2RVRS3tvT5Ff8cSOooSg7huyF4KCFxv+WsFnqw0dR0/+vnKXoc2EW+IBp7yXHdtfXXbbT/+1JXuB7/0eYryf3V8aPsmJBo64OXCKox3bCOWBsm76qkOrbEBcGLUPDC0yOiLqPcJMHegGHFEGgSQwUh0Nzb9Tdlk7SWwyVyRUeUMHaFH90B2TF8TFF6cNJz03DLgaVBqmnsBsrsCNSUQiDmZ/pDjbe4onEVKEjkQTEVeMJlKcTeEIvpsubfchTtgxLRrP6g4DByFRgufxsBQxn0eGOQYly/wxdFJGPNO3DBDw6EXctRr3vxKarI6P40iRDTwv8XE06f1WGIJd4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CgDu6acfleW8FoSfw5k0Pp6/H1OfyepPEamQAsPJUE=;
 b=gaEfJ6ORXw9FZ0EmQwVUtXuJPP80ByYBIixfR9QDZcgenCRrbORbIEbvjSBd1RovtR4wFv6Qkzq8FMwrk6QSkh/wHxERS4KFC01ZwSmnQmEIHG2iE9EjuKvN5K4Iggz4OKlT4EgnDkthAWVuaSOpDN8pglJVSryBEzqzvUyN8O9w0Pev0YLuWZLb6IBFyH71pTsgjPiURT3HUNbPbYVbp66XuFVRzLW6IHff51EV5pFU/HbnjXpURNnYXsWwSU5xFTVbAt/ZSfPEsvNqG4TpTIWJvmmxZzq30mHLjv/HH9KyGj8RKfJRkhN0Jt9wwbgwCrKYZLY8m+L7ACrNKglE2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 00:17:02 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c%4]) with mapi id 15.20.7339.035; Fri, 8 Mar 2024
 00:17:01 +0000
Message-ID: <247ec113-ca48-4b95-b714-73a35e7b5802@nvidia.com>
Date: Thu, 7 Mar 2024 16:16:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 net-next 1/2] devlink: Add shared memory pool
 eswitch attribute
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com,
 tariqt@nvidia.com, yossiku@nvidia.com, kuba@kernel.org
References: <20240306231253.8100-1-witu@nvidia.com>
 <Zel8WpMczric0fz3@nanopsycho>
Content-Language: en-US
From: William Tu <witu@nvidia.com>
In-Reply-To: <Zel8WpMczric0fz3@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:303:b6::9) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: aaeccb2a-5962-4579-8d85-08dc3f05137f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7VTM+45753/OvywnGzBSB9vS5HOU5Q/8c4jHCtobwSR75PUDl6yFghMRTggP5D+qD9aPJbQN4B+zn+5Iie3lWovaYeUElXD81hIwnakzQhsmnWsXfLKc/JHh/M+8KFM9cOgWwlXYhF6600wwJUcq7jy2d6ghwKK7eyKtcKiSIGu2WPaxcN7TH2zf0fpFl4v9g5KchCKxd2QErpapOgklePvPivVK7uMCK+Fqyblr4wewvS+fcZzIQrGl2IDkreZYh9z4B7IuTwgJuJ56NIrj6jj5MgYcE6olfS8yrYCzMj/qBF8UDg/8kwr9Y+ICsw87OH6litib+nXQyeMX4DutV4enkEMOW5MRtu8YtEYIXFA7UvFK3Bw4hLtnyjmgqja37wuEzIa4wD8Ya9fvtBM9ag9r8B9Fh3qly5A1obQuNzwW64zpulC/VcrquDeN1CCrv63pl8jnpAW7yfA+dRXfwOxWJohnrhsSg68vE2Xyd0x0H3jjpJzggC6ka0jKqACXxF/ED6rTdiDIuGwL2awN+rOdmjMZucXl0SukT1cy8kf3Yl2TM3Hh0QBMqopvjM64UibtE6nA8SamVkZWdlHypilHno1lUVmII9QOzvrWNkG/7EwlmRqzAwGX7Zng6WgtQGlkQRk91dgPQKqKsVURz12zXNV8OS4PgGPNM7gMyO8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTV2U3RiTHp2NU1lb0NrWDNBMEF4L2pSYmNPcSs4WTUzZ2RzWDlwZjVMWUd0?=
 =?utf-8?B?R3hYaS9Mdzd2QlkwRVg2VER6Z1FyazdSNVFMdnpZQVZpRkZ5S0xUcytvMjZv?=
 =?utf-8?B?bXY4UFE1MEtiYTNlK0JXRXV5QnFCaHVFZ09kem52N0xIbU9YZ1JFWS9VMjJs?=
 =?utf-8?B?c00rMTUxTE1Ka3VQWXdTVllQbWp0WmxCYVhmQjEvSEtoQ2FCaDloQ3d4dmlx?=
 =?utf-8?B?T2pXbWUwVnF0cGo0K3NheGtnbzVXdUhRd1hBM2szL1JLN3VQbHlSMFJlV0sv?=
 =?utf-8?B?aFZIZHdwQy9zcjdsSmtLVGIrK0xNQkdUL242NjFCVlR2NjR4dnliY0lvbmxp?=
 =?utf-8?B?TDVnKzRnUUdtMmdPZERXbHBmV3NSQWZvbFNnMUt2Mnk2ZzRneDhLYUFJdXJW?=
 =?utf-8?B?MXpRTFhFWnZFYWh0L3VEUVdWY0wvajJwVVN6U0hGbWkyeUJiVVBSWmZ5RXBY?=
 =?utf-8?B?bU5oUXFxUlZYOUJVbHNIQmFUa21CdzlyZ2traFJ5aWNTSEs2YTZIS0o4Q2Ex?=
 =?utf-8?B?bktYMFU5cUFJR1dPeTNxME5RNitwQy9nK3N2d3FBcHhzZzRyZHpEQkdDRndI?=
 =?utf-8?B?RC9mQkU1ZnUwcUdnOTR0aWp3a3IvMlYzNG82ZmtES3ZBWVFUcFRlM1lTbVNa?=
 =?utf-8?B?T1N4WnBtSS94VTRtMTRyQnZlcllPV3pSQUpvNTB5bk5QUDlyVzZ6OWJHbXIz?=
 =?utf-8?B?N0N5eHN1MFJJTENQSHpOVDdoQnp3dWxYNUF0dk9QUFBnQkZsekFZZUpzVXd4?=
 =?utf-8?B?TThaVDV0eUNSUjJHS3FmVGNId3hGdmkrQndEZmJVck9XSS9WeXVwYU11V0JZ?=
 =?utf-8?B?ZnI4andLMjJZNTN0bXpMdFRVRi91V2o3R1JzdDNlemZJYXdvSXEvT1ZOR2dk?=
 =?utf-8?B?T1prSjFFMUxoc05XTTdEYUxQUmxidTNVY3pORk9GblEzT2VCbnd0WE00cmw3?=
 =?utf-8?B?SmpNeFVLWXcxOERzSGpicVFWRThiWldEVDhUUGxJRXhhajlqTkpJQWkzV2RY?=
 =?utf-8?B?eHpCRFhQcUppemNSR1RnRHFONFJIcmhpTjZrb0Y0NUlub0pxdCtLRlQ2TEoz?=
 =?utf-8?B?d2sveWZDc1d2THVlYmlmTWZwaHp2NFEra0dKR0xRL2lNV2ZNODRROXVkNmMx?=
 =?utf-8?B?cTFhMXZBNHYydWhQaHFBdVE3RUd6Y003WWY3Q3ZzWUdmRStLRnYyNVQ1Qm9a?=
 =?utf-8?B?d1ZGT1U3TkVZYVZzZk04OFBHdGxqTWtNVmViV0JnVHBUQzNIWWxYRVhkN0Zx?=
 =?utf-8?B?aXhPV3BSa2FqOWpVL05nRW80VDNyQlMyOVBJMWhvZ1NQM1hXandrWFJ5bEht?=
 =?utf-8?B?N01qb2F6S3lwbXQzZUxRRDgvWkhWK0VQTUxhS3pMdERycHpnaHExMUFZeit4?=
 =?utf-8?B?NTlhbGEvK2Q2SjdkeENOUWI3QlVzcWx0UjlIU1NLSlVmRkFabVVBU3hrUldQ?=
 =?utf-8?B?L1BCcmg2aFh1MEYxa2xNZmtDNkt6NlpPOVd3WlZaSHJLS01lMU80eStHd09U?=
 =?utf-8?B?SkZwekZxRWdjekhNcGR3SkZta3J1ekVXSlVveEdzSEFuZzB1MEVmUFNNSGtS?=
 =?utf-8?B?akUxTW1ENnRjSTYyeHJiQ1pBdVA4cU12QVQrZmYyb25jMVY2N3lMblpCRDBw?=
 =?utf-8?B?Rml6Qnl2cFJ1b05nL3BMQnZ0bm81Nkhoa1lydW9oNS9GaDRVY29qd2RZaDh2?=
 =?utf-8?B?YWNnWUVzWC9rMXZYVWx6L3JqckJDZnNhTjdHMGdwZFZyT1BDcWlLa0JmYTYv?=
 =?utf-8?B?S21ZWTBqeGhNUzN3cE1Nb2VmWmY3S1lrT0Z5SGxod1JKY1pzdkp4cWptODhx?=
 =?utf-8?B?OXNxUnNRSkdKdWEzQ3JLKzJjRzBKMVpyYjVzWm5hRUVLRjdTN2ZVcHRnRWZS?=
 =?utf-8?B?cG9VSkl3d24zWEwyYnlCczUzMWV5cmRYbEdUai9hWC9BSGhBU00vL1BBNG05?=
 =?utf-8?B?MWlOOVNOOU5rNTlITHBJUWdSZlVGbWlRWUl4aFBZRCtkR2JwazVxQ1VZcnJI?=
 =?utf-8?B?Z0JjVndLRmRKczZtMy8xc0VaS0ZrRStFWGdQK1dJckZENzlOQ2FnNEYyNk1y?=
 =?utf-8?B?S0FyNG5qRVNOMVNhbTQ2Y2QvaElGRkFCQzZ5V0p3ZzZ2R2Ird1NiSlhzeDJR?=
 =?utf-8?Q?Ki3rfegPyMvYsaH3SxTsbvbGq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaeccb2a-5962-4579-8d85-08dc3f05137f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 00:17:01.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4CxsYoyWQ9TXpe6geZJ1HHe67HlfNhmr79BJFnWtya/GwcL6DLbUs4Jv8z+90s6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448



On 3/7/24 12:35 AM, Jiri Pirko wrote:
> External email: Use caution opening links or attachments
>
>
> Thu, Mar 07, 2024 at 12:12:52AM CET, witu@nvidia.com wrote:
>> Add eswitch attribute spool_size for shared memory pool size.
>>
>> When using switchdev mode, the representor ports handles the slow path
>> traffic, the traffic that can't be offloaded will be redirected to the
>> representor port for processing. Memory consumption of the representor
>> port's rx buffer can grow to several GB when scaling to 1k VFs reps.
>> For example, in mlx5 driver, each RQ, with a typical 1K descriptors,
>> consumes 3MB of DMA memory for packet buffer in WQEs, and with four
>> channels, it consumes 4 * 3MB * 1024 = 12GB of memory. And since rep
>> ports are for slow path traffic, most of these rx DMA memory are idle.
>>
>> Add spool_size configuration, allowing multiple representor ports
>> to share a rx memory buffer pool. When enabled, individual representor
>> doesn't need to allocate its dedicated rx buffer, but just pointing
>> its rq to the memory pool. This could make the memory being better
>> utilized. The spool_size represents the number of bytes of the memory
>> pool. Users can adjust it based on how many reps, total system
>> memory, or performance expectation.
>>
>> An example use case:
>> $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
>>   spool-size 4096000
>> $ devlink dev eswitch show pci/0000:08:00.0
>>   pci/0000:08:00.0: mode legacy inline-mode none encap-mode basic \
>>   spool-size 4096000
>>
>> Disable the shared memory pool by setting spool_size to 0.
>>
>> Signed-off-by: William Tu <witu@nvidia.com>
>> ---
>> v3: feedback from Jakub
>> - introduce 1 attribute instead of 2
>> - use spool_size == 0 to disable
>> - spool_size as byte unit, not counts
>>
>> Question about ENODOCS:
>> where to add this? the only document about devlink attr is at iproute2
>> Do I add a new file Documentation/networking/devlink/devlink-eswitch-attr.rst?
> Yeah. Please document the existing attrs as well while you are at it.
done.
>
>
>> ---
>> Documentation/netlink/specs/devlink.yaml |  4 ++++
>> include/net/devlink.h                    |  3 +++
>> include/uapi/linux/devlink.h             |  1 +
>> net/devlink/dev.c                        | 21 +++++++++++++++++++++
>> net/devlink/netlink_gen.c                |  5 +++--
>> 5 files changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>> index cf6eaa0da821..cb46fa9d6664 100644
>> --- a/Documentation/netlink/specs/devlink.yaml
>> +++ b/Documentation/netlink/specs/devlink.yaml
>> @@ -429,6 +429,9 @@ attribute-sets:
>>          name: eswitch-encap-mode
>>          type: u8
>>          enum: eswitch-encap-mode
>> +      -
>> +        name: eswitch-spool-size
>> +        type: u32
>>        -
>>          name: resource-list
>>          type: nest
>> @@ -1555,6 +1558,7 @@ operations:
>>              - eswitch-mode
>>              - eswitch-inline-mode
>>              - eswitch-encap-mode
>> +            - eswitch-spool-size
>>
>>      -
>>        name: eswitch-set
>> diff --git a/include/net/devlink.h b/include/net/devlink.h
>> index 9ac394bdfbe4..164c543dd7ca 100644
>> --- a/include/net/devlink.h
>> +++ b/include/net/devlink.h
>> @@ -1327,6 +1327,9 @@ struct devlink_ops {
>>        int (*eswitch_encap_mode_set)(struct devlink *devlink,
>>                                      enum devlink_eswitch_encap_mode encap_mode,
>>                                      struct netlink_ext_ack *extack);
>> +      int (*eswitch_spool_size_get)(struct devlink *devlink, u32 *p_size);
>> +      int (*eswitch_spool_size_set)(struct devlink *devlink, u32 size,
>> +                                    struct netlink_ext_ack *extack);
>>        int (*info_get)(struct devlink *devlink, struct devlink_info_req *req,
>>                        struct netlink_ext_ack *extack);
>>        /**
>> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
>> index 130cae0d3e20..cbe51be7a08a 100644
>> --- a/include/uapi/linux/devlink.h
>> +++ b/include/uapi/linux/devlink.h
>> @@ -614,6 +614,7 @@ enum devlink_attr {
>>
>>        DEVLINK_ATTR_REGION_DIRECT,             /* flag */
>>
>> +      DEVLINK_ATTR_ESWITCH_SPOOL_SIZE,        /* u32 */
>>        /* add new attributes above here, update the policy in devlink.c */
> While at it, could you please update this comment? It should say:
>          /* Add new attributes above here, update the spec in
>           * Documentation/netlink/specs/devlink.yaml and re-generate
>           * net/devlink/netlink_gen.c. */
> As a separate patch please.
done.
>
>>        __DEVLINK_ATTR_MAX,
>> diff --git a/net/devlink/dev.c b/net/devlink/dev.c
>> index 19dbf540748a..561874424db7 100644
>> --- a/net/devlink/dev.c
>> +++ b/net/devlink/dev.c
>> @@ -633,6 +633,7 @@ static int devlink_nl_eswitch_fill(struct sk_buff *msg, struct devlink *devlink,
>> {
>>        const struct devlink_ops *ops = devlink->ops;
>>        enum devlink_eswitch_encap_mode encap_mode;
>> +      u32 spool_size;
>>        u8 inline_mode;
>>        void *hdr;
>>        int err = 0;
>> @@ -674,6 +675,15 @@ static int devlink_nl_eswitch_fill(struct sk_buff *msg, struct devlink *devlink,
>>                        goto nla_put_failure;
>>        }
>>
>> +      if (ops->eswitch_spool_size_get) {
>> +              err = ops->eswitch_spool_size_get(devlink, &spool_size);
>> +              if (err)
>> +                      goto nla_put_failure;
>> +              err = nla_put_u32(msg, DEVLINK_ATTR_ESWITCH_SPOOL_SIZE, spool_size);
>> +              if (err)
>> +                      goto nla_put_failure;
>> +      }
>> +
>>        genlmsg_end(msg, hdr);
>>        return 0;
>>
>> @@ -708,10 +718,21 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
>>        struct devlink *devlink = info->user_ptr[0];
>>        const struct devlink_ops *ops = devlink->ops;
>>        enum devlink_eswitch_encap_mode encap_mode;
>> +      u32 spool_size;
>>        u8 inline_mode;
>>        int err = 0;
>>        u16 mode;
>>
>> +      if (info->attrs[DEVLINK_ATTR_ESWITCH_SPOOL_SIZE]) {
>> +              if (!ops->eswitch_spool_size_set)
> Fill up extack msg here please.
>
Will do it in next version, thanks
William


