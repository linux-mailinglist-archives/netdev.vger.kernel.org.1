Return-Path: <netdev+bounces-46923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6757E714B
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 19:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2298A1C209E2
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 18:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA28341AC;
	Thu,  9 Nov 2023 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DBQjH57e"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1829330322
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 18:19:32 +0000 (UTC)
X-Greylist: delayed 576 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Nov 2023 10:19:32 PST
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBD21FF6
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 10:19:31 -0800 (PST)
Message-ID: <11e2e744-4bc7-45b1-aaca-298b5e4ee281@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699553393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+i1XoVLmgrvkP2MiYW953YAIB1lEyaf4e1N1W5RcvHU=;
	b=DBQjH57enkpPK0kzCojOpPQc9yMRxEWWxKb7Z7VJ2Fg1KVuZBL+keheo5yShwEdhi7Pp06
	4/N9gGeAm7646xxn0/jhh/p9FjBecI5G7aSWYErCGrSYLRSFBwyYFrEQoN1kozqy0osGNU
	W40kqlOe6WZre6QGg58biFDenAMNieU=
Date: Thu, 9 Nov 2023 10:09:46 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [GIT PULL v2] Networking for 6.7
Content-Language: en-GB
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao1@huawei.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 yonghong.song@linux.dev
References: <20231028011741.2400327-1-kuba@kernel.org>
 <20231031210948.2651866-1-kuba@kernel.org>
 <20231109154934.4saimljtqx625l3v@box.shutemov.name>
 <CAADnVQJnMQaFoWxj165GZ+CwJbVtPQBss80o7zYVQwg5MVij3g@mail.gmail.com>
 <20231109161406.lol2mjhr47dhd42q@box.shutemov.name>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231109161406.lol2mjhr47dhd42q@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/9/23 8:14 AM, Kirill A. Shutemov wrote:
> On Thu, Nov 09, 2023 at 08:01:39AM -0800, Alexei Starovoitov wrote:
>> On Thu, Nov 9, 2023 at 7:49 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>>> On Tue, Oct 31, 2023 at 02:09:48PM -0700, Jakub Kicinski wrote:
>>>>        bpf: Add support for non-fix-size percpu mem allocation
>>> Recent changes in BPF increased per-CPU memory consumption a lot.
>>>
>>> On virtual machine with 288 CPUs, per-CPU consumtion increased from 111 MB
>>> to 969 MB, or 8.7x.
>>>
>>> I've bisected it to the commit 41a5db8d8161 ("bpf: Add support for
>>> non-fix-size percpu mem allocation"), which part of the pull request.
>> Hmm. This is unexpected. Thank you for reporting.
>>
>> How did you measure this 111 MB vs 969 MB ?
>> Pls share the steps to reproduce.
> Boot VMM with 288 (qemu-system-x86_64 -smp 288) and check Percpu: field of
> /proc/meminfo.

I did some experiments with my VM. My VM currently supports up to 255 cpus,
so I tried 4/32/252 number of cpus. For a particular number of cpus, two
experiments are done:
   (1). bpf-percpu-mem-prefill
   (2). no-bpf-percpu-mem-prefill

For 4 cpu:
    bpf-percpu-mem-prefill:
      Percpu:             2000 kB
    no-bpf-percpu-mem-prefill:
      Percpu:             1808 kB

    bpf-percpu-mem-prefill percpu cost: (2000 - 1808)/4 KB = 48KB

For 32 cpus:
    bpf-percpu-mem-prefill:
      Percpu:            25344 kB
    no-bpf-percpu-mem-prefill:
      Percpu:            14464 kB

    bpf-percpu-mem-prefill percpu cost: (25344 - 14464)/4 KB = 340KB

For 252 cpus:
    bpf-percpu-mem-prefill:
      Percpu:           230912 kB
    no-bpf-percpu-mem-prefill:
      Percpu:            57856 kB
  
    bpf-percpu-mem-prefill percpu cost: (230912 - 57856)/4 KB = 686KB

I am not able to reproduce the dramatic number from 111 MB to 969 MB.
My number with 252 cpus is from ~58MB to ~231MB.

I appears that percpu allocation cost goes up when the number of cpus
is increased.

I will continue to debug this. Thanks!

>

