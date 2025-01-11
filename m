Return-Path: <netdev+bounces-157384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AFEA0A1FB
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765D216B756
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 08:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1D4156960;
	Sat, 11 Jan 2025 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGbIOqaL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B4610E9
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736584270; cv=none; b=o91oF0ESHnyy+EKq/86ejg+YnEiQjlZ0f4St2nzmcKHalwYZLVYflUsW5gJNT5VmMkBrhqwsd1z+xrsu6vS2j77reYQijpsTduabn69cCIp+y4eqxBWNkCL5TGUoKSS+Nw+cMVgp2iMnrqoWjAZETgSit6DSfIBYHpIXr+NJdeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736584270; c=relaxed/simple;
	bh=ucNEuEsqawAm53BJRaIXDyVIUwhyoHZAnELNTjiDAoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9LlO1J+Y3jWGX/ejbrS2P00DhNAfBKKxaWPRjOkbsJhNPM4DOAN+wAR94t2AoKxC+oB+Qu7ZsAmNzSXpbpjOMCk7irqlmtdfYHqeSBuFgI0xOqHsw3PlgqstAbKKNl6XAVwKsEvo6CTDqki8p8vpuXwyo8812t9rIDmJ68me9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGbIOqaL; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a8c7b02d68so17938395ab.3
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 00:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736584268; x=1737189068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBDCDFNtbAjmcOSF7YBQveTbVFnBCaDxZLows1Fg8ZU=;
        b=MGbIOqaLchk1Ve9H5SHBz2ygUZg8hAGb0L6hMMt9pDaEV0KmYtAPBItSlw7/L+ylAq
         +iOUiFL4Bt9xO7wmB35bng2xSM5JOZChSJhrMjCo+kvqVtykTUXJGYkIxqgHYQBqTJvJ
         38HjRc12vSlbH3iuSsMwisT1FVdqZJulIro7bPbrNHxsdZnOdnreyfHGZEhIAIQYuq/F
         h/kLBHHNHKwnYOir2yoiQrd7875JgAljHCj3AwBYkTfF5tti8Roa7ZTYnb8wyk8m554V
         +180aFae+TagGD9S1zM9UgKi+lBB+uYAViNgF6Okf+h790KKTXCkV/1CGkyB7/FcqGzk
         1VNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736584268; x=1737189068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBDCDFNtbAjmcOSF7YBQveTbVFnBCaDxZLows1Fg8ZU=;
        b=j/pYpvpqfnxzgikHOMA2JkEpoOt5QkmvjNScRaG+Yo2W2cJNvAKp0S/ik0y/P/NXfS
         EKndRzB6QcXXA1NGVMAOt1+Q+l5ffPagrKwMp8xVaIGZCMxQD8XXCH9jnPE3pSHuhXh1
         2s0Yrs9oiPK4DB1+901/FG0wOs5D6vcl3tGGEjMQofuYbRH7cvKA8p1SweuSkC9gGf10
         koluPliXvry0mooZzHoDhdHkidtLCBPu03pM1f2ZbEiGu/glH+Po15MipJeY8uINJcUn
         mutXUJ1+jweBI5gT2Cs5jsPVK1HRD7V23GpDx/rUqsBo8SvRepyqTsvSu+nSBMlABQ51
         gfEA==
X-Forwarded-Encrypted: i=1; AJvYcCVGSTjCbD42WfTlBoOzMSvCwLFPoUNXe847GKZi0HBVdelBgCyIpmhVT7ARY9q1EuwrlkWRq0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaRq4+icvXpM3OpsFa9jgonQHo3K7Y5G35pwLCTRcjGQ+rArUz
	Fg7FnA3kVGAa9YObdRiXj46xHfAYvpbVYG9Rla4v5gJp9nTFWXosTUe2vgh7Kf9+KwMu9eI4blf
	qCu/fFldaz/1VzHQ/CJG4NkN5nLM/KLPk
X-Gm-Gg: ASbGnctJLrWvy+R9o3mie/NnkatY0WWtI8XW8C8HDypbOO78Bnlzq5NmxhzK6wYLRXo
	YWOiGZ67quWB1IiWhghh5cUksBcwEqwQpmwdH
X-Google-Smtp-Source: AGHT+IHffGH7TtuwYaSh7k7YKfQTw1Cg3I5epBLO663NCHlUG5RGDhZH7VorCCHgrLthQq5mX83hU0CSYeBPfjTpZVk=
X-Received: by 2002:a05:6e02:1aad:b0:3ce:6828:896c with SMTP id
 e9e14a558f8ab-3ce68288e6bmr3605125ab.1.1736584268459; Sat, 11 Jan 2025
 00:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106181219.1075-1-ouster@cs.stanford.edu> <20250106181219.1075-8-ouster@cs.stanford.edu>
 <20250110092537.GA66547@j66a10360.sqa.eu95> <CAGXJAmyYmizvm350vSGmJqdOt8d+d0soP95FGhBUQ5nr8kNqnw@mail.gmail.com>
In-Reply-To: <CAGXJAmyYmizvm350vSGmJqdOt8d+d0soP95FGhBUQ5nr8kNqnw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 11 Jan 2025 16:30:32 +0800
X-Gm-Features: AbW1kvYIEQZdJs7YWcpMjMbe7up0tj1Vg5Rse4C8M-4VS_yQfc6Nicei2SoJKWs
Message-ID: <CAL+tcoCOSk2ezZ+OnsKBZc_JcO_U01X1q3KmTd6WhObuzbuzsA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 07/12] net: homa: create homa_sock.h and homa_sock.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, netdev@vger.kernel.org, pabeni@redhat.com, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 8:20=E2=80=AFAM John Ousterhout <ouster@cs.stanford=
.edu> wrote:
>
> On Fri, Jan 10, 2025 at 1:25=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.c=
om> wrote:
> >
> > > +void homa_sock_unlink(struct homa_sock *hsk)
> > > +{
> > > +     struct homa_socktab *socktab =3D hsk->homa->port_map;
> > > +     struct homa_socktab_scan *scan;
> > > +
> > > +     /* If any scans refer to this socket, advance them to refer to
> > > +      * the next socket instead.
> > > +      */
> > > +     spin_lock_bh(&socktab->write_lock);
> > > +     list_for_each_entry(scan, &socktab->active_scans, scan_links) {
> > > +             if (!scan->next || scan->next->sock !=3D hsk)
> > > +                     continue;
> > > +             scan->next =3D (struct homa_socktab_links *)
> > > +                             rcu_dereference(hlist_next_rcu(&scan->n=
ext->hash_links));
> > > +     }
> >
> > I can't get it.. Why not just mark this sock as unavailable and skip it
> > when the iterator accesses it ?
> >
> > The iterator was used under rcu and given that your sock has the
> > SOCK_RCU_FREE flag set, it appears that there should be no concerns
> > regarding dangling pointers.
>
> The RCU lock needn't be held for the entire lifetime of an iterator,
> but rather only when certain functions are invoked, such as
> homa_socktab_next. Thus it's possible for a socket to be reclaimed and
> freed while a scan is in progress. This is described in the comments
> for homa_socktab_start_scan. This behavior is necessary because of
> homa_timer, which needs to call schedule in the middle of a scan and
> that can't be done without releasing the RCU lock. I don't like this
> complexity but I haven't been able to find a better alternative.
>
> > > +     hsk->shutdown =3D true;
> >
> > From the actual usage of the shutdown member, I think you should use
> > sock_set_flag(SOCK_DEAD), and to check it with sock_flag(SOCK_DEAD).
>
> I wasn't aware of SOCK_DEAD until your email. After poking around a
> bit to learn more about SOCK_DEAD, I am nervous about following your
> advice. I'm still not certain exactly when SOCK_DEAD is set or who is
> allowed to set it. The best information I could find was from ChatGPT
> which says this:
>
> "The SOCK_DEAD flag indicates that the socket is no longer referenced
> by any user-space file descriptors or kernel entities. Essentially,
> the socket is considered "dead" and ready to be cleaned up."

Well, I'm surprised that the GPT is becoming more and more intelligent...

The above is correct as you can see from this call trace
(__tcp_close()->sk_orphan()). Let me set TCP as an example, when the
user decides to close a socket or accidently kill/exit the process,
the socket would enter into __tcp_close(), which indicates that this
socket has no longer relationship with its owner (application).

>
> If ChatGPT isn't hallucinating, this would suggest that Homa shouldn't
> set SOCK_DEAD, since the conditions above might not yet be true when
> homa_sock_shutdown is invoked.

Introducing a common usage about SOCK_DEAD might be a good choice. But
if it's not that easy to implement, I think we can use the internal
destruction mechanism instead like you did.

>
> Moreover, I'm concerned that some other entity might set SOCK_DEAD
> before homa_sock_shutdown is invoked, in which case homa_sock_shutdown
> would not cleanup the socket properly.

No need to worry about that. If it happens, it usually means there is
a bug somewhere and then we will fix it.

Thanks,
Jason

>
> Thus, it seems safest to me for Homa to have its own shutdown flag.
>
> Let me know if you still think Homa should use SOCK_DEAD.
>
> > > +
> > > +     while (!list_empty(&hsk->dead_rpcs))
> > > +             homa_rpc_reap(hsk, 1000);
> >
> > I take a quick look at homa_rpc_reap, although there is no possibility
> > of an infinite loop founded currently, it still raises concerns.
> >
> > It might be better to let homa_rpc_reap() handle this kind of actions b=
y itself.
> > For example, code like that:
> >
> > homa_rpc_reap(hsk, 0, flags=3DRPC_FORCE_REAP|RPC_REAP_ALL);
> >
> > In this way, anyone making modifications to homa_rpc_reap() in the futu=
re will
> > at least be aware that there is such a case that needs to be handled we=
ll.
>
> I have changed the API for homa_rpc_reap to this:
>
> int homa_rpc_reap(struct homa_sock *hsk, bool reap_all)
>
> The caller can no longer specify a count. When reap_all isn't
> specified, homa_rpc_reap determines for itself what represents a
> "small amount of work" to perform; no need for the caller to figure
> this out.
>
> -John-
>

