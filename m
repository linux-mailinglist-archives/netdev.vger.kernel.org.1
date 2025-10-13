Return-Path: <netdev+bounces-228901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD076BD5BD2
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 20:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E406018A2F35
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD812D5939;
	Mon, 13 Oct 2025 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ESdzC60b"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B3C20125F
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380550; cv=none; b=qhlsXwkoWp9k7k8sU7yA/lDdv1JhXLY91FT3DG0/luYcHA/op20+rhIaYf6UpYP31xz2a2OApqJdg3iaVvTH4EQHi84Tg1vOue2Jq9BXqrmh9MVzOVsMePjaAYY/HhsPTt3uTbeeal5ghL4F/Vqkh8TwPdJ66mW/Ye+spmfTp8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380550; c=relaxed/simple;
	bh=UEna29x+bZvM/HBkGwx99n7Do7hLh1lgHFSn0I3czRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0lFfSB3ySOOu992W2Bu0oGIEz/hKFXqjZKfkcaSZbg4EYBu7jbrfmmXIBx9S6zWo+zYJpCNg8SKoDXWK4ppcsM09ckSNvnYDMjHqmSFIN3S5YW0t08VtxbTpfryJebFnp+deb6AF/0zFZ/lLKJ9yJgyg6of8U/x4mFMHJoX8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ESdzC60b; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b7fa9c76-f343-42d0-9c47-6a1af0deea2c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760380545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SDPG4mzl5kKo6OO5wGMHX9VYrTxfUd0YtlJcr3KpwQ=;
	b=ESdzC60bmzAURLxbLw6YswPogINrWqARFYPhTfV9D8OD4JwnlV/yKsn5a+R3l7N1rJYqBz
	WFIbob8oV2fgIL3XvFz+W4nqbNBElvdrKy1XFLsHkmhdP5CTwV15kdwZVOtrMwZFJ9Cefg
	vXfs0gDkAOHhS0xoTp2ImFAa8WgwBSk=
Date: Mon, 13 Oct 2025 11:35:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] bpf: test_run: fix atomic context in timer path
 causing sleep-in-atomic BUG
Content-Language: en-GB
To: Sahil Chandna <chandna.linuxkernel@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, john.fastabend@gmail.com, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: david.hunter.linux@gmail.com, skhan@linuxfoundation.org, khalid@kernel.org
References: <20251013171104.493153-1-chandna.linuxkernel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251013171104.493153-1-chandna.linuxkernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/13/25 10:11 AM, Sahil Chandna wrote:
> The timer mode is initialized to NO_PREEMPT mode by default,
> this disable preemption and force execution in atomic context
> causing issue on PREEMPT_RT configurations when invoking
> spin_lock_bh(), leading to the following warning:
>
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6107, name: syz.0.17
> preempt_count: 1, expected: 0
> RCU nest depth: 1, expected: 1
> Preemption disabled at:
> [<ffffffff891fce58>] bpf_test_timer_enter+0xf8/0x140 net/bpf/test_run.c:42
>
> Fix this, by removing NO_PREEMPT/NO_MIGRATE mode check.
> Also, the test timer context no longer needs explicit calls to
> migrate_disable()/migrate_enable() with rcu_read_lock()/rcu_read_unlock().
> Use helpers rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate()
> instead.
>
> Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
> Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
> Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>

You have multiple versions in CI:
   [PATCH v2] bpf: avoid sleeping in invalid context during sock_map_delete_elem path
   [PATCH v3] bpf: test_run: fix atomic context in timer path causing sleep-in-atomic BUG

In the future, please submit new patch set only after some reviews on the old patch.

I also recommend to replace e.g. [PATCH v3] to [PATCH bpf v3] (or [PATCH bpf-next v3])
so CI can do proper testing for either bpf or bpf-next.

For the title:
   bpf: test_run: fix atomic context in timer path causing sleep-in-atomic BUG
Change to:
   bpf: Fix sleep-in-atomic BUG in timer path with RT kernel

The code change LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

>
> ---
> Changes since v2:
> - Fix uninitialized struct bpf_test_timer
>
> Changes since v1:
> - Dropped `enum { NO_PREEMPT, NO_MIGRATE } mode` from `struct bpf_test_timer`.
> - Removed all conditional preempt/migrate disable logic.
> - Unified timer handling to use `migrate_disable()` / `migrate_enable()` universally.
>
> Link to v2: https://lore.kernel.org/all/20251010075923.408195-1-chandna.linuxkernel@gmail.com/
> Link to v1: https://lore.kernel.org/all/20251006054320.159321-1-chandna.linuxkernel@gmail.com/
>
> Testing:
> - Reproduced syzbot bug locally using the provided reproducer.
> - Observed `BUG: sleeping function called from invalid context` on v1.
> - Confirmed bug disappears after applying this patch.
> - Validated normal functionality of `bpf_prog_test_run_*` helpers with C
>    reproducer.
> ---
>   net/bpf/test_run.c | 23 ++++++-----------------
>   1 file changed, 6 insertions(+), 17 deletions(-)

[...]


