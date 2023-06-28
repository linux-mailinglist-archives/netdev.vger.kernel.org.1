Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA3C7419F1
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 22:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjF1U4I (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 16:56:08 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:15243
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231264AbjF1U4H (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 16:56:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrY2yBL9wtV6yZ7ZNlKGI/3TrV67+o5HjlfCDoRfxRuDKY8KqglNRPzIbzrbPuFEynGs6eanYdyUQZoBgE1Eoadjm6AJUu7pKlo9M1H6qJ4oCgSNQzPn+NZGEr6DtLS3WVFWQUc/rMpzLC0GKXxQAnvM7oMpjLaj4HVdRgQc3N1krQNxNUtq7BMezFy8oj4FWSeQrheZBQ4q7B8pMCO+UMLnz5QscxmI+SxTxfXCGLKUXrLa9j93HieynwTAfvHYu343JfmrJlbZmb43qt0QnuAEyOSlYVgMMSfzeLVSWceIWr1xHCRDDJMwkdkSUpLfnpIybwjKTbXAe9JVzlFj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85qezXd3+y5rKiwAdABgR4CYpJYpfQruIN77HrdY4i8=;
 b=RgZoxH4jo8xL73SwBKfF5Ez4EbUe71GnAPBFWnphMB0nL6u0lSNqRjuIa23UOLJYzCoKW6bTHmLs+7/u9Fqs1o9r2MPhvxO0HyLudno91VrlSM1f/9Xi5jZhSuDkCWBlY5sJjQRGd92MpquyXpxbwKdcBJLUVA434J1mapGiTwq/PFZ0+njSXB7B9DRuyiM87IZz77jGe9oIOhcCzU2qFYEYnARy8Cb67cHjZejjKdP5aH3imvGIEuo6rnddBTciOr2tWUTYxo1rajsKttJt1o9REVM2tx5absb5pMrFVtpEXG25nqedQ2CVOqSudC5+2x4xoZCNrNjcSknF2di93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85qezXd3+y5rKiwAdABgR4CYpJYpfQruIN77HrdY4i8=;
 b=IV8qG8xzE0UZah5TQ6L9wDlbrMEARQRXLYEUZenEoAKg/z+6sr6KCNSs8valMCxMBLg7B+6wMoIVj0vfod8r5FjEbsQ6hEhVKCQEq7V3NJ+ATOh1ZJ8oinpidaTWvFYCVlzxX/+ZfKH7QIlkt82ChcRV05DVxDdWsBqLUXbC+YMtKSJSCKPJLIjOnZsJ5DVh26R7VetjxKwfdvfRJlojeOcYWPXKX/ED5UMAFa/H+p74+zh1uPe9viQnzSrNmroqVGrAnWgDKCP+qvceUyooNFGB62yKo42LXY6G2axMsywgzZ/C2JdLk6P4Sq04VVjbOvmSdoUPsA0ghxkyWSH6og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH2PR12MB5018.namprd12.prod.outlook.com (2603:10b6:610:6e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 20:56:03 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 20:56:01 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
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
        <7fa02bc1-64bd-483d-b3e9-f4ffe0bbb9fb@lunn.ch>
        <20230628133850.0d01d503@kernel.org>
        <06f5c065-2c6d-4cd2-9699-89f05443f137@lunn.ch>
Date:   Wed, 28 Jun 2023 13:55:53 -0700
In-Reply-To: <06f5c065-2c6d-4cd2-9699-89f05443f137@lunn.ch> (Andrew Lunn's
        message of "Wed, 28 Jun 2023 22:46:32 +0200")
Message-ID: <87edlvqpba.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::17) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH2PR12MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: a693b1a3-ec94-4689-15c5-08db781a14ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RgQ0WKoDz9X9ngJtzxEnyvIr6FCWqO+OnZIVdXpgr6gQzyNZ0Xqext+CAD5ovT6f0UHwYIIVR4xVfO2cII6MTIyG876MqBEsfncTmxkyC8D2obyy6SYMup0cyknWAh2aEwIM5OkFtBYKzLK/g6ZcU0lIV0FQg10jPmcWSGNrvufoyiKtaO/Bl8chGijR1ufQeD19JgFqBRAuuTCV0Fzv8CFc86zJARKY50GZUgMZOWOLHCTpEM2v+hsm5yqoLFoqRohuESdf+Bpnr6QNycU6fxtVwsHZfDsWAMQNUg+JF6UusPAhhiwnBW4lQcjjQO6JNJN/U14HvLk19xo1rv4g99LQ1d3W8Wazxx345LXWqvuZr4kBk5Vc/XGVORed9Ok48qCxJrFOaEcI1b/cM4d/cP6aPfKRSXlDJrCn3x76InY36GCrwmy6VLJ2at1qtoxV8h1WIlc1vIQUZTCUX7dczdgke/29T2hFtgWW+2Qf6/vXNFDbex4phnbSMB2lQm7IGsHDlQRG0gvc4vmaVNF7aBk5vRkpFMZ7bKgFDOWT4MUbB9y+QhF8A1yVqsfjdB+o8MX0OFcAeraLmkC1O4CUhB88ZacI4R4UOamLVx6J7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(8676002)(66476007)(66556008)(8936002)(41300700001)(316002)(66946007)(6506007)(26005)(6916009)(186003)(6512007)(966005)(54906003)(478600001)(6666004)(2616005)(4326008)(6486002)(2906002)(5660300002)(7416002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?74Y/yBL0GUfzv5hIGcNmBZVYi10N1LTi0wgVNGhLV9eb1AAuq7u+unb0wgsg?=
 =?us-ascii?Q?7JmkXU/w5ODuelEGYzG8d8DHGDTfLhe6RpVvAw5viQErB6+V8LemzMQoGsxN?=
 =?us-ascii?Q?l6JxnP9kqh+Ft3rs8aAPYQgWCCFl14zBK2BtZHB9orlgZFNQoMs9gkrCRuDI?=
 =?us-ascii?Q?vJeJ8l9ZVgtpYXPn6XTjrg2I2wHAuDA4eDdaM36hty5QOp4gOmffE2MGP7RP?=
 =?us-ascii?Q?QsaHZ7TXAS9tzhXUVf0CTgFWwgaVXAxtlCJ/FxI6jtbmEHl6JQQ3iEfTfew/?=
 =?us-ascii?Q?ZsIaxgWMtQtcxmSgoeTjYuohyD5RKgiOoKBAIn9kU9slDZKxIJWgGf/XZW9k?=
 =?us-ascii?Q?ymIwD6enm9cR0fDtr1WKgKIKKUt92qmb3KThzpKgGi+Yuyq8EhKHESnz9ZXT?=
 =?us-ascii?Q?XoAFOlmDPTsq4kq1OQhibDY1H68ZGtCPph3zH3Jx6pH0ONJceaJWVmttyuGH?=
 =?us-ascii?Q?hGY/U+A2M8ZpbMggSk0+oZLnyhHoLXVz+WgtSNBQHktfcBCI1ZO/KsSOgfLp?=
 =?us-ascii?Q?mNqeImknVbSXqvInlPqsp/PV8f8neFfEkhQ4nFO1WQ467+NLccXRolsgTFS2?=
 =?us-ascii?Q?0YOytiI2alvLiNsn6gLiw/AKWfYUdD02q6iF3UoQ1kFSY6HOFAWT6JYbqSds?=
 =?us-ascii?Q?0a5LWUqEKsqBg5SJyn3PVeCZ7ts3LZXC6j2chOLpvsuY8LuDl4Sxv1wZsMdP?=
 =?us-ascii?Q?xD9YkxF8uCg51PKzrl9qOcf2Z98GjWrYm7rkOYvvZn6bfEonvAoHomMYjwwU?=
 =?us-ascii?Q?QtiB4AJm4y126u3HJ5yqiPYGiKR7iGQU6n3nkXD5T8k0sf0yMAx+6ertkR0h?=
 =?us-ascii?Q?FtkgkdEXw4ShaeJLyrY+IQX2/r+zB6Aik1jfoFyuRTj2I5T4TGSvcgTOQJ24?=
 =?us-ascii?Q?BjtIJCJn9yx12+Y2An8XPIQ8o5oT4wg3CXLoS62DY+kmp2Xtfsl89eiw8Ulf?=
 =?us-ascii?Q?utXY7Yb+O8xE/JfZMr0JAvftcSnfPE7pV8Vs8OVUeaWcgsas8W8XqYxBUCc6?=
 =?us-ascii?Q?XPxJtf0QAKUniD6A6ah+hABLZj8/DOlsUXKiQBpBbILybHlfpr1vKcHn0oFY?=
 =?us-ascii?Q?+AQpzDrSiyYud0NnfnaBGA5HyzUSoKh2iUHJJkeHshvtix9wAFHJFIhMLRhe?=
 =?us-ascii?Q?Tmm7jAEzAuv3JcuikYeREf4pdXm7/2zoT31YoA0T5cHv48x7hMsKW7XwKhkK?=
 =?us-ascii?Q?UdvklQNELfzgVjwU3VAx/zZBnUCE7nfLLkzVaQEpsF0qIwdt0sL8cFBh85w5?=
 =?us-ascii?Q?fI16bK1GSxYSWo4F0b3kyVU/aW5/9HuZngmsELnXoUWNXtNk4rjihiSKo1me?=
 =?us-ascii?Q?6Yxxqc43v/qUm6PQF6fkjcgV61TBDUglwvw0TKaKygUdA+1SNaxf6d+7mbZe?=
 =?us-ascii?Q?B2kfrwaAOXrVCIxJRjgFjnFgF/ZNh7xrpissW2I7i/gyytax2rlA0BQ/S35A?=
 =?us-ascii?Q?zF3/yXYszRbKM6vt/o1kXkhqz9o2mFj44R/jRcrIdm2E9tdx4pfuSIvrKAAn?=
 =?us-ascii?Q?UsZWFHQxmnm+sR/IqJXnPMcAMXkKbIeMzjcQnWS5SGUjus99Ia6QKoOYT8E6?=
 =?us-ascii?Q?FvZ+Lt0u43U05xBtjn/eDMNojy8q5OzIK5Pq2rQXlNKR/c+r42nyMi2C3y1Q?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a693b1a3-ec94-4689-15c5-08db781a14ad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 20:56:01.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmQ2BPK5Oo7DdHsvK+DXGoI2aEMMS1qYU5J94kTbtSFwd8TeBlZQkVhANGxxD/Y6025wAiz7wWNzf7aX2spiyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5018
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On Wed, 28 Jun, 2023 22:46:32 +0200 Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Jun 28, 2023 at 01:38:50PM -0700, Jakub Kicinski wrote:
>> On Wed, 28 Jun 2023 03:16:43 +0200 Andrew Lunn wrote:
>> > > +	} else if (attr == &dev_attr_max_phase_adjustment.attr) {
>> > > +		if (!info->adjphase || !info->getmaxphase)
>> > > +			mode = 0;  
>> > 
>> > Maybe it is time to turn this into a switch statement?
>> 
>> I don't think we can switch on pointers in C.
>
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/sfp.c#L749
>
> Works for temperature sensors, voltage sensors, current sensors, and
> power sensors. Maybe hwmon is different to what is going on here, but
> both a sysfs files.

Sorry, the only switch cases I see in the link you shared are for an
integral type enum and a u32. I do not see a pointer type being used in
a switch in sfp_hwmon_is_visible?

I believe Jakub is right about pointer types + switches in C. pointer
types are not considered integral types. Here is a compiler explorer
example to demonstrate. This slipped my mind during our discussion.

https://godbolt.org/z/nKr3x7cT8

  <source>: In function 'main':
  <source>:6:13: error: switch quantity not an integer
      6 |     switch (data) {
        |             ^~~~
  Compiler returned: 1

-- Rahul Rameshbabu
