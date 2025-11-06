Return-Path: <netdev+bounces-236531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEC0C3DB10
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 23:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56EC94E8BEE
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 22:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521A9348895;
	Thu,  6 Nov 2025 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kpEoxUN/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF499302CAE
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 22:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469522; cv=none; b=X+pKgYuJC+yFtDadjgKvYi8u07arpLi5mxvG6FoW7Lhd+ki40InWiSug7c+LLknWTr7wiIj4uhXg3ZQtKUw6lUhfBrIcRQbzIw1PcYdY4ijRJv3pYWYKa1JsijZ+6xWwHcO/g8RXngRDCgLHNfzOTWGA15P1SE0PRTMovzzPXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469522; c=relaxed/simple;
	bh=K6vs0598/wxVxv6ULBosbjkLZ7I3n8J8AI1tRHyjD9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TO6Oi+5mhZNRGDc9CFYJBedYLYGNb/71Kn7ijxfiTU0fGHW9Rina0A9b8zKunLGKItTRVSTqPVOgtH1AbFuCXv+xf+QzHyJ/8SeOIO2CP+wWhWPAEyiI1VUbzgJI7KlPIsaFtVMSSXlhcHRcs0Bw7Slv6/cHJJA6sdQwOYu174A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kpEoxUN/; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ba2450aba80so85991a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 14:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762469520; x=1763074320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwSKAxqy2SfLjpHB+T+r/Edcz4EGZRszuORPbU31So8=;
        b=kpEoxUN/T55IRAf08k9twSdK9anatSyTR3xf/UX3lf66qbPejYtBmbvbe4J3X78zbE
         HYZs6OQ2vULR1fpIsGTSMaw2qxvHLoZyc/HVShvG7n4w4l3ITt0BWxveK3tP0ScYlcdj
         gnNA2yjAXJ1YbDGeaeSErOME0jpLt9A6B/OsfsQOZ006iq02NeNEGv+8EqsQLZDTalfw
         wQmpZCsfQgIZ2vaJ4QEHd9cDUBSaVTx+vEtsx6a+IO3yRrj7e3ghsw7DUGjAVFMzu542
         vjloH7Jydh5wJSY2nJzVKvkk1Q++e+le3C5Gx+zuG84/WF+2DElpINMjXdbr3ycBuwOF
         AUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762469520; x=1763074320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NwSKAxqy2SfLjpHB+T+r/Edcz4EGZRszuORPbU31So8=;
        b=vr93ohcpJC83uAXk9L+AJi+Pcu+FBdzKhTHJnm/vsAWdO0uZgXNoRN570flAe3/Cdy
         UGyFEcpdgtpHN7C0mlEPK1KhcHYraysIefDhPF/YCJS1zOd5P4Nd2rt37WMEAC8ZxAyj
         V5JBWs+B2J5VcQ5KXVyyUmGC80dThrzDUthqi4v0LUGhiI9k8uaDbt7XUCMZ3p+E2Eep
         +FVJNOEUFuOgR9HpKVmVv+imNWVpvcO5CYJaMPTMXJ69BxWGU3g0jRmJlyRPneEHJ9aU
         mcZuBqtoMVivXivg3avpUEHJBln6PXIb7963kndEyfkWLEHhKc+DovWjfTVKeZENFIYs
         0LTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkQg0hN82Y3Eo6X0jlkUM1IMHqPBBRLdbsL2h6rSlxIYDy5zydMnXGPHHJT5+CcSaZzXJxAss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF7CaK1lOyflngZOLIH93NWqKLQSub+1g2a+AMhMsksH7SdyGZ
	c6Yp2ks9r0IlhxLNX9cj4GOj+fxU9ULSxS0XdmbxiiT2vh0zLorcDif/XjZ1ovDKoCceFsV4vtO
	QAMLUZ4H//VuiZ6SKhiIeprSRM5jAVXDdKB7Fk06q
X-Gm-Gg: ASbGncueZadS6OlbBvOoUhOwfDsEb4qtasevCDXbCRJYOPtbfosIMWbLCR5ACik0+BZ
	E+e/5sjL548vgq2MGZJaf/IDL2VT0bXqzJ/FBfa4jUVkkDuQdhdVz7dcAZBI1TaZQW8ltbGw1tj
	PhbwF2dGkD7flD4K/C/0GTa7pNxc4E/k6ZFJHGMhP/S0fHq4K0lfL3G5ml5+QFgPfv2uvmkDmeR
	NriUbG7CPKUMEQul+s/1DjyLpAviUsbKNjvCEIFQrhXrE7fzUzZDom4WWL9638UIKAjEWMINsb/
	LATgBINzF+ZBo7k=
X-Google-Smtp-Source: AGHT+IGoU/aDf7OWV1wxE/pbg/j83Yclpd9FA5WAljAUkIqN8hE4mqBZ/hGGtb4Pr1JR+yRNf96Df+4NZqUQWQVFI5E=
X-Received: by 2002:a17:903:f87:b0:295:e9af:8e4f with SMTP id
 d9443c01a7336-297c046b832mr14426155ad.52.1762469519910; Thu, 06 Nov 2025
 14:51:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <690c6ca9.050a0220.1e8caa.00d2.GAE@google.com> <20251106175926.686885-1-kuniyu@google.com>
 <20251106143004.55f4f3fc@kernel.org> <CAAVpQUBkFxS6Dm28n7uDoO+x63npwZWb925+Gs3UHz-gAZo7yQ@mail.gmail.com>
 <20251106143930.48e9ff2b@kernel.org>
In-Reply-To: <20251106143930.48e9ff2b@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 6 Nov 2025 14:51:48 -0800
X-Gm-Features: AWmQ_bkSip7YWSfFmRhzhF8kbiIFrPfdkb5r9Wpce9sVwgTueuUIkuC0jBfTe-c
Message-ID: <CAAVpQUBVyWBr6PqAOw7Js9_Jg4fDvVTvuJzoZ_ZCw0YKG2KWhQ@mail.gmail.com>
Subject: Re: [syzbot ci] Re: tipc: Fix use-after-free in tipc_mon_reinit_self().
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot+cif2d6d318f7e85f0b@syzkaller.appspotmail.com, davem@davemloft.net, 
	edumazet@google.com, hoang.h.le@dektech.com.au, horms@kernel.org, 
	jmaloy@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzbot@lists.linux.dev, syzbot@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 6 Nov 2025 14:37:10 -0800 Kuniyuki Iwashima wrote:
> > > On Thu,  6 Nov 2025 17:59:17 +0000 Kuniyuki Iwashima wrote:
> > > > -void tipc_mon_reinit_self(struct net *net)
> > > > +void tipc_mon_reinit_self(struct net *net, bool rtnl_held)
> > > >  {
> > > >       struct tipc_monitor *mon;
> > > >       int bearer_id;
> > > >
> > > > -     rtnl_lock();
> > > > +     if (!rtnl_held)
> > > > +             rtnl_lock();
> > >
> > > I haven't looked closely but for the record conditional locking
> > > is generally considered to be poor code design. Extract the body
> > > into a __tipc_mon_reinit_self() helper and call that when lock
> > > is already held? And:
> > >
> > > void tipc_mon_reinit_self(struct net *net)
> > > {
> > >         rtnl_lock();
> > >         __tipc_mon_reinit_self(net);
> > >         rtnl_unlock();
> > > }
> >
> > That's much cleaner, I'll use this.
>
> After sending I realized you probably want to do this wrapping around
> tipc_net_finalize(), otherwise we'd just be shifting the conditional.
> But you get the point.. :)

Yes, will wrap it in tipc_net_finalize_work() :)

