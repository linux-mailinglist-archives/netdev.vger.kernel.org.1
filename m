Return-Path: <netdev+bounces-216034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F13EB319C5
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3FD1BA59B0
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96C930BF6F;
	Fri, 22 Aug 2025 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiW6kgtP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39930AACC
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869612; cv=none; b=JWooM0yNajA4WCbBQjWA9xQa6aA4gEdHl2l7LjzsXJU1EhdT7wd7+kDJ21aiOObY4DsEmht1RK2y7WrSFEM2SBTC58lsFvqTFfxjWmZQTh8wIsheF2B0q93r3dO+bPsWTQhXo0qxJEDM+JdWfrvuANSgBpqkSF9clVUvfHX1Abk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869612; c=relaxed/simple;
	bh=OXaVcXcdBV5f35+15muALcxBIYMjp4hObgTJs1F/Kc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAC8qDzkp0Q4kl9H7Uk13KqzbWjxfKtoNOR7pWsO/ep0Siotc0+NC8etgnsfPpk8TLyCQp+ndUqwH+eKoT+290Z/lWV0EQkU07ICubn3Y6ho7EHADInChHq3KVWDK+4VHpxtVv7mREyp94cpz+8CvROlcY7RmT8QIsJOPPgaNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiW6kgtP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9e4193083so1625923f8f.3
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 06:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755869609; x=1756474409; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ULXh+FdtSKdMbQN2ufiLticx/eFM3vpeoXJx5c7eLHs=;
        b=NiW6kgtP46wRdzMspB/uejMrYd8cqLd2ieWpXhHqswIojCC0h9N9wdilq7ZvjmxDs8
         Y7jvaRQc/fFUh82Dfy/n7bptrC7o50IWE1ZYbEYUKDoWmsMNmwQqy3afGRziiBhs055Q
         QOFKpaAOc6nYVmFEuEtO4ayGOoObGoQJBntooeKR5AgJGwEf4h/ER1ZDQhI/IyuVO1fr
         eFoIXhMY3/Hr6WoJWF35ENbh44O1Bi+JhDXGFQMC3YAo1T6n6rZXlBwrnOKnpAXAK5vg
         Xuis7lX4BE5tKLLQX5zn/E5jc37DpsFjDqlU63h8RY5z0A6FXztmBhwKs6coXrKrlAa0
         R4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869609; x=1756474409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULXh+FdtSKdMbQN2ufiLticx/eFM3vpeoXJx5c7eLHs=;
        b=FS8kD0xH08GcFGB1psxGUHj4jF3klasPsYmz/aEtymt5Xrkmg1USdfAJO7rT/nJLlT
         HgD8F3AzSX5WIw/gtRMKItXVgCX14cbhyUwkb6DTf+/wY9m7BS0ftre7mKqqjO3BNDb4
         VeXZcM1Wfnryi4Fyb1AyrcO+V8BHELu3HyAruL5LW/uXDSI0ZZE3SxELDEyg/oO9oBau
         NHDziJ4qcMnG8QPiOsWB8T7vpy723jKOcq21yiEWzfo/BW7hCPIuq+yFNM8mOnnHIXH8
         O/8yT9DyF52udb6uyZ6SvkDWUrWqjLAHCCs20FyAv4VcvKyqfRHRDPJDD1aGJaqoFgH8
         Tb4Q==
X-Gm-Message-State: AOJu0YwW+59OTQ2v2aiUFbA0N41I1KP2msGrsEbt29YvToO//ZVbtoJJ
	sUVl6JBwV+7ew4e4XwaKSwTz8LjrzIAEv0kArko95ornkGtEewqdtwAeKiISEQ==
X-Gm-Gg: ASbGnctMmw07TB+tyKLcgRBITpPjYOBDSucbnTJteHQFpPbdB7dw6nb3R6FeKVw9fPU
	3gH2mrx1rnzWfU70R63Ut3KkQehQI9AaHmcNq08CotVfVIf5uobd346E79lPD6457UNUqKjQAOD
	Zz15tw7P2kSPSir9s+LGsE0iqgriOuiHEb3s4Hj/A2y2fvpk6BUZwyOR18RRCS00bdV/eBhKN8B
	4P4F9FFikXMZxfwDPWj6V5+e//vIu8j03dUOYdR62cmoYZDQ9zWEVdviDJ6MiRMozHqkPWELpHi
	5zxH7Conia/RgFI0ddE3HNJJRux8L2VTyo0Mp9hpMgSjpmwDLBRAyI5dBm+TtGlnlctu9CB1deO
	ezlxB6jI34GP3mLTIqjcsN24pWq5ABRlABIjPmJiEhvLWi6M=
X-Google-Smtp-Source: AGHT+IEVCipLkRXR+F6IhCXhI7KtClpif/opRs1py9b3O/Ws/9ogL9xOI1f5/FhwPE5gWfs8PXvA3A==
X-Received: by 2002:a05:6000:18aa:b0:3b8:d1d9:70b0 with SMTP id ffacd0b85a97d-3c5dc638243mr2341369f8f.40.1755869608475;
        Fri, 22 Aug 2025 06:33:28 -0700 (PDT)
Received: from bzorp3 (178-164-188-58.pool.digikabel.hu. [178.164.188.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077c576b7sm15213473f8f.63.2025.08.22.06.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:33:27 -0700 (PDT)
Date: Fri, 22 Aug 2025 15:33:26 +0200
From: Balazs Scheidler <bazsi77@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [RFC, RESEND] UDP receive path batching improvement
Message-ID: <aKhxpuawARQlCj29@bzorp3>
References: <aKgnLcw6yzq78CIP@bzorp3>
 <CANn89iLy4znFBLK2bENWMfhPyjTc_gkLRswAf92uV7KY3bTdYg@mail.gmail.com>
 <aKg1Qgtw-QyE8bLx@bzorp3>
 <CANn89i+GMqF91FkjxfGp3KGJ-dC6-Snu3DoBdGuxZqrq=iOOcQ@mail.gmail.com>
 <aKho5v5VwxdNstYy@bzorp3>
 <CANn89i+S1hyPbo5io2khLk_UTfoQgEtnjYUUJTzreYufmbii+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+S1hyPbo5io2khLk_UTfoQgEtnjYUUJTzreYufmbii+A@mail.gmail.com>

On Fri, Aug 22, 2025 at 06:10:28AM -0700, Eric Dumazet wrote:
> On Fri, Aug 22, 2025 at 5:56 AM Balazs Scheidler <bazsi77@gmail.com> wrote:
> >
> > On Fri, Aug 22, 2025 at 02:37:28AM -0700, Eric Dumazet wrote:
> > > On Fri, Aug 22, 2025 at 2:15 AM Balazs Scheidler <bazsi77@gmail.com> wrote:
> > > >
> > > > On Fri, Aug 22, 2025 at 01:18:36AM -0700, Eric Dumazet wrote:
> > > > > On Fri, Aug 22, 2025 at 1:15 AM Balazs Scheidler <bazsi77@gmail.com> wrote:
> > > > > > The condition above uses "sk->sk_rcvbuf >> 2" as a trigger when the update is
> > > > > > done to the counter.
> > > > > >
> > > > > > In our case (syslog receive path via udp), socket buffers are generally
> > > > > > tuned up (in the order of 32MB or even more, I have seen 256MB as well), as
> > > > > > the senders can generate spikes in their traffic and a lot of senders send
> > > > > > to the same port. Due to latencies, sometimes these buffers take MBs of data
> > > > > > before the user-space process even has a chance to consume them.
> > > > > >
> > > > >
> > > > >
> > > > > This seems very high usage for a single UDP socket.
> > > > >
> > > > > Have you tried SO_REUSEPORT to spread incoming packets to more sockets
> > > > > (and possibly more threads) ?
> > > >
> > > > Yes.  I use SO_REUSEPORT (16 sockets), I even use eBPF to distribute the
> > > > load over multiple sockets evenly, instead of the normal load balancing
> > > > algorithm built into SO_REUSEPORT.
> > > >
> > >
> > > Great. But if you have many receive queues, are you sure this choice does not
> > > add false sharing ?
> >
> > I am not sure how that could trigger false sharing here.  I am using a
> > "socket" filter, which generates a random number modulo the number of
> > sockets:
> >
> > ```
> > #include "vmlinux.h"
> > #include <bpf/bpf_helpers.h>
> >
> > int number_of_sockets;
> >
> > SEC("socket")
> > int random_choice(struct __sk_buff *skb)
> > {
> >   if (number_of_sockets == 0)
> >     return -1;
> >
> >   return bpf_get_prandom_u32() % number_of_sockets;
> > }
> > ```
> 
> How many receive queues does your NIC have (ethtool -l eth0) ?
> 
> This filter causes huge contention on the receive queues and various
> socket fields, accessed by different cpus.
> 
> You should instead perform a choice based on the napi_id (skb->napi_id)

I don't have ssh access to the box, unfortunately.  I'll look into napi_id,
my historical knowledge of the IP stack is that we are using a single thread
to handle incoming datagrams, but I have to realize that information did not
age well. Also, the kernel is ancient, 4.18 something, RHEL8 (no, I didn't
have a say in that...).

This box is a VM, but I am not even sure about the virtualization stack used, I
am finding it out the number of receive queues.

But with that said, I was under the impression that the bottleneck is in
userspace and the userspace's roundtrip to get back to receiving UDP. 
The same event loop is processing a number of connections/UDP sockets in
parallel.

Sometimes syslog-ng just doesn't get around quickly enough if there's too much to do
with a specific datagram.  My assumption has been that it is this latency
that causes datagrams to be dropped.

> 
> 
> >
> > Last I've checked the code, all it did was putting the incoming packet into
> > the right socket buffer, as returned by the filter. What would be the false
> > sharing in this case?
> >
> > >
> > > > Sometimes the processing on the userspace side is heavy enough (think of
> > > > parsing, heuristics, data normalization) and the load on the box heavy
> > > > enough that I still see drops from time to time.
> > > >
> > > > If a client sends 100k messages in a tight loop for a while, that's going to
> > > > use a lot of buffer space.  What bothers me further is that it could be ok
> > > > to lose a single packet, but any time we drop one packet, we will continue
> > > > to lose all of them, at least until we fetch 25% of SO_RCVBUF (or if the
> > > > receive buffer is completely emptied).  This problem, combined with small
> > > > packets (think of 100-150 byte payload) can easily cause excessive drops. 25%
> > > > of the socket buffer is a huge offset.
> > >
> > > sock_writeable() uses a 50% threshold.
> >
> > I am not sure why this is relevant here, the write side of sockets can
> > easily be flow controlled (e.g. the process waiting until it can send more
> > data). Also my clients are not necessarily client boxes. PaloAlto firewalls
> > can generate 70k events-per-second in syslog alone. And that does leave the
> > firewall, and my challenge is to read all of that.
> >
> > >
> > > >
> > > > I am not sure how many packets warrants a sk_rmem_alloc update, but I'd
> > > > assume that 1 update every 100 packets should still be OK.
> > >
> > > Maybe, but some UDP packets have a truesize around 128 KB or even more.
> >
> > I understand that the truesize incorporates struct sk_buff header and we may
> > also see non-linear SKBs, which could inflate the number (saying this without really
> > understanding all the specifics there).
> >
> > >
> > > Perhaps add a new UDP socket option to let the user decide on what
> > > they feel is better for them ?
> >
> > I wanted to avoid a knob for this, but I can easily implement this way. So
> > should I create a patch for a setsockopt() that allows setting
> > udp_sk->forward_threshold?
> >
> > >
> > > I suspect that the main issue is about having a single drop in the first place,
> > > because of false sharing on sk->sk_drops
> > >
> > > Perhaps we should move sk_drops on a dedicated cache line,
> > > and perhaps have two counters for NUMA servers.
> >
> > I am looking into sk_drops, I don't know what it does at the moment, it's
> > been a while I've last read this codebase :)
> >
> 
> Can you post
> 
> ss -aum src :1000  <replace 1000 with your UDP source port>
> 
> We will check the dXXXX output (number of drops), per socket.

I don't have access to "ss", but I have this screenshot about a similar
metrics that we collect every 30 seconds:

https://drive.google.com/file/d/1HrMHSrbrkwCILQiBgAZw-J1r39PBED0f/view?usp=sharing

These metrics are collected via SK_MEMINFO from each of the sockets.

Simmilar to this case, drops usually happen on all the threads at once, even
if the receive rate is really low. Right now (when this screenshot was
taken), the UDP socket buffer remained at ~400kB (the default, as the sysctl
knobs were not persisted).

-- 
Bazsi


