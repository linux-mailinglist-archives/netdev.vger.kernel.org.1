Return-Path: <netdev+bounces-55877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B9C80CA85
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE581F21083
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760D83D3BD;
	Mon, 11 Dec 2023 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doZkoFT3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AD6C6
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 05:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702300079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OycwC9I5dpFFa4a+SNWmj00KDMf7SaPJUpuNX2grkc=;
	b=doZkoFT3rcWQ4a2TRzVxLEJmX7CptF6cIXY1nSMVWJquGZX5KSCgNTg6WH3ROZCT9yEY0q
	ujN55GSe4IU3vLxK5y+/tTO8yqf5FIwPFQUhbd8ZqIDPRUy0AvDsAq3e8pCFZNO/SllzAu
	e5sKUi54CS5OjnnxEocgzI4SmWtfTY8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-fz6T7hUEN3qvwCaRRavuBw-1; Mon, 11 Dec 2023 08:07:58 -0500
X-MC-Unique: fz6T7hUEN3qvwCaRRavuBw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54ce8bd5208so2589291a12.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 05:07:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702300077; x=1702904877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OycwC9I5dpFFa4a+SNWmj00KDMf7SaPJUpuNX2grkc=;
        b=TyLp1ug6J+v1KXM4AnilFw8GaF0ERSHuDFO+RVNpQCYzmrONrFtDdy1em/7MkscUB/
         1Onme2FczWsl1TvMPbEuWbUSys/ePEUsmpPjdFxdz9cYiuAODLvEvmMbvOmFJmSdF2Wv
         0S7J96KEit08x/flu+YWMzGclcuxDK/YdmnBoECP6BnkAwfcgB+KIgesR6h4/EUGnhNq
         V7q9yATuh+Zm1hrTMd4E+wpn36tY9ATc76/FaqGfTx28qpb0lbMckYp4b8fYC7KP6PX/
         zW45adBNiuZjMyFMuuBvm/6/H4ArBU88uwxjx9N4HpNFEoLJF935hLzxq7/P3zGCOrgz
         GkEg==
X-Gm-Message-State: AOJu0YxgIFU5iA0C7HhxoqntoNQOBsSQJzx2B1r/MsYJ9ljXyv18P1iu
	wErMVB1ALgUl2JRLTCJTyrUjT9WhcxZKUVQyxigdQIHtbglJ1beebfZ6juSOEkybK/AP/ISPgwq
	FJE8ZoHJ68BkOH6VO
X-Received: by 2002:a50:d498:0:b0:54c:4fec:cf with SMTP id s24-20020a50d498000000b0054c4fec00cfmr1520750edi.94.1702300077567;
        Mon, 11 Dec 2023 05:07:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAbJyA8VU7+GlGEGYrbmQ21237FDN+Ai/SzA3yEvnUtqwJ0IH0KtcFVCm0KtQPgtD7gb+OWA==
X-Received: by 2002:a50:d498:0:b0:54c:4fec:cf with SMTP id s24-20020a50d498000000b0054c4fec00cfmr1520744edi.94.1702300077181;
        Mon, 11 Dec 2023 05:07:57 -0800 (PST)
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id g6-20020a50d5c6000000b0054cc827e73dsm3773134edj.78.2023.12.11.05.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 05:07:56 -0800 (PST)
Date: Mon, 11 Dec 2023 14:07:56 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Linux Kernel Network Developers <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, wizhao@redhat.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Florian Westphal <fw@strlen.de>
Subject: Re: Mirred broken WAS(Re: [PATCH net-next 2/2] act_mirred: use the
 backlog for nested calls to mirred ingress
Message-ID: <ZXcJrNZxt5uY1sdn@dcaratti.users.ipa.redhat.com>
References: <cover.1674233458.git.dcaratti@redhat.com>
 <5fdd584d53f0807f743c07b1c0381cf5649495cd.1674233458.git.dcaratti@redhat.com>
 <CAM0EoMn4C-zwrTCGzKzuRYukxoqBa8tyHyFDwUSZYwkMOUJ4Lw@mail.gmail.com>
 <CAKa-r6sNMq5b=PiUhm0U=COV1fE=HL_CjOPxchs1WpWi4-_XNA@mail.gmail.com>
 <CAM0EoMm6QHzFdFLJ8Q1nO6W-m47tkxzVp7k2rAZYJZNXCCbM9g@mail.gmail.com>
 <CAM0EoMmvjwxLmdT5pQJ-hXVMA2OJUfy8TJKDxZ=vf+Thzza0=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMmvjwxLmdT5pQJ-hXVMA2OJUfy8TJKDxZ=vf+Thzza0=Q@mail.gmail.com>

hello Jamal,

On Thu, Dec 07, 2023 at 09:10:13AM -0500, Jamal Hadi Salim wrote:
> Hi Davide,
>

[...]
 
> > > > I am afraid this broke things. Here's a simple use case which causes
> > > > an infinite loop (that we found while testing blockcasting but
> > > > simplified to demonstrate the issue):
> > >
> > > [...]
> > >
> > > > sudo ip netns exec p4node tc qdisc add dev port0 clsact
> > > > sudo ip netns exec p4node tc filter add dev port0 ingress protocol ip
> > > > prio 10 matchall action mirred ingress redirect dev port0
> > >
> > > the above rule is taking packets from port0 ingress and putting it
> > > again in the mirred ingress of the same device, hence the loop.
> >
> > Right - that was intentional to show the loop. We are worrying about
> > extending mirred now to also broadcast (see the blockcast discussion)
> > to more ports making the loop even worse. The loop should terminate at
> > some point - in this case it does not...
> >
> > > I don't see it much different than what we can obtain with bridges:
> > >
> > > # ip link add name one type veth peer name two
> > > # ip link add name three type veth peer name four
> > > # for n in even odd; do ip link add name $n type bridge; done
> > > # for n in one two three four even odd; do ip link set dev $n up; done
> > > # for n in one three; do ip link set dev $n master odd; done
> > > # for n in two four; do ip link set dev $n master even; done
> > >
> >
> > Sure that is another way to reproduce.
> 
> Ok, so i can verify that re-introduction of the ttl field in the
> skb[1] fixes the issue. But restoring that patch may cause too much
> bikeshedding. Victor will work on a better approach using the cb
> struct instead - there may. Are you able to test with/out your patch
> and see if this same patch fixes it?

I'm also more optimistic on the use of qdisc cb for that purpose :)
Just share the code, i will be happy to review/test.
With regular TC mirred, the deadlock happened with TCP and SCTP socket
locks, as they were sending an ACK back for a packet that was sent by
the peer using egress->ingress.

AFAIR there is a small reproducer in tc_actions.sh kselftest, namely

mirred_egress_to_ingress_tcp_test()

maybe it's useful for pre-verification also.

[...]

my 2 cents  below:

> > I dont think we can run something equivalent inside the kernel. The
> > ttl worked fine. BTW, the example shown breaks even when you have
> > everything running on a single cpu (and packets being queued on the
> > backlog)

[...]

> > Yes, we need to make sure those are fixed with whatever replacement..
> > The loops will happen even on egress->egress (the example only showed
> > ingress-ingress).

if you try to make a loop using mirred egress/redirect, the first packet
will trigger a deadlock on the root qdisc lock - see [1]. It's worse
than a loop, because user can't fix it by just removing the "offending"
mirred action. Would the ttl be helpful here?

(in the meanwhile, I ill try to figure out if it's possible at least to
silence false lockdep warnings without using dynamic keys, as per
Eric reply).

TIA!

-- 
davide

[1] https://github.com/multipath-tcp/mptcp_net-next/issues/451#issuecomment-1782690200
 


