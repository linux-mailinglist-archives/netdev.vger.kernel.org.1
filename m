Return-Path: <netdev+bounces-24601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7874F770C44
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 01:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D881C215D4
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 23:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D75253A3;
	Fri,  4 Aug 2023 23:13:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A28B1BEE3
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 23:13:53 +0000 (UTC)
Received: from out-117.mta0.migadu.com (out-117.mta0.migadu.com [91.218.175.117])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4E8E60
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 16:13:51 -0700 (PDT)
Message-ID: <626eb8ca-858b-680c-64ea-3d2b0a7d7908@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691190829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TbdFkKHnpHT+mEjg5xeWjaXSnAKns2iDiOkkob2h7U=;
	b=XbrMJK5QzfLhT9mtwlITuBYk2hu5URead0WvQjY+DJFBL5YNVT1KYSITfNpWwXc/pQiLky
	DuzPfrATq3CEYEqoaGRHluG+xopEP97jX0+FHQikpc4pkUzpD3+MpIUm937qmaBMew9eGz
	RERhTgUhwFIRTEMrmgciHVTCmmzCZG8=
Date: Fri, 4 Aug 2023 16:13:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] tcp/dccp: cache line align inet_hashinfo
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230803075334.2321561-1-edumazet@google.com>
 <169113782026.32170.17783946876020996348.git-patchwork-notify@kernel.org>
 <CANn89iKhp6ghj6-+n9RXvP-Bc33kOdSMSTM1KQj=WSQ2DhgPWQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CANn89iKhp6ghj6-+n9RXvP-Bc33kOdSMSTM1KQj=WSQ2DhgPWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/4/23 1:33 PM, Eric Dumazet wrote:
> On Fri, Aug 4, 2023 at 10:30 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
>>
>> Hello:
>>
>> This patch was applied to netdev/net-next.git (main)
>> by David S. Miller <davem@davemloft.net>:
>>
>> On Thu,  3 Aug 2023 07:53:34 +0000 you wrote:
>>> I have seen tcp_hashinfo starting at a non optimal location,
>>> forcing input handlers to pull two cache lines instead of one,
>>> and sharing a cache line that was dirtied more than necessary:
>>>
>>> ffffffff83680600 b tcp_orphan_timer
>>> ffffffff83680628 b tcp_orphan_cache
>>> ffffffff8368062c b tcp_enable_tx_delay.__tcp_tx_delay_enabled
>>> ffffffff83680630 B tcp_hashinfo
>>> ffffffff83680680 b tcp_cong_list_lock
>>>
>>> [...]
>>
>> Here is the summary with links:
>>    - [net-next] tcp/dccp: cache line align inet_hashinfo
>>      https://git.kernel.org/netdev/net-next/c/6f5ca184cbef
>>
>> You are awesome, thank you!
>> --
>> Deet-doot-dot, I am a bot.
>> https://korg.docs.kernel.org/patchwork/pwbot.html
>>
>>
> 
> Thanks !
> 
> Apparently this misalignment came with
> 
> commit cae3873c5b3a4fcd9706fb461ff4e91bdf1f0120
> Author: Martin KaFai Lau <kafai@fb.com>
> Date:   Wed May 11 17:06:05 2022 -0700
> 
>      net: inet: Retire port only listening_hash

Ah. Thanks for the fix. TIL.


