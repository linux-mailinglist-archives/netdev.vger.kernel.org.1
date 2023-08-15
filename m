Return-Path: <netdev+bounces-27671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244E977CC55
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 14:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426A428149E
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5301E111B0;
	Tue, 15 Aug 2023 12:08:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CDC111AF
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 12:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA08C433C7;
	Tue, 15 Aug 2023 12:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692101327;
	bh=2I9zTsaTUj2cvyrEYEqTG4+Hu3ZlC/26ibNOomQI9tc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=hYSx9CNl3kWclsqirsoWwQj7isJ+V3pCYqY17Cu0xyW/8/HNiwbnIAMHpdoAhnhf1
	 9Pn5qNCUHgHdAF1R7caEJ7tI0j/FUrw/zZqQKBjBd4lNo/ZUKR286hD1pMjP+jNsni
	 hBdTWOqMtlZVsW6tG4HGxlQyXrEJQ4kmuabjzvEgKIdcCpwjpGDGoUhvsd6yKKxIqt
	 0RosjB5x6bnbbEBCIKu8RcE73qVUw7RqvER/4IApS75iK8dyMs6D/GcaltF8uSxtJ3
	 aw0VvEJlD/4EI3OcwO9yLhtl+NldoZY/KlDO63ibud3Fne14YoIbKk8KDmLKMWBv4r
	 wiLxGF+k86Hzw==
Message-ID: <25de7655-6084-e6b9-1af6-c47b3d3b7dc1@kernel.org>
Date: Tue, 15 Aug 2023 14:08:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: hawk@kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Wander Lairson Costa <wander@redhat.com>,
 kernel-team <kernel-team@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC PATCH 2/2] softirq: Drop the warning from
 do_softirq_post_smp_call_flush().
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814093528.117342-3-bigeasy@linutronix.de>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230814093528.117342-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2023 11.35, Sebastian Andrzej Siewior wrote:
> This is an undesired situation and it has been attempted to avoid the
> situation in which ksoftirqd becomes scheduled. This changed since
> commit d15121be74856 ("Revert "softirq: Let ksoftirqd do its job"")
> and now a threaded interrupt handler will handle soft interrupts at its
> end even if ksoftirqd is pending. That means that they will be processed
> in the context in which they were raised.

$ git describe --contains d15121be74856
v6.5-rc1~232^2~4

That revert basically removes the "overload" protection that was added
to cope with DDoS situations in Aug 2016 (Cc. Cloudflare).  As described
in https://git.kernel.org/torvalds/c/4cd13c21b207 ("softirq: Let
ksoftirqd do its job") in UDP overload situations when UDP socket
receiver runs on same CPU as ksoftirqd it "falls-off-an-edge" and almost
doesn't process packets (because softirq steals CPU/sched time from UDP
pid).  Warning Cloudflare (Cc) as this might affect their production
use-cases, and I recommend getting involved to evaluate the effect of
these changes.

I do realize/acknowledge that the reverted patch caused other latency
issues, given it was a "big-hammer" approach affecting other softirq
processing (as can be seen by e.g. the watchdog fixes patches).
Thus, the revert makes sense, but how to regain the "overload"
protection such that RX networking cannot starve processes reading from
the socket? (is this what Sebastian's patchset does?)

--Jesper

Thread link for people Cc'ed: 
https://lore.kernel.org/all/20230814093528.117342-1-bigeasy@linutronix.de/#r

