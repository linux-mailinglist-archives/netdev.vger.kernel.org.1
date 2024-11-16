Return-Path: <netdev+bounces-145545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A039CFCA2
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 04:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6825B26D14
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 03:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B991D17BB0D;
	Sat, 16 Nov 2024 03:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ccg2aF1e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A63126BE6;
	Sat, 16 Nov 2024 03:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731729181; cv=none; b=RD8pvFaWT14JdFiK9FZkjpd0XzZg3DNglY5r4w7NCuG9Y780QRrdkAVI9PYgHcXHfxskNXjRrnxKgBz5ZhvQU89gy5yJpNZdZyHKZHkxmPJwm5mX1/fZ1559T6dBZQrgNw+WY1LhD69Z2tPLkyacdQ0FzD253L9NJdMd+NWXdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731729181; c=relaxed/simple;
	bh=a3ziXhQhmHQ0vA7AjZjsO6DPSj0qovCeoArD26q9LA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqBY2eiyq1181QycHd6n+HOKxUcqesXNKSfhyAqUjMGMuxgl4tK5+jpDBIP607D7Wvj6k24mN2LzWlqYWTQGH5BO7Cghj3KdF4THbr1JNjZVN6JRys8WRDTjWfCgG2fagIMGqWhFmubzVWhP3CCiKjxpXG6akdSzebssvqTA6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ccg2aF1e; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f8cc29aaf2so664730a12.3;
        Fri, 15 Nov 2024 19:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731729178; x=1732333978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0a1LFZe7mhPiCdYnydxfbs4tmbiylajqw5WUGlsha3I=;
        b=Ccg2aF1eYvN/9ZxE6E0BRlLZxZ9n2hXvRVdpckTQDakyo6BPeEy5S2HRYbPLfprzyN
         ofuGldcKHttHqvaWrO29DrckkQCyEN5U03tabbiGr3/ADclWAMSXcq9NbFtCJJAurEbH
         uQLJJO4hKGGaUWaUM2a49vocFRO+xr99qqwf1g/1wNnt76KjaFC0o/Ilhc/ct3QpfZWn
         iw4+JDfmLegMrDZ4j5lPbIJRxXQXtNdEU7OsxIuPg1ZuDEcGyd3blCwBKWus5bR8smYP
         rKZU5wL0P1oF0PSHWzp2ai9vivQ/Gf9olYb6qdDDRQpeISmqljrSpjH1rMVUhr79pKZH
         XMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731729178; x=1732333978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0a1LFZe7mhPiCdYnydxfbs4tmbiylajqw5WUGlsha3I=;
        b=I29UwwoApLgtuJIt+GfQ+svPqOxvQrJKnNmjVK42OF5fCMpsIWzVT4+cYQ72CIi484
         hVjfcMQw8i2pbszrRzQM+AcAs0QwLJbHk8NHHm6R1Yf771KMdwngAWntttcL3C+vitlE
         MMIwvdoD3KBiOCsR1jt14u6asDokRXxHepauUwS2PYkrUZgdzA9zKEN6fh8KiZZRQHTD
         WF9c1J9tPHtyiOKMawHL9RZ0I5RsNLLbg4N7x5A/iOOQormFkwlaT0idSprX+N7Xf3KF
         X3pfisY8BtU96/NcPdgH0cCo0ZAswA8OpnjptFxaTN8p6t7o7bxVbFK4aSTNyiZNUvDr
         KrMA==
X-Forwarded-Encrypted: i=1; AJvYcCWORfFXIqmRzm+YNzsikNrfpvtO7AUiWgcmdzeGaNvkh4g6qES5Wx11ByD0m5qjFO4cHXdwxb/G@vger.kernel.org, AJvYcCXgXArzi5oFqLeMlcyq1CK3vgfuZwRlVLizw7H8M1okqZPrxkKPfLna/XG3AMHDPFnWaXPWW9P7fmPc+Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm+tV9HWoobk3E4Kg2dyTKnNjQsRtkjZFGVnLJrS1Zf24E3pIP
	fx5z+AMRj5oNcIK49RGNf2ilt1+CYt3ffbX7NbMPUtLkL6jO3ZsizLH+7LsEr6BM/TJqp9SgXmC
	BgnYArIE1GYH9NcWJD1NoYdF+U2o=
X-Google-Smtp-Source: AGHT+IEFUKFM2wbR8eLssBH3u61VGNgNPx8MQA8aMhcofW24BafDDbKsmR7m0RlbzXs89pxamk77eCK3z2P+QVEDy3g=
X-Received: by 2002:a17:90b:2402:b0:2ea:2a8d:dd2a with SMTP id
 98e67ed59e1d1-2ea2a8dee1fmr2837292a91.27.1731729178457; Fri, 15 Nov 2024
 19:52:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
 <20241115160816.09df40eb@kernel.org> <CAJwJo6ax-Ltpa2xY7J7VxjDkUq_5NJqYx_g+yNn9yfrNHfWeYA@mail.gmail.com>
 <20241115175838.4dec771a@kernel.org>
In-Reply-To: <20241115175838.4dec771a@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Sat, 16 Nov 2024 03:52:47 +0000
Message-ID: <CAJwJo6YdAEj1GscO-DQ2hAHeS3cvqU_xev3TKbpLSqf-EqiMiQ@mail.gmail.com>
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

On Sat, 16 Nov 2024 at 01:58, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sat, 16 Nov 2024 00:48:17 +0000 Dmitry Safonov wrote:
> > On Sat, 16 Nov 2024 at 00:08, Jakub Kicinski <kuba@kernel.org> wrote:
> > > Would it be too ugly if we simply retried with a 32kB skb if the initial
> > > dump failed with EMSGSIZE?
> >
> > Yeah, I'm not sure. I thought of keeping it simple and just marking
> > the nlmsg "inconsistent". This is arguably a change of meaning for
> > NLM_F_DUMP_INTR because previously, it meant that the multi-message
> > dump became inconsistent between recvmsg() calls. And now, it is also
> > utilized in the "do" version if it raced with the socket setsockopts()
> > in another thread.
>
> NLM_F_DUMP_INTR is an interesting idea, but exactly as you say NLM_F_DUMP_INTR
> was a workaround for consistency of the dump as a whole. Single message
> we can re-generate quite easily in the kernel, so forcing the user to
> handle INTR and retry seems unnecessarily cruel ;)

Kind of agree. But then, it seems to be quite rare. Even on a
purposely created selftest it fires not each time (maybe I'm not
skilful enough). Yet somewhat sceptical about a re-try in the kernel:
the need for it is caused by another thread manipulating keys, so we
may need another re-try after the first re-try... So, then we would
have to introduce a limit on retries :D

Hmm, what do you think about a kind of middle-ground/compromise
solution: keeping this NLM_F_DUMP_INTR flag and logic, but making it
hardly ever/never happen by purposely allocating larger skb. I don't
want to set some value in stone as one day it might become not enough
for all different socket infos, but maybe just add 4kB more to the
initial allocation? So, for it to reproduce, another thread would have
to add 4kB/sizeof(tcp_diag_md5sig) = 4kB/100 ~= 40 MD5 keys on the
socket between this thread's skb allocation and filling of the info
array. I'd call it "attempting to be nice to a user, but not at their
busylooping expense".

> > > Just putting the same attribute type multiple times is preferable
> > > to array types.
> >
> > Cool. I didn't know that. I think I was confused by iproute way of
> > parsing [which I read very briefly, so might have misunderstood]:
> > : while (RTA_OK(rta, len)) {
> > :         type = rta->rta_type & ~flags;
> > :         if ((type <= max) && (!tb[type]))
> > :                 tb[type] = rta;
> > :         rta = RTA_NEXT(rta, len);
> > : }
> > https://github.com/iproute2/iproute2/blob/main/lib/libnetlink.c#L1526
> >
> > which seems like it will just ignore duplicate attributes.
> >
> > That doesn't mean iproute has to dictate new code in kernel, for sure.
>
> Right, the table based parsing doesn't work well with multi-attr,
> but other table formats aren't fundamentally better. Or at least
> I never came up with a good way of solving this. And the multi-attr
> at least doesn't suffer from the u16 problem.

Yeah, also an array of structs that makes it impossible to extend such
an ABI with new members.

And with regards to u16, I was thinking of this diff for net-next, but
was not sure if it's worth it:

diff --git a/lib/nlattr.c b/lib/nlattr.c
index be9c576b6e2d..01c5a49ffa34 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -903,6 +903,9 @@ struct nlattr *__nla_reserve(struct sk_buff *skb,
int attrtype, int attrlen)
 {
  struct nlattr *nla;

+ DEBUG_NET_WARN_ONCE(attrlen >= U16_MAX,
+     "requested nlattr::nla_len %d >= U16_MAX", attrlen);
+
  nla = skb_put(skb, nla_total_size(attrlen));
  nla->nla_type = attrtype;
  nla->nla_len = nla_attr_size(attrlen);
--->8---

Thanks,
             Dmitry

