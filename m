Return-Path: <netdev+bounces-146367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9246D9D315F
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 01:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF311F219AF
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 00:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CBB4A23;
	Wed, 20 Nov 2024 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icM3enFw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15254647;
	Wed, 20 Nov 2024 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732062004; cv=none; b=VedtglLvnL2WHW3s6DPiLqUiqPudFNkrRo4cNMktZkqqWXLsbHZ70b3D4Kxks8NxzFFDn2YzhG+P81lBqkhZJuKZH24rEkw6/sw39Ye6Ucglsktfh0slxKt2YOZ2b8Qfb6y1PZoq3mLJF+DN76Pc0WrUkQoHLwl3v/W7nqLexFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732062004; c=relaxed/simple;
	bh=tffTpPg9rATtnzAwirYZjiWerQgCm6dW1J0qRe0a+PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xs3LMA+iD/1DcfFzsr/qW5IEiy+VGPx+Wv1oL0VD3Nf0OBfPTSnNUPBuINE7yVwwsU2i9NHLkcs0KU6JyFD068FNc/rYCnCQP141vdA4nn8EwBXs4+7zD7iGztxK5/Wfd4cEVtGUQF4S1vUCkizXnzAgVhJ75v/Vw4YnoVKGMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icM3enFw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ea527ae14aso1156042a91.1;
        Tue, 19 Nov 2024 16:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732062002; x=1732666802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rfOtefJc4QMbrWO0NVuhXeyUXomckquTaAfyd1RDazg=;
        b=icM3enFwrWsaj3Pq06zdwpKjw22GD1931f/TW92Mi9rrLivyOz9na1me6lNuzVLOQ7
         3EEoLE1lcVWMDQez1bx9jtSDpz4M7/otzqyx+mzU8nbxAN+mK3LAceumao8EdI0C/G2Y
         eBW/MPRT8CklvuGxjxPEzJk/s0uSZgSmwgFZaTHih3L5kIh3dhUzl9bUp09siMmR8Anl
         vzth9JvlQf2lftObPRG8A/eq00MXTbc5bvmLdfWB4piRnS6+VzSAbQ3momSKejKQerG/
         ZtGqKVs34x70YkDdfLZrWtrLvW5+DTSokPYhUFLd+Eju4vQUPb7rEEFY42WfCieE8iW9
         G/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732062002; x=1732666802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfOtefJc4QMbrWO0NVuhXeyUXomckquTaAfyd1RDazg=;
        b=voGLTnwkX83gWAOg1R5Dabc1thV/nZFpIOF2I9/kSNeslyqZ0v28IfH+IMh5zgJWaD
         Bdq9Rx5wdNHx5iRskygO1nBPbq6JqHXiH5n76GqZ9xZ9KHQiQwgNtwJtwbufqy5t3wI5
         kfFhKYY9ksQb7LwxgZNpONNOg0/rAqRZE8rVuu6ehsc2B2QIMZkqB1puNWxLdB5/uKrw
         4/ddbjOWX4jiZBV8VSJw/3FHhxfpWdrM/MBdbn4VQLpadDQ+7vAQD/jO4uEVXejyWO/c
         oML/PJ4g8v6UgVYV7MrgaaxAKoL5Tsdnmm1WHrfAIpm9ZjL3Na61U+Q3vcMuWiMjU9Wu
         0U3A==
X-Forwarded-Encrypted: i=1; AJvYcCWCv+wNb8PG4AUvJ3s/TrBSnMF/yGEjxRiugBUB+A+zUEagh7i5BhTxaoy3QPy6YHc233FLIkVq@vger.kernel.org, AJvYcCWeFk7m+P9XRxcMg5BnYxPyG0r9D49ip2h9FFCYdQdiQzF23yQKCK8ahnIZ8hNydfQbHq59Tw/ucwq01oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb16Err/eKSowM4wf2WlTXzUvgXOtET2jsCne4RgaP+FhQL0qX
	qoTydqCDvaN61O3/KUcb1jb6eFPh2q4u9Lz4yR7j0x1ToEogdBdwOika2Nn21hN4U8UOWxdEctA
	iNieCmXA8NvPj/WhEPxAgHDtvLY8=
X-Gm-Gg: ASbGncsm//1FC/NgwvjrmB+zpZVbYR3m57Lwxt3RdlHZIvazl/DoQINJ5dR98OdNf2S
	YukdCaZCrUmUIDDp/Ds9IKkX/O8PTr9E=
X-Google-Smtp-Source: AGHT+IFeHhLBLADhTmN6NURSzRgBeGkE7BulzP2DU+xkLm6ttNjZngS+9SrzBgqtUNZ+usG4nnueqm1tD6g1F6iovJk=
X-Received: by 2002:a17:90b:35c7:b0:2ea:9ccb:d1fe with SMTP id
 98e67ed59e1d1-2eaca1f5ab5mr1109554a91.0.1732062002160; Tue, 19 Nov 2024
 16:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
 <20241115160816.09df40eb@kernel.org> <CAJwJo6ax-Ltpa2xY7J7VxjDkUq_5NJqYx_g+yNn9yfrNHfWeYA@mail.gmail.com>
 <20241115175838.4dec771a@kernel.org> <CAJwJo6YdAEj1GscO-DQ2hAHeS3cvqU_xev3TKbpLSqf-EqiMiQ@mail.gmail.com>
 <20241118161243.21dd9bc0@kernel.org>
In-Reply-To: <20241118161243.21dd9bc0@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 20 Nov 2024 00:19:50 +0000
Message-ID: <CAJwJo6YcPt5+9uQt4yuYS_7o+O8ubjEgOBrq9RmH+b8OpJxdGA@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ivan Delalande <colona@arista.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Davide Caratti <dcaratti@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Nov 2024 at 00:12, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sat, 16 Nov 2024 03:52:47 +0000 Dmitry Safonov wrote:
> > Kind of agree. But then, it seems to be quite rare. Even on a
> > purposely created selftest it fires not each time (maybe I'm not
> > skilful enough). Yet somewhat sceptical about a re-try in the kernel:
> > the need for it is caused by another thread manipulating keys, so we
> > may need another re-try after the first re-try... So, then we would
> > have to introduce a limit on retries :D
>
> Wouldn't be the first time ;)
> But I'd just retry once with a "very large" buffer.
>
> > Hmm, what do you think about a kind of middle-ground/compromise
> > solution: keeping this NLM_F_DUMP_INTR flag and logic, but making it
> > hardly ever/never happen by purposely allocating larger skb. I don't
> > want to set some value in stone as one day it might become not enough
> > for all different socket infos, but maybe just add 4kB more to the
> > initial allocation? So, for it to reproduce, another thread would have
> > to add 4kB/sizeof(tcp_diag_md5sig) = 4kB/100 ~= 40 MD5 keys on the
> > socket between this thread's skb allocation and filling of the info
> > array. I'd call it "attempting to be nice to a user, but not at their
> > busylooping expense".
>
> The size of the retry buffer should be larger than any valid size.
> We can add a warning if calculated size >= 32kB.

Currently, md5/ao keys are limited by sock_kmalloc(), which uses
optmem_max sysctl limit. The default nowadays is 128KB.

From [1] I see that the current in-kernel (struct tcp_md5sig_key) hits
optmem_max on
# ok 38 optmem limit was hit on adding 655 key
IOW, with the default limit and sizeof(struct tcp_diag_md5sig) = 100,
the maximum skb size would be ~= 65Kb. Sounds a little too big for
kmemcache allocation.

Initially, my idea was to limit this old version of tcp-md5-diag by
U16_MAX. Now I'm thinking of adopting your idea by always allocating
32kB skb for single-message and marking it somehow, if it's not big
enough to fit all the keys on a socket (NLM_F_DUMP_INTR or any other
alternative for userspace to get a clue that the single message wasn't
enough).

Then, as I planned, teach the multi-message dump iterator to stop
between recvmsg() on N-th md5/ao key and continue the dump from that
key on the next recvmsg().

> If we support an inf number of md5 keys we need to cap it.

Yeah, unfortunately, we have some customers with 1000 peers (and
because of that we internally test BGP with even more peers).
And that's with an assumption of one key per peer, which is not
necessarily true for AO.

> Eric is back later this week, perhaps we should wait for his advice.

Sure, I will be glad to have advice from you both, thanks!

> > > Right, the table based parsing doesn't work well with multi-attr,
> > > but other table formats aren't fundamentally better. Or at least
> > > I never came up with a good way of solving this. And the multi-attr
> > > at least doesn't suffer from the u16 problem.
> >
> > Yeah, also an array of structs that makes it impossible to extend such
> > an ABI with new members.
> >
> > And with regards to u16, I was thinking of this diff for net-next, but
> > was not sure if it's worth it:
> >
> > diff --git a/lib/nlattr.c b/lib/nlattr.c
> > index be9c576b6e2d..01c5a49ffa34 100644
> > --- a/lib/nlattr.c
> > +++ b/lib/nlattr.c
> > @@ -903,6 +903,9 @@ struct nlattr *__nla_reserve(struct sk_buff *skb,
> > int attrtype, int attrlen)
> >  {
> >   struct nlattr *nla;
> >
> > + DEBUG_NET_WARN_ONCE(attrlen >= U16_MAX,
> > +     "requested nlattr::nla_len %d >= U16_MAX", attrlen);
> > +
> >   nla = skb_put(skb, nla_total_size(attrlen));
> >   nla->nla_type = attrtype;
> >   nla->nla_len = nla_attr_size(attrlen);
>
> I'm slightly worried that this can be triggered already from user
> space, but we can try DEBUG_NET_* and see. Here and in nla_nest_end().

Yeah, I thought that CONFIG_DEBUG_NET is not enabled on generic
distros, but the description is:
:          Enable extra sanity checks in networking.
:          This is mostly used by fuzzers, but is safe to select.

not sure if that guards any production users from enabling it.
But that would be interesting to see if, with those new additions,
netdev doesn't produce any warnings.

[1] https://netdev-3.bots.linux.dev/vmksft-tcp-ao/results/867500/14-setsockopt-closed-ipv4/stdout

Thanks,
             Dmitry

