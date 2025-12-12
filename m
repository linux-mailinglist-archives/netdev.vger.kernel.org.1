Return-Path: <netdev+bounces-244480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FA0CB8A08
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 11:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F07C0300E034
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 10:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BFE28C5AA;
	Fri, 12 Dec 2025 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuZVw6jT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC82169AD2;
	Fri, 12 Dec 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765535701; cv=none; b=d+HpuuNLQuNcZS9B0gPtGyVsdabeHJIg0JUxIMmWgvr5Zywh4YoH5fLJb8QrRb7LJawwa5L0DIrkOSEVj70+f2CSOnWRIkCAu1h2qA/jNEl1JB/foX8WBbWqalizugEVx1Tidz5pGs5ThZEq7H5Cvp6QxMSeZKrtl6QSDWiXvJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765535701; c=relaxed/simple;
	bh=tpoLmlWNdgfPUN+3GVk5CixxlW8xGaDG0EeFHjNwi7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1QYembsVbXOS991Nw6T18OGXn4zrVXyMxJl89x7eJYBvF1+L+hPh4syMgu+B+aI1YczUG4WITHF++9u5zLUElrzcOp7ymhpaT745rHx0//JFWba02k6RtZBojU9foNeHiG/fa28xgs8uY6/d88SatFQFldEmTTTum+jhx15tN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuZVw6jT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD031C4CEF1;
	Fri, 12 Dec 2025 10:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765535699;
	bh=tpoLmlWNdgfPUN+3GVk5CixxlW8xGaDG0EeFHjNwi7Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OuZVw6jT+j1cDhnrP9PXiRVBpZ7prSuT9DJPD4BnL+BrJhkYJxfY6DoZ4WwWXafKe
	 9v9I8nts41hdMjLoflTY2zxTuS48woD6YvTNmXdmagit1d56Mltzxcb/xEAMhQmksj
	 puqk/WcOB+iSdL+7G0jOHcdmSUltqXNa14sClz74oB5h9JbI5oBdkdv+IMr+4Iya6p
	 eGagb3N6JGnAX+o3rifssAxpNUq8OSUqeyMvCEPIEce/esa7FYVnqgh+zXa5d39LF3
	 cOWQwNxdPbC+BwgFpm4wxGGsppmDHuGfPmxRUneug7078kL0B7sK/3M3UjtCJoXTh7
	 no0j92tDuKHrg==
Message-ID: <87064d74-2090-4d0f-ba34-129942e60450@kernel.org>
Date: Fri, 12 Dec 2025 11:34:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] subflow: relax WARN in subflow_data_ready() on teardown
 races
Content-Language: en-GB, fr-BE
To: evan.li@linux.alibaba.com
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, kitta <kitta@linux.alibaba.com>,
 martineau@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20251212095909.2480475-1-evan.li@linux.alibaba.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20251212095909.2480475-1-evan.li@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Evan, Kitta,

Thank you for sharing this patch.

On 12/12/2025 10:59, evan.li@linux.alibaba.com wrote:
> From: Evan Li <evan.li@linux.alibaba.com>
> 
> A WARN splat in subflow_data_ready() can be triggered when a subflow
> enters an unexpected state during connection teardown or cleanup:
> 
> WARNING: net/mptcp/subflow.c:1527 at subflow_data_ready+0x38a/0x670

Please always share the full stacktrace, not just the warning: it helps
reviewers, devs later, and other people who found the same issue on
their side.

> This comes from the following check:
> 
> WARN_ON_ONCE(!__mptcp_check_fallback(msk) &&
> !subflow->mp_capable &&
> !subflow->mp_join &&
> !(state & TCPF_CLOSE));
> 
> Under fuzzing and other stress scenarios, there are legitimate windows
> where this condition can become true without indicating a real bug, for
> example:
> 
> during connection teardown / fastclose handling
> races with subflow destruction
> packets arriving after subflow cleanup
> when the parent MPTCP socket is being destroyed
> After commit ae155060247b ("mptcp: fix duplicate reset on fastclose"),
> these edge cases became easier to trigger and the WARN started firing
> spuriously, causing noisy reports but no functional issues.
> 
> Refine the state check in subflow_data_ready() so that:
> 
> if the socket is in a known teardown/cleanup situation
> (SOCK_DEAD, zero parent refcnt, or repair/recv-queue handling),
> the function simply returns without emitting a warning; and
> 
> for other unexpected states, we emit a ratelimited pr_debug() to
> aid debugging, instead of a WARN_ON_ONCE() that can panic
> fuzzing/CI kernels or flood logs in production.
> 
> This suppresses the bogus warning while preserving diagnostics for any
> real state machine bugs.
> 
> Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
> Reported-by: kitta <kitta@linux.alibaba.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220856

I don't think you should continue using Bugzilla: it is no longer used
for the Networking subsystem, and it might be shutdown soon. Instead,
please check the instructions in the MAINTAINERS file: for general
Networking issues, send them by email. For MPTCP, there is a bug tracker
on GitHub.

Note that you don't need to open an issue somewhere if you already have
the patch: simply put all the details in the commit message, e.g.
stacktrace, reproducer, conditions, etc. You only need to open an issue
somewhere if you need to include large files, or if you need help to fix
it. I know Checkpatch will ask you to add a link after a "Reported-by"
but that's only valid if the initial report was done publicly: in your
case, you can then ignore this warning.

> Co-developed-by: kitta <kitta@linux.alibaba.com>

(Note that a Co-developed-by should be followed by a Signed-off-by from
the same person.)


https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

While at it, please next time use the 'net' prefix, see:

  https://docs.kernel.org/process/maintainer-netdev.html

> Signed-off-by: Evan Li <evan.li@linux.alibaba.com>
> ---
>  net/mptcp/subflow.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 86ce58ae5..01d30679c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1524,9 +1524,27 @@ static void subflow_data_ready(struct sock *sk)
>  		return;
>  	}
>  
> -	WARN_ON_ONCE(!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
> -		     !subflow->mp_join && !(state & TCPF_CLOSE));
> -
> +	/* Check if subflow is in a valid state. Skip warning for legitimate edge cases
> +	 * such as connection teardown, race conditions, or when parent is being destroyed.
> +	 */
> +	if (!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
> +	    !subflow->mp_join && !(state & TCPF_CLOSE)) {
> +	/* Legitimate cases where this can happen:
> +	 * 1. During connection teardown
> +	 * 2. Race conditions with subflow destruction
> +	 * 3. Packets arriving after subflow cleanup
> +	 * Log debug info but don't warn loudly in production.
> +	 */
> +	if (unlikely(tcp_sk(sk)->repair_queue == TCP_RECV_QUEUE ||
> +	    sock_flag(sk, SOCK_DEAD) || !refcount_read(&parent->sk_refcnt))) {
> +			/* Expected during cleanup, silently return */
> +			return;
> +	}
> +	/* For other cases, still log for debugging but don't WARN */
> +	if (net_ratelimit())
> +		pr_debug("MPTCP: subflow in unexpected state sk=%p parent=%p state=%u\n",
> +			 sk, parent, state);
> +	}

The warning was there to catch issues: it is *not* normal to have to
process data in this state. I think it is better to prevent
subflow_data_ready() to be called in this state than ignoring the
warning, even if the warnings you saw didn't cause visible functional
issues. Please also note that a pr_debug() will very likely not be
caught in case of real issues: a WARN_ON_ONCE should have been kept.

Regarding this issue, it was already tracked in our bug tracker, see:

  https://github.com/multipath-tcp/mptcp_net-next/issues/586

There are two patches from Paolo in our tree addressing it:

  https://lore.kernel.org/mptcp/cover.1764928598.git.pabeni@redhat.com

I was waiting to upstream them because they are not urgent and net
maintainers are busy at the LPC for the moment, but I guess I should
still send them to avoid syzkaller instances to complain about these
issues. I will try to do that today.

Do you mind checking if they fix the issues on your side please?

pw-bot: cr

>  	if (mptcp_subflow_data_available(sk)) {
>  		mptcp_data_ready(parent, sk);
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


