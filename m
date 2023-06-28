Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7740B741773
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 19:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjF1Rsi (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 13:48:38 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:24891
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229732AbjF1Rsf (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 13:48:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bd1fA4iqYuayxruZEl1G7HuBrMCL4I1g2DK0F5cRMIt0eaOzEhLxBqC0yZ8whWeYpIyH+/NoDUw5596kw+VleqAuccSpUM2AwI+XZYV3sQXeouge02BaayYKnOmB9EgdiJ22Z69zmYG/Uz+K4EyaPWUHrRjhMtEDUbMM+yJJemlRH8ytZYQqXHnhYwaHx0vO4FapuTPSzTZpc95DzVNgBpYTuOWfWJryNp2GqBiW/k8RWvaL2O86wVMg+lmjivj1YNtvut2c1xFFYTR93n21oIITqe/qpEjaunjHeW9aDPEPE/uk79AWB98mnqVMgPCq31uaWZEQR2A23WEZgfq/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sD0vzjlQBs5bO1J19+Lz2NHMNz7FQUbjBqpd86qeeYA=;
 b=RAkcgL/tugOqWDAOUzPVIfL99hK3XQt6OpIMVr/cpDQfLU13hM5GceegmFEuSxhOehfLIrb3xJS+YiTL90UQXfo+EteTXB7NhtokkCDI0ar6UjbgzvmxfqCUamYhjCezoSlaD/sXTmIKCTAkGVGc8IgpMXIGhHvGYpmQjVXSQzrP/wXl/N7Kyp4cCAJjWaAEsplEzhc5YDZscqXe6EbnF3W1YNPCzl2TSE70DNkD7IUyL6IskULR4CR5w3iuyaLvBocW4EhjeUjoH1Zn8tDcQfIXetFonrKFPoqFzHr7Yo4Wo18tySVUMPsWIvILfeLRj4Xaqkj9AAkc4Va9SnpxOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sD0vzjlQBs5bO1J19+Lz2NHMNz7FQUbjBqpd86qeeYA=;
 b=q/05xIruFvIbr80UVkRY5W+VwjDk+Np8MF7Oumu5e9V6R4ig9ACLmu9kgodcfpRaYhFsQ3XgysCypyEcGa0LT4vjscGukAtT38EXSMstZVWKXvEBTaMmuT4EZm7pSN92YBnmZORyZN9iF6F1d7IfWwa0k9cUuUGmd9N6HGj01j+XOYslTB9fPnCQtyKwwZtdKWgSqgH9u8twAJbpNoshVH5oNngfgflXtBScVsMappcRoMDnrRoi0vFPb9laqivtByqMiemKLLhT07PiLCy6vbKuFRD7mTqBKwPM9jv+ZDznq6lKswxPOphwe4hd+htE2rogRASDzxyE8g+OLTTiRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MW3PR12MB4505.namprd12.prod.outlook.com (2603:10b6:303:5a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 17:48:32 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 17:48:32 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        Gal Pressman <gal@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>,
        Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH net v1] ptp: Make max_phase_adjustment sysfs device
 attribute invisible when not supported
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
        <7fa02bc1-64bd-483d-b3e9-f4ffe0bbb9fb@lunn.ch> <87ilb8ba1d.fsf@nvidia.com>
        <0e82eff0-16ba-49b0-933d-26f49515d434@lunn.ch>
Date:   Wed, 28 Jun 2023 10:48:21 -0700
In-Reply-To: <0e82eff0-16ba-49b0-933d-26f49515d434@lunn.ch> (Andrew Lunn's
        message of "Wed, 28 Jun 2023 16:35:41 +0200")
Message-ID: <87ilb7qxzu.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:180::19) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MW3PR12MB4505:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f29ae7-1250-434c-dbff-08db77ffe38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8UXaIPn72Q5IaqlKFta702tv9GjGyhqEbjLCff3Af5Ap5qL4AKNgv7Qcp5GTIpEVnYtEh++JMJ4bIAkaSHkzIMHe+DGLUjQ5BgukIfRPNoyYmaCeYsMcEYlpstGAlGsxGymM7f62NC/A/rYk+EfqcLXsGSs+jkvf7JmdgAYo4m6BlxHHdDQ/LFzWrRiih1b1A3cGHqZyzvLzpogalQHmkhuOdEHg5X1FS+TVKZ3YWvAH1jKJ0xbpjtBrkkf+YX76/z5/FEpcGXdLVgZS7F3Ys7H1EU3x0np0dxlOD/hqs9AB+qUjXbsyQuoe5zC0LaP62+Czz810GULlz7OGJg++tWh98T1LloItvPjzWYV3HwpLniZdVtoPH26Pty5HJRdVElrTViwzNf7rIjH0GVY6IP1hMfsiSFBDi3hqqbpGuCKIf9U7sWFrsMwD+PZXH2RNZilTsL/j/oYZl+yOSTap8uyemUdh/j+l+QUiq/IrZCx++LHim93Y0iCVtKxQFwLPAMkwZql695lJGoptSKwqp6GbMYx9/k6TQnBsl6FLwpiwUQ//ZkUk6c/8kAXOwwWAI0xVFbgTKWionmiqxFVCm42qZ4Kg5LKC52kSsB6xQrQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(66556008)(7416002)(6916009)(5660300002)(36756003)(66476007)(86362001)(8676002)(316002)(41300700001)(38100700002)(8936002)(66946007)(4326008)(966005)(6506007)(26005)(6512007)(2906002)(186003)(478600001)(54906003)(6486002)(83380400001)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UiSJQGj1QLHf4j06S5B6AqYvrb4JUbRMq/92a++sYVDir40oiEn4JGbD1ifa?=
 =?us-ascii?Q?JxTl/sXu8tYYq02JRjwS5piPApe8RQt0EWGIUQJWxNJDjTpp7l5bg9H1GzJC?=
 =?us-ascii?Q?BdVKcpEwUtSISboCPzhmvImMt5tWWae+XZYtxDfICqvM2yhEcSEjxxMG8AbZ?=
 =?us-ascii?Q?u2kYF3xiQuWtq0VspmAkUjqUmb5nQQ8R2iUF1HxeeDQzSOCy1eR2FUPnmjrn?=
 =?us-ascii?Q?/cvK2eg3wgFH+qkuLAp1VwBfNr4IQZFJLcOBhvofpd/ZZOdig6WB1T/GBFne?=
 =?us-ascii?Q?UiCxu5l/PXyhvnXifDji+bT4uOXzuu4B2rS4Qvqw6UWA0LHpG8fcR5CziO5d?=
 =?us-ascii?Q?2Dv/1x+sMItYB1GsG9LjusW9vtteEbIVi43emluxoheXXgjug11KTItD5/ec?=
 =?us-ascii?Q?V1XHQRaRkZsHGJ28hrVMoMMVi2LlY64cuP0/PD4g/4D2BrJgFuxycRanJp1B?=
 =?us-ascii?Q?/T1PlxNAfAaVEBo0xrvlt9R2xM+jrLGBF1/OWxHwYTOFds1EV8kfL/QnRsUt?=
 =?us-ascii?Q?OVX3NQAaykNbf0E1KG9WMRgvfWbww5VQQAZZ73hVgl7TDiHpvDQnB2R7bJtC?=
 =?us-ascii?Q?MIx3hOy0RsJTc1dn8ke7HIYdUKeYomygux6jTMg97+rrICQUKZUqwIpaj+IE?=
 =?us-ascii?Q?vLdRZXUswhc17Oe7Oxuu30k9QM9py6IF19XMsngOS3bfS58RVDfSPacVZoUM?=
 =?us-ascii?Q?mzCWfbzDUf4KJ4FQP2m2NWqbZ+hGII61LLPqacBPxZlUjmg76nlfJ7O0JWai?=
 =?us-ascii?Q?N2SQnhCxoWg1pVywyq6EA0tXK5NZonU295HIXpcivN22JgKDbRJhfXXcz6Z6?=
 =?us-ascii?Q?MbmXGr3PTmzU9WXuwMfxi2sy5FdwsxccvTpJKPye6mUhodpw/uDcLsEip0FL?=
 =?us-ascii?Q?/66MQpz+QbyKGcyTZzo9RhJZpU9TFdDJEoiazzwuLRZoQ81dx+K9ucV42+DR?=
 =?us-ascii?Q?k659IvTID9IhPEK3dWAgzoj2t9GlJW9nJoNqWrb7Vdn4grg4RYszhRNQCQ6C?=
 =?us-ascii?Q?bacwJCMT4wjSYm5FJvYCUcUCDnxMt1KjC2Czdf3hznLl+Kel6QZ05PNRVwHp?=
 =?us-ascii?Q?mgHZs9KKyO89XjSHGs0l9t+511BwIFftkqbSejimcuLzucawTk6paOz83s+h?=
 =?us-ascii?Q?c9aNFJETIBd9qmA6LdAHgiwq97QYesTzizJOPBEVA/2P2ztuEeVk9AzzVruw?=
 =?us-ascii?Q?ZhSvlgpZlySUKKSH+Njog3Uwy9FxgwF2WlAEgCV+ZcYSo6WU6Bl3OP757kwq?=
 =?us-ascii?Q?sPoiGLeNCbE8WEEFZeD1M3tCRr+rU/pTUZiLDrSee4wBoOZBjFmgMERL9hHT?=
 =?us-ascii?Q?Jf+l9aAfuiGZ1fB7ExtCCyiqK7IXjfsnycMP7NEIjbCXxX35N2nG+VPblpx4?=
 =?us-ascii?Q?jDQ819vCkZZPOg1jYoY1EfMP+7gZjysYwLVYmizykNKix6By98SQVS3qv4N7?=
 =?us-ascii?Q?s95gSnsUm4eMsXMdCpQFKGXLdcsyckEJyAXIiykOlqaHfkK0ZJCXzsYma8zm?=
 =?us-ascii?Q?coe8V3jOfpSecfvoW8cSGtp2NZIQXEa7aIK4PE+lYZJa5wvDKU5L0rr0LXEF?=
 =?us-ascii?Q?FrJ3QM8V19+BHqDe5tXvpofDTODCyAAZ7Ko3W2hdyCX8F0Ex/Mm21p4kz9xg?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f29ae7-1250-434c-dbff-08db77ffe38e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 17:48:32.4060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wt8VLIH2ZmZTGGi7zkiNu1LGB9ZR9dMtbn8BExuHv7G0slB+MSwAES+sWBmDzWXEhYcUwAsw1X4191NX2g84mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4505
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On Wed, 28 Jun, 2023 16:35:41 +0200 Andrew Lunn <andrew@lunn.ch> wrote:
>> > I also wounder if this really is something for net. How do you think
>> > this patch matches against the stable rules?
>> 
>> Apologize in advance but not sure I am following along. The commit for
>> the patch the introduces the problematic logic has made its way to net
>> and this patch is a fix. Therefore, isn't net the right tree to target?
>
> Humm. So c3b60ab7a4df is in net-next, and the tag net-next-6.5. So it
> was passed to Linus yesterday for merging. You would like this fix
> merged either before -rc1, or just after -rc1.

It can be after -rc1. I understand your point now from this elaboration.
Since the change is not heading towards a final release yet but a
release candidate, it's not an "urgent" patch to be applied before -rc1.

>
> We are in the grey area where it is less clear which tree it should be
> against. So it is good to explain after the --- what your intention
> is, so the Maintainers get a heads up and understand what you are
> trying to achieve.

Agreed, I could have used git notes for that in my patch generation.
Noted for the future. Just to be clear, my intention is for this fix to
make its way before the final 6.5 release (before the changes make their
way to an end user since the NULL pointer dereference when reading that
sysfs node from a PHC not supporting phase adjustment is problematic). I
think the issue being present in a release candidate is a minor problem.
Would I still keep the Fixes tag however if targeting net-next? I
remember this email from Jakub where if a Fixes tag is used, the patch
should end up in net rather than net-next. However, I fear that without
a Fixes tag, targeting net-next would cause me to miss applying this
fix before the 6.5 release.

Link: https://lore.kernel.org/netdev/20230607091909.321fc5d7@kernel.org/

----- BEGIN QUOTE -----
  We'll obviously apply our own judgment but submitter should send all
  fixes against net.
------ END QUOTE ------

I personally think this fix is "worthy" of targeting net based on the
discussion Jakub previously provided, given the impact of reading the
sysfs node on a system without this patch on PHCs that do not support
phase adjustment.

>
> I actually thought you were trying to fix an older issue, something in
> 6.4 or older, which is what net is mostly used for. Under those
> conditions, the stable rules apply. Things like, is this fixing an
> issue which really effects users....

Right, this was caught before it made its way to general users. I was
basing targeting net still from the previous conversation about Fixes
tags.

>
>        Andrew

Thanks,

Rahul Rameshbabu
