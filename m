Return-Path: <netdev+bounces-239048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 856F1C62F00
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE3A94E72D1
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7E31D362;
	Mon, 17 Nov 2025 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBBzwks6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E13254AF5
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763368919; cv=none; b=gBnSVk0NAvQFMkoUXIgxVzjZYwG+Vxc4n6gupL4pXFKYNi6us1PtYt6PHm38Q2XKWkg5bSvCcIIc8WjbpSaa+ZZNWC0iDwAz1Cnfaa5aXkQzUQuDHj7htGYxpf1A/AGOV7PJX5sKVTzlCqGv65vEy1tH0S2ZuLAZFaxCckqIxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763368919; c=relaxed/simple;
	bh=s/k/UfWboGwuVJSsMNBuQLqs5DX4odGunkwNnGNnreg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VccwmnK97vP6jf6BGMLM1tbpMy3wIpvxFHbQzISmn4dWHqSYDrJ/AavIjhLRDY1u+WllbmUw1Qe7B/L9DdjvGnnhm0CYccOwWWYOccxzrEbvb2Nu+bLqsnlGs4aw1Irvv1IkS951+wg8G8VUK4RQ9B0PuCjOx3pfKUad5zhVEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBBzwks6; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-4330e912c51so17747125ab.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 00:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763368917; x=1763973717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCI+9ZISgD/XQKyOC0u4rMFHqjAtdKYBhe4iTNr2rrA=;
        b=cBBzwks6TzLsOkpkj4N40P0wVRi6T6zGifHzinJUyUwcAXWRJxoAA+neFUhDdgwU3W
         OdAudyFa7NKGIocF4cqhBJESoMbtp1zNrFItgVvoFiusWVZqve8vX18FFBzazaczDacX
         nBRidkmI+u/li/wwlpg+VmBmhVG7BQrw4kG79llmLE9eNvSqvG1BO3xwM1lWPAnuxLtF
         dMPXO6BJjTBdAKj7yE70RZfzZkUNxV/JhctiQFJu7xEb3n0vacLpIEHxyahJ6fIhpLdd
         AmH9q+kMufba3DA1gHmeORDN9PlBE57xLbysU0J0LbNiFhd0QhYUOow/SbFPiWDHtpI7
         XSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763368917; x=1763973717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCI+9ZISgD/XQKyOC0u4rMFHqjAtdKYBhe4iTNr2rrA=;
        b=Hjlz/8wFUw6a2VBebzZfGY2f3QBOuFBp1EZgukFykZurpNA5WhmJkY/4/raZ+esRns
         FzWynvFRrpYVz5o80fC7tX0WqsXwZA4N5EfQTBXomqD3NTXMElnHJ74P7xYGIw9VDpaM
         jF2tMpQ4KHD4ZZ9j6jxf6qZRO2tqZLPI/h/In8WgDrAxSgwDtRv/nA1zFQcL0nu0K51R
         kCjSKljhQ0ab0MIOhK2NP18yBwnN41EdebLXBI209xad6Cwj/Qp9RH/WOu7bO6gRkoRm
         MhB+Im425MwUCv3DtZo04hQbTBsOxQ/4/4wr8VVhAM02WgnooMkFj8nG89jsnO0S4Kdo
         hxZA==
X-Forwarded-Encrypted: i=1; AJvYcCUow0o600Na2Qcyf4Z8YMkGK+mKWuWm8nDmMLj8JBIdOVGx78poBrFcB1Ab9zGWu5rGRyVYIaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjePdnhkvDZRj3ZOJW+XN4fwboRZw4kVEJWeOkgEIdl9Zn+Dtt
	COzl+5vokFS5QCDOTwWmonNbTYNixeAWk59o2XuHrxLBpWjZfkCe1UIkOmMsZH9Hpb5yAuqchne
	rjua+KQYpRWoi04nHCYvtdo9ZqESB8OQ=
X-Gm-Gg: ASbGncvs+7D0ezX8kVjdQjSN4vHhj9yj69vDpnX6ZSXr6fj2JvpYO2+amIhCgwEIggL
	GDRJ04Ck1lOgmrhW6RB8dd45q3BoOFdi9m+pMHXgdbOWehuuu4gGLyRJRP1vPZsQdTm0rTLifqe
	oFsJe8uHeiIjzfLVvZCcoc+uPxr98qIYiPPhHuEi61ef5JFSBCBuRHKKaRgy7jhuFwUCSPtlw64
	n67N2qi4GUJ8/GlwlUGDabp1QkRr4ppfY7YCMOISJ0DegDco3rHnEi7OPRL
X-Google-Smtp-Source: AGHT+IGcpv+dnDblGYSCDSjLfwR81F1YrDzadEBGZ1KbsXgehD4NkM6oiSUmlwraG3YmhwH04Tu8F2BLK66GZqtFX7o=
X-Received: by 2002:a05:6e02:3e8d:b0:433:7a94:6fd5 with SMTP id
 e9e14a558f8ab-4348c89e6b3mr138345695ab.8.1763368916802; Mon, 17 Nov 2025
 00:41:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com> <20251116202717.1542829-4-edumazet@google.com>
 <CAL+tcoD3-qtq4Kcmo9eb4mw6bdSYCCjxzNB3qov5LDYoe_gtkw@mail.gmail.com>
In-Reply-To: <CAL+tcoD3-qtq4Kcmo9eb4mw6bdSYCCjxzNB3qov5LDYoe_gtkw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 17 Nov 2025 16:41:20 +0800
X-Gm-Features: AWmQ_bmxwYop9z6om4_YS5kFvhCrJpH0nk_bxTIM2xlJ1sPZoAWolATGYSgkDWk
Message-ID: <CAL+tcoBpUg=ggf6nQpYeZyAcMbXobuJtyUdN98G1HpcuUqFZ+w@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/3] net: use napi_skb_cache even in process context
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 9:07=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Mon, Nov 17, 2025 at 4:27=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > This is a followup of commit e20dfbad8aab ("net: fix napi_consume_skb()
> > with alien skbs").
> >
> > Now the per-cpu napi_skb_cache is populated from TX completion path,
> > we can make use of this cache, especially for cpus not used
> > from a driver NAPI poll (primary user of napi_cache).
> >
> > We can use the napi_skb_cache only if current context is not from hard =
irq.
> >
> > With this patch, I consistently reach 130 Mpps on my UDP tx stress test
> > and reduce SLUB spinlock contention to smaller values.
> >
> > Note there is still some SLUB contention for skb->head allocations.
> >
> > I had to tune /sys/kernel/slab/skbuff_small_head/cpu_partial
> > and /sys/kernel/slab/skbuff_small_head/min_partial depending
> > on the platform taxonomy.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>
> Thanks for working on this. Previously I was thinking about this as
> well since it affects the hot path for xsk (please see
> __xsk_generic_xmit()->xsk_build_skb()->sock_alloc_send_pskb()). But I
> wasn't aware of the benefits between disabling irq and allocating
> memory. AFAIK, I once removed an enabling/disabling irq pair and saw a
> minor improvement as this commit[1] says. Would you share your
> invaluable experience with us in this case?
>
> In the meantime, I will do more rounds of experiments to see how they per=
form.

Tested-by: Jason Xing <kerneljasonxing@gmail.com>
Done! I managed to see an improvement. The pps number goes from
1,458,644 to 1,647,235 by running [2].

But sadly the news is that the previous commit [3] leads to a huge
decrease in af_xdp from 1,980,000 to 1,458,644. With commit [3]
applied, I observed and found xdpsock always allocated the skb on cpu
0 but the napi poll triggered skb_attempt_defer_free() on another
call[4], which affected the final results.

[2]
taskset -c 0 ./xdpsock -i enp2s0f1 -q 1 -t -S -s 64

[3]
commit e20dfbad8aab2b7c72571ae3c3e2e646d6b04cb7
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Nov 6 20:29:34 2025 +0000

    net: fix napi_consume_skb() with alien skbs

    There is a lack of NUMA awareness and more generally lack
    of slab caches affinity on TX completion path.

[4]
@c[
    skb_attempt_defer_free+1
    ixgbe_clean_tx_irq+723
    ixgbe_poll+119
    __napi_poll+48
, ksoftirqd/24]: 1964731

@c[
    kick_defer_list_purge+1
    napi_consume_skb+333
    ixgbe_clean_tx_irq+723
    ixgbe_poll+119
, 34, swapper/34]: 123779

Thanks,
Jason

>
> [1]
> commit 30ed05adca4a05c50594384cff18910858dd1d35
> Author: Jason Xing <kernelxing@tencent.com>
> Date:   Thu Oct 30 08:06:46 2025 +0800
>
>     xsk: use a smaller new lock for shared pool case
>
>     - Split cq_lock into two smaller locks: cq_prod_lock and
>       cq_cached_prod_lock
>     - Avoid disabling/enabling interrupts in the hot xmit path
>
> Thanks,
> Jason

