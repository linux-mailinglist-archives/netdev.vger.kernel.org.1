Return-Path: <netdev+bounces-247904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62031D00668
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 00:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96E09301AE32
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 23:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92CA2F28FC;
	Wed,  7 Jan 2026 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEv3abxj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF682E62B7
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767828837; cv=none; b=Z74KK6bAORbSNCrUz05PZ5b0ACU5W71TxeLrgUNIPYP/MMVIIRsPXSYdiqAIlXk5IwIkZdhRKykwKCmIB9m4dOVkpNBqWXXyUzo/DvKuNzu2WfibMj/1H4sx4Oevu6N5G2cxG7kqlVY1Ye/mfEU4l1g9ryTVyMjzZeTZufzeqSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767828837; c=relaxed/simple;
	bh=S8v7gcIvrBk8FhX7J7sBGMuV/tq1fO+JRDaGA16Q+yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSVXl0D9Y/pSTkpo+4uMTa7+fiKzeon0myEXGY3+VY1G6buCqttEWLlciZYZ06D08EHj09pMeqnLkwleFkc7tJxTkS3R7g8RRlN1UDYNS2UAExwVmBOFs0S1yxANv5Ukou/vzG9h4elHz/Km68z83javBjtc2M0nrMgMmp/XV6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEv3abxj; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-11f42e97340so1233250c88.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 15:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767828835; x=1768433635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Ppm5jM8uBff5D/7Ouw3LuW+QYaXI0yXmrC55KZnupA=;
        b=WEv3abxjJdC3mk2vZYHkRHGkx2QDk/SRS+5uf8Yk8aoy8vTtTKvhFRfc5PEt4woCOL
         hm99+7MehDpdcybrYJpbpnQ6O3aCR8j68hBSELy9TFfg435iS/AQvr+ETonpybcyImbq
         6Ee7PzAWRPGHrdbuBsKt6sNnrBAMBgdFITUhDJenGzCeF01ucByMs2k1YHvgcIHWQIYQ
         YP0+ykO1Q95YWfBavHICRkgVXrzfLjDuyywVwuZNIwHWBIfIA6zm7Is5C/hURWryweKC
         03KCzeSNxShKMXcBsuPO6v3cycfa+FyPm+MHW4+8S+qn+BX7shOtDM0rFGDSccNwubyy
         u3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767828835; x=1768433635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ppm5jM8uBff5D/7Ouw3LuW+QYaXI0yXmrC55KZnupA=;
        b=AfqqQjAfxJ5XfLRABcfpa9a8JC5v9dP1aNpdlmmux4HbJeE6HaWx8jhmKT5L7cbMk3
         l1yIZIP1ZHKDzhZMeVwsn/U5MDBY+H0R5O/PwVmL+W1XlT6mSnixvT+TVHfQ4C05XQYF
         2PrXC9xfpepzXMzSFmyjEvVVIyEAjE4e93svCOskDdOkaIH5yIMk3bruwB9SERvrmk15
         JCY8u1SbOxn2ZrDGmdhylGIvtAUH/Ntc5J7D47YWympIyAe21lq3H3MfMBnsHeldLZ2D
         B097UbuywxX6zg9gjZ/YY+71af9mKJXtL4vr0AEG/sh0LShe21VTwxALmav1FlLu6gEe
         RJrg==
X-Gm-Message-State: AOJu0YxQLETcK8eeVe+IjtGWbwIT9xbKzchVa8cGpQi1T3xXW6lYf20w
	mwJSvyKSwa/i1p7tq1jPPbpkK+rZanT9fQEHvoVhND+LiFi+4bdzP7nVrJIi1A==
X-Gm-Gg: AY/fxX6ootobz4aKsLxHLG77etixSK04/1qiMKOjyouBBdOUd9M5jHETyAkhkiICAz0
	FKyAApcUDEzXJ/OF632VgcRpYyCOhNbItTtSm4xIUCHArBSIvKz3NwRfUB8lBX3PLFgpzvOy8l0
	hqUOi7iP/BFsbkFptY/e9XlrJ43wqIjaCojW2k4C9l654AwTy8QH5RZCdIPldz02i/VAqooG2q5
	p3UXtbvrUWlEXoyrB7MYcGV6pnPUqzvzydYtsO2/0lAjTsv2XkWVwkc10uKI26EM35UZDr47amx
	5k2MCeUkoD0/ZphMQ+LIsn02eappQK2Mx0ZwOAUsMO8cKDKwTBn6um3LjMX7v/u0WnoCsp+lviZ
	MvWgaggiS58SbpW4bY2qHg78ONlI7ENtohup2XxSm/GFUIcshZY7VTq/10KtY1aqE6uIlgB5Fg5
	atWeNKIo0WkMh+ZzdEdg==
X-Google-Smtp-Source: AGHT+IGt+cT4l7kHjk19Sz0YLAYbJZK6FeuEQofOd7WlWhWy4oPerX3TIo9V3d2WpFVKKoW83HW0Lw==
X-Received: by 2002:a05:7022:41:b0:11a:3734:3db3 with SMTP id a92af1059eb24-121f8b4deddmr3900657c88.32.1767828834779;
        Wed, 07 Jan 2026 15:33:54 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:36c8:e8eb:df03:2fdc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243496asm11764040c88.1.2026.01.07.15.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 15:33:54 -0800 (PST)
Date: Wed, 7 Jan 2026 15:33:53 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch net v6 4/8] net_sched: Implement the right netem
 duplication behavior
Message-ID: <aV7tYRnVikZXAC23@pop-os.localdomain>
References: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
 <20251227194135.1111972-5-xiyou.wangcong@gmail.com>
 <20251230092850.43251a09@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251230092850.43251a09@phoenix.local>

On Tue, Dec 30, 2025 at 09:28:50AM -0800, Stephen Hemminger wrote:
> On Sat, 27 Dec 2025 11:41:31 -0800
> Cong Wang <xiyou.wangcong@gmail.com> wrote:
> 
> > In the old behavior, duplicated packets were sent back to the root qdisc,
> > which could create dangerous infinite loops in hierarchical setups -
> > imagine a scenario where each level of a multi-stage netem hierarchy kept
> > feeding duplicates back to the top, potentially causing system instability
> > or resource exhaustion.
> > 
> > The new behavior elegantly solves this by enqueueing duplicates to the same
> > qdisc that created them, ensuring that packet duplication occurs exactly
> > once per netem stage in a controlled, predictable manner. This change
> > enables users to safely construct complex network emulation scenarios using
> > netem hierarchies (like the 4x multiplication demonstrated in testing)
> > without worrying about runaway packet generation, while still preserving
> > the intended duplication effects.
> > 
> > Another advantage of this approach is that it eliminates the enqueue reentrant
> > behaviour which triggered many vulnerabilities. See the last patch in this
> > patchset which updates the test cases for such vulnerabilities.
> > 
> > Now users can confidently chain multiple netem qdiscs together to achieve
> > sophisticated network impairment combinations, knowing that each stage will
> > apply its effects exactly once to the packet flow, making network testing
> > scenarios more reliable and results more deterministic.
> > 
> > I tested netem packet duplication in two configurations:
> > 1. Nest netem-to-netem hierarchy using parent/child attachment
> > 2. Single netem using prio qdisc with netem leaf
> > 
> > Setup commands and results:
> > 
> > Single netem hierarchy (prio + netem):
> >   tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> >   tc filter add dev lo parent 1:0 protocol ip matchall classid 1:1
> >   tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 100%
> > 
> > Result: 2x packet multiplication (1→2 packets)
> >   2 echo requests + 4 echo replies = 6 total packets
> > 
> > Expected behavior: Only one netem stage exists in this hierarchy, so
> > 1 ping becomes 2 packets (100% duplication). The 2 echo requests generate
> > 2 echo replies, which also get duplicated to 4 replies, yielding the
> > predictable total of 6 packets (2 requests + 4 replies).
> > 
> > Nest netem hierarchy (netem + netem):
> >   tc qdisc add dev lo root handle 1: netem limit 1000 duplicate 100%
> >   tc qdisc add dev lo parent 1: handle 2: netem limit 1000 duplicate 100%
> > 
> > Result: 4x packet multiplication (1→2→4 packets)
> >   4 echo requests + 16 echo replies = 20 total packets
> > 
> > Expected behavior: Root netem duplicates 1 ping to 2 packets, child netem
> > receives 2 packets and duplicates each to create 4 total packets. Since
> > ping operates bidirectionally, 4 echo requests generate 4 echo replies,
> > which also get duplicated through the same hierarchy (4→8→16), resulting
> > in the predictable total of 20 packets (4 requests + 16 replies).
> > 
> > The new netem duplication behavior does not break the documented
> > semantics of "creates a copy of the packet before queuing." The man page
> > description remains true since duplication occurs before the queuing
> > process, creating both original and duplicate packets that are then
> > enqueued. The documentation does not specify which qdisc should receive
> > the duplicates, only that copying happens before queuing. The implementation
> > choice to enqueue duplicates to the same qdisc (rather than root) is an
> > internal detail that maintains the documented behavior while preventing
> > infinite loops in hierarchical configurations.
> > 
> > Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> > Reported-by: William Liu <will@willsroot.io>
> > Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> 
> It is worth testing for the case where netem is used as a leaf qdisc.
> I worry that this could cause the parent qdisc to get accounting wrong.
> I.e if HTB calls netem and netem queues 2 packets, the qlen in HTB
> would be incorrect.

In patch 6/8, I added "Test PRIO with NETEM duplication", which installs
netem Qdisc as a child and leaf of root prio qdisc.

Or am I misunderstanding it?

Regards,
Cong

