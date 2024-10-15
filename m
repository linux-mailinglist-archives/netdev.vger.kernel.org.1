Return-Path: <netdev+bounces-135813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8D799F434
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9027C1F21A40
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28A61F9EAA;
	Tue, 15 Oct 2024 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T5Iw6Vdh"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808F18614E
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013881; cv=none; b=Ygq+x0lBMn0Dmn0XbDOIkzvIiA4jfjLqvN3yW2MFWtcEiO0XDemAYFwWjzfzm38RG8FL0CibwH+DjVj2k+Y3hMDBpxtRUo9s+AA3SruIRGpq8DdlsnwoQI9UchgYNbv8Jvp2CFFoKpfxhZDenL3bYiXNosSxRkwOs9aFB+FXfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013881; c=relaxed/simple;
	bh=/gL0lQWqiSeZn+QpJ2Prqyc5zQ/SZ1cV5x91T+YjB3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nbq3qvNVeUBb5LDd4UE/pmDHqJK6XC8NUmx/bheB3/W7X/JB9iOz/kL0hAFab7r/bOuRB/iUUiegtuOnT/HLjJ+AHd/vwleglurkJ0TmqcFZITYaA1Km0ZpWYHdEumH66hSM0pwa01XicrLudBXeLlQ8fLy4u7+lQ5G09KNYHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T5Iw6Vdh; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <27d46d3a-b636-4ccf-adfe-41363ad93946@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729013877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyCL+txftn7hqNwNdwZxSu11CVK0hpnoJSm7brYJNgA=;
	b=T5Iw6VdhgPJ3FTM8qpnxwZbgk8qjFG9vyj7Sh7XM2m6g1WQ6KICh8FQNCzrriKGMKmSbHk
	/6kHwMbhtpTEvNAJLZ/k4+fGc4ozpmhDnGnUxSNIJTIf4mywvPg2OE4YxfSwkAZ3r3Xmd8
	1/Lkn8Ys37W0UBaC8aM/icYWeVCutbg=
Date: Tue, 15 Oct 2024 10:37:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 net] tcp/dccp: Don't use timer_pending() in
 reqsk_queue_unlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20241014223312.4254-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241014223312.4254-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/14/24 3:33 PM, Kuniyuki Iwashima wrote:
> Martin KaFai Lau reported use-after-free [0] in reqsk_timer_handler().
> 
>    """
>    We are seeing a use-after-free from a bpf prog attached to
>    trace_tcp_retransmit_synack. The program passes the req->sk to the
>    bpf_sk_storage_get_tracing kernel helper which does check for null
>    before using it.
>    """
> 
> The commit 83fccfc3940c ("inet: fix potential deadlock in
> reqsk_queue_unlink()") added timer_pending() in reqsk_queue_unlink() not
> to call del_timer_sync() from reqsk_timer_handler(), but it introduced a
> small race window.
> 
> Before the timer is called, expire_timers() calls detach_timer(timer, true)
> to clear timer->entry.pprev and marks it as not pending.
> 
> If reqsk_queue_unlink() checks timer_pending() just after expire_timers()
> calls detach_timer(), TCP will miss del_timer_sync(); the reqsk timer will
> continue running and send multiple SYN+ACKs until it expires.
> 
> The reported UAF could happen if req->sk is close()d earlier than the timer
> expiration, which is 63s by default.
> 
> The scenario would be
> 
>    1. inet_csk_complete_hashdance() calls inet_csk_reqsk_queue_drop(),
>       but del_timer_sync() is missed
> 
>    2. reqsk timer is executed and scheduled again
> 
>    3. req->sk is accept()ed and reqsk_put() decrements rsk_refcnt, but
>       reqsk timer still has another one, and inet_csk_accept() does not
>       clear req->sk for non-TFO sockets
> 
>    4. sk is close()d
> 
>    5. reqsk timer is executed again, and BPF touches req->sk
> 
> Let's not use timer_pending() by passing the caller context to
> __inet_csk_reqsk_queue_drop().
> 
> 
> Fixes: 83fccfc3940c ("inet: fix potential deadlock in reqsk_queue_unlink()")
> Reported-by: Martin KaFai Lau <martin.lau@kernel.org>
> Closes: https://lore.kernel.org/netdev/eb6684d0-ffd9-4bdc-9196-33f690c25824@linux.dev/
> Link: https://lore.kernel.org/netdev/b55e2ca0-42f2-4b7c-b445-6ffd87ca74a0@linux.dev/ [1]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>


