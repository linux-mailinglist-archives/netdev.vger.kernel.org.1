Return-Path: <netdev+bounces-35638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D067AA6AB
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 03:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E16E92821F0
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 01:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881D7391;
	Fri, 22 Sep 2023 01:51:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B26377
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 01:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5126FC433C8;
	Fri, 22 Sep 2023 01:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695347462;
	bh=tO499MJh0Rmss4aq5EkxYyocXf/RBJNFYcxNU66BgZ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DedHTISbGl1Riy18bkpDUE2V1L8tCAl347+qvXyDNjcqd6UoXQPkXJ/T6hLBMCPdh
	 GQHrEdXGfqqInls/ng/5jvcyukR/1kpUN2L6M7JaDGd1Om913kWjs9EyHORdrViNQc
	 9lf5etLiFOUw9tWjUS0d85P7/uHrycgcG98cFeO1b+z0hjtO1rJc8+t8icXqcCt0lK
	 NFs6pPuMQOQOvHKbwp2sRbqi9N0ee0AYJ4vVSM5UyXRJjk1zBZ8tmev8LlD2n6ka/6
	 eZEuzD2I8YXE0rBxgEaf5VK74NicMJHFo0qOfKofFhk2d8Ps+wyAx+Acnb7cpYsCXR
	 7wP1qJrTSBb8A==
Message-ID: <e49bcbc4-b7ae-66b1-4964-957983688426@kernel.org>
Date: Thu, 21 Sep 2023 19:51:01 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCHv3 net 1/2] fib: convert fib_nh_is_v6 and nh_updated to use
 a single bit
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>,
 Thomas Haller <thaller@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Eric Dumazet <edumazet@google.com>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, Ido Schimmel <idosch@idosch.org>
References: <20230921031409.514488-1-liuhangbin@gmail.com>
 <20230921031409.514488-2-liuhangbin@gmail.com>
 <21c58c78-1b76-745a-0a12-7532a569374b@kernel.org>
 <ZQzuB00CJpr51C+N@Laptop-X1>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZQzuB00CJpr51C+N@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/23 7:29 PM, Hangbin Liu wrote:
> On Thu, Sep 21, 2023 at 07:03:20AM -0600, David Ahern wrote:
>> On 9/20/23 9:14 PM, Hangbin Liu wrote:
>>> The FIB info structure currently looks like this:
>>> struct fib_info {
>>>         struct hlist_node          fib_hash;             /*     0    16 */
>>>         [...]
>>>         u32                        fib_priority;         /*    80     4 */
>>>
>>>         /* XXX 4 bytes hole, try to pack */
>>>
>>>         struct dst_metrics *       fib_metrics;          /*    88     8 */
>>>         int                        fib_nhs;              /*    96     4 */
>>>         bool                       fib_nh_is_v6;         /*   100     1 */
>>>         bool                       nh_updated;           /*   101     1 */
>>>
>>>         /* XXX 2 bytes hole, try to pack */
>>
>> 2B hole here and you want to add a single flag so another bool. I would
>> prefer the delay to a bitfield until all holes are consumed.
>>
> 
> OK, just in case I didn't misunderstand. I should add a `bool pfsrc_removed`
> here and drop the first patch, right?


yes.

The bitfield has higher overhead. Let's reserve that overhead to when
there are no more holes and a new field pushes the struct over 128B.


