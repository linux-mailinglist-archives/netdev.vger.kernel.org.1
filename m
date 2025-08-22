Return-Path: <netdev+bounces-216015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E63B318B7
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66AC73BCC07
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29A62FD1BD;
	Fri, 22 Aug 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CusADeLv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8202FC86E
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867372; cv=none; b=mQYdmrLArGqkqGzJuE2r0UVKInwVFedlXCJbNX7y2KKoXqL2HU8zomLZu1wnjDvIIuJB7rx16cJKP/+Qw4jO2vuq835lM08tFLShrYwcy3HrREVseSZjwW20PeyerJhNGFmqZfZ4xL0nq7R6LKpi0mU4dOcxnKBcnR7n+GDfqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867372; c=relaxed/simple;
	bh=pBtJkdKIOH7N27G8FeRWyUWg533FTGPkfToN/QbVLL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqaJzvzgoOo6KWEeWIy8VpfcRT4OXWQ74FlcH/Wgl7iPX84bB7hd/TkTDv3a76VdIYayiiamqPE8jhZhBLojbegRfOeVejyXzwpEyPIUj8w2j9B5afpYYIWiwKAMwV1NkiLBlPPm/YW+BMgfJSMUyIHl9Vp1Z62KWFtzwEXTYe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CusADeLv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so15786555e9.3
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755867369; x=1756472169; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=midbDyOfgXb0PE71DdoTMRzYYk0O+/B0juC2Utpk5Sw=;
        b=CusADeLvsvdCXZaRJixfcpnJp36tVwSf/0+w6B7plaA7xpAwX2rXj8BMAud/Q2Q1/0
         UGX/aCb8//UQ83gBNBrc52VTyWLj+enxrRjzE1WhoMce3VQ66r1yJmWU4xqalJoTvaOS
         4/gFVB5t/NyKefcZqFtv9jJ2sZgmMu9Zd3zk7JMNp4VMYsnm35L3TlyyrmMGODyiZrTJ
         qP4r6RFntjM110hSkpHV+oYuY6M8vUHhdWR4g26nqIyR2EPNfcDkaxoygsk4VtJAFlBe
         zDMumDDAAu7bTE6WvYY2m93ewGtlYaKap9hRbLz83GKgHEVFO2lGkV2Ozk/000ispnbx
         M9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867369; x=1756472169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=midbDyOfgXb0PE71DdoTMRzYYk0O+/B0juC2Utpk5Sw=;
        b=CHV0XUVikasDtap6W345SKq3ahq9hdnDdnooB22oMelftAZmj8n/xOPn7d7VQRXWvU
         ooKBh4bDZXj5CVPXy4/bNtOxb0vXfKHWnoWn7nZU0QsaWoR6avqbjECyOR3jKQOEbNG+
         9dmZZiDD9IdyouF30F9n1OUg7m7ydqrEo/REwsHujhOvx0oQUK9rRPxq9+6pR+8+lyuw
         idcphBrZuooDNKxe9oPR0OFr1payKHBzcyWztMpormbZl9kPYUOdpukvSxwsnVWQ3K+z
         2P4cDzRMADKOar1zciDBqxd0vWCZ+RY0XeO1OuyIV6mS9PEa2i+eGWFFD061rrTdAyJl
         FpCw==
X-Gm-Message-State: AOJu0YxzBwbHURQKD3gl7GaAooECNZzUFRFrVCp5QMOX0kFPBBwm5i7/
	etwooVm7sRrfp1OYSV4mIvnz9L5j7xBNbjZWIaSITKTEl/zsxHkp1pMPJcOOpg==
X-Gm-Gg: ASbGncvxXQH8FpWxs2BfsaSSZsQtlgWN5tV5tSHgzunjr7Ow7LY7vNyviUMEuWwJmat
	FtzSFXRA9YTn+/XxzSjiBYaXdlyqw4j9cbm+G5HVRf8Rqdo8cZcfx+Rjt71sC3oDfIFeyIO/81c
	MpVDsuMzZsuvRrSI4bdg8MRW9GC4w/n7CQkoCpO0+jSXdxIf2BV75N0EebF+Ep3s57JRh35JXSc
	YaLd9Up5ZOBARmcrqeeguR4V7i4jh1PRMmDaIFZyKxvEIO+6h9sMW011D/GZK6wdVLeh9fjGB3t
	i5bNmAYX7uXL6McuJ/B3Wqp2DMt80b2RAlKNk53bCpV84HpsrbCD9Vcz6FpbcLvjK2aZlbY6xze
	73zS6n2v+ePu/Drrk2ZLe8DgFhluT/9EcloTiVZU5fJi1t1eoTSr1Fqp/qg==
X-Google-Smtp-Source: AGHT+IEg0hKH51+doEISo3nX6tzl4Ss57nF8Zfqq6Gghw2TiXqeA1oriAfnSC4QtNJL0bpOQlDmQ/g==
X-Received: by 2002:a05:600c:444c:b0:458:bf9c:274f with SMTP id 5b1f17b1804b1-45b517d4cabmr21130125e9.29.1755867368916;
        Fri, 22 Aug 2025 05:56:08 -0700 (PDT)
Received: from bzorp3 (178-164-188-58.pool.digikabel.hu. [178.164.188.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c07496f3f5sm15249286f8f.12.2025.08.22.05.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:56:08 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:56:06 +0200
From: Balazs Scheidler <bazsi77@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [RFC, RESEND] UDP receive path batching improvement
Message-ID: <aKho5v5VwxdNstYy@bzorp3>
References: <aKgnLcw6yzq78CIP@bzorp3>
 <CANn89iLy4znFBLK2bENWMfhPyjTc_gkLRswAf92uV7KY3bTdYg@mail.gmail.com>
 <aKg1Qgtw-QyE8bLx@bzorp3>
 <CANn89i+GMqF91FkjxfGp3KGJ-dC6-Snu3DoBdGuxZqrq=iOOcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+GMqF91FkjxfGp3KGJ-dC6-Snu3DoBdGuxZqrq=iOOcQ@mail.gmail.com>

On Fri, Aug 22, 2025 at 02:37:28AM -0700, Eric Dumazet wrote:
> On Fri, Aug 22, 2025 at 2:15 AM Balazs Scheidler <bazsi77@gmail.com> wrote:
> >
> > On Fri, Aug 22, 2025 at 01:18:36AM -0700, Eric Dumazet wrote:
> > > On Fri, Aug 22, 2025 at 1:15 AM Balazs Scheidler <bazsi77@gmail.com> wrote:
> > > > The condition above uses "sk->sk_rcvbuf >> 2" as a trigger when the update is
> > > > done to the counter.
> > > >
> > > > In our case (syslog receive path via udp), socket buffers are generally
> > > > tuned up (in the order of 32MB or even more, I have seen 256MB as well), as
> > > > the senders can generate spikes in their traffic and a lot of senders send
> > > > to the same port. Due to latencies, sometimes these buffers take MBs of data
> > > > before the user-space process even has a chance to consume them.
> > > >
> > >
> > >
> > > This seems very high usage for a single UDP socket.
> > >
> > > Have you tried SO_REUSEPORT to spread incoming packets to more sockets
> > > (and possibly more threads) ?
> >
> > Yes.  I use SO_REUSEPORT (16 sockets), I even use eBPF to distribute the
> > load over multiple sockets evenly, instead of the normal load balancing
> > algorithm built into SO_REUSEPORT.
> >
> 
> Great. But if you have many receive queues, are you sure this choice does not
> add false sharing ?

I am not sure how that could trigger false sharing here.  I am using a
"socket" filter, which generates a random number modulo the number of
sockets:

```
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>

int number_of_sockets;

SEC("socket")
int random_choice(struct __sk_buff *skb)
{
  if (number_of_sockets == 0)
    return -1;

  return bpf_get_prandom_u32() % number_of_sockets;
}
```

Last I've checked the code, all it did was putting the incoming packet into
the right socket buffer, as returned by the filter. What would be the false
sharing in this case?

> 
> > Sometimes the processing on the userspace side is heavy enough (think of
> > parsing, heuristics, data normalization) and the load on the box heavy
> > enough that I still see drops from time to time.
> >
> > If a client sends 100k messages in a tight loop for a while, that's going to
> > use a lot of buffer space.  What bothers me further is that it could be ok
> > to lose a single packet, but any time we drop one packet, we will continue
> > to lose all of them, at least until we fetch 25% of SO_RCVBUF (or if the
> > receive buffer is completely emptied).  This problem, combined with small
> > packets (think of 100-150 byte payload) can easily cause excessive drops. 25%
> > of the socket buffer is a huge offset.
> 
> sock_writeable() uses a 50% threshold.

I am not sure why this is relevant here, the write side of sockets can
easily be flow controlled (e.g. the process waiting until it can send more
data). Also my clients are not necessarily client boxes. PaloAlto firewalls
can generate 70k events-per-second in syslog alone. And that does leave the
firewall, and my challenge is to read all of that.

> 
> >
> > I am not sure how many packets warrants a sk_rmem_alloc update, but I'd
> > assume that 1 update every 100 packets should still be OK.
> 
> Maybe, but some UDP packets have a truesize around 128 KB or even more.

I understand that the truesize incorporates struct sk_buff header and we may
also see non-linear SKBs, which could inflate the number (saying this without really
understanding all the specifics there).

> 
> Perhaps add a new UDP socket option to let the user decide on what
> they feel is better for them ?

I wanted to avoid a knob for this, but I can easily implement this way. So
should I create a patch for a setsockopt() that allows setting
udp_sk->forward_threshold?

> 
> I suspect that the main issue is about having a single drop in the first place,
> because of false sharing on sk->sk_drops
> 
> Perhaps we should move sk_drops on a dedicated cache line,
> and perhaps have two counters for NUMA servers.

I am looking into sk_drops, I don't know what it does at the moment, it's
been a while I've last read this codebase :)

-- 
Bazsi

