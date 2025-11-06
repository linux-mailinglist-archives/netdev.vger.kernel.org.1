Return-Path: <netdev+bounces-236526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EBDC3DA10
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 23:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CDB3A7D70
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 22:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AB93FBA7;
	Thu,  6 Nov 2025 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HkvJPRbc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB62F6919
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468646; cv=none; b=PQaNuGnPPSKIjT2WA+qx3kBbhyg52WYRBABPsvFSz+SlWjHXZPclb2mUnLd/e3OXjX0EgwdenMpVWogtC8DnnP/btnADwdRykhq5kxYb1/YlOfUdHVra/qSAKkQZDkq5wUObNzNEOWBBobvYF5gnTRpG6fVSgC+qvnHAs1B5CW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468646; c=relaxed/simple;
	bh=Zq1qKA7EZccEUyWoFMZOaVBIr6IqNptziO3p9QoDC3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WumU5W1Ioe+tjPaQ6UGCEnKUnB5dEDCwU74yxXA2zX9LJfJo0p7sYcju/ze9eltI4M6hISBZRattgVbvMjF4KGcodjSO513Iv0nFXETzVdCnAq8skyzUwINkvnrBpyVxAokeSKGuQiOxUpl4iKkeHzBqdK2PRRaq5QDBSA+m+EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HkvJPRbc; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so108509a12.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 14:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762468644; x=1763073444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqh/7rFu75Tw9K3uiwtNgsD2r+BPLCM0k5HVbPy8hps=;
        b=HkvJPRbcP5L3oqMJ70mQZmqkzykZhrx3uH6V78Ml9eTkSiru1iLiIES9IpMT77iq6k
         VE7mJ90E+ygznNcImKm9JpVLRs1BR26PkDo+XJ3rdZOqJx7O5FCbMa/rQ+5gFaBzs61x
         GRcb0Nb/nue0NL7/VFu8oNAkzbflkhdjeDtfLvrwsNfVpaU3+eOO3w1ltK3YvdE7ln3+
         Rof3xQqP9H5ElxYQ7YeHeCnY/31ZdSQ308tWvrYTTK5zaxMZ9ImcSudiovlos6Y8Xp7i
         aInisRYCTvhUMJre8Rw2l3/mAVS53fLqvaMusrowFSPvk3mScWQc+CUo7N5RnZNExeRL
         cGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762468644; x=1763073444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wqh/7rFu75Tw9K3uiwtNgsD2r+BPLCM0k5HVbPy8hps=;
        b=Uk5zSVYg/gIoEPqBXVzMeRi2BeMwNOvJLwURcRzEypRWaKjkvbuHUKCzPfSEaRUJg+
         Ju2MgQR4b1EidsJZPmOvyHlydsJNzOwYF1jIfyHoVh2dnPn/vL8495SQtg/hRp33ke6k
         80bcVS2bINJvk6OwxLqNFYt/nEoujtpfTs41glF5V52R5+IoyZa8GNbDxkOkQdi67Eaf
         YEFQm2DMPh6lCO9rmvJMGAO/holnCIe71v9aRXy+tUtAKQ1W4OkOX+A0CQXrEgxdj3ea
         Xqpy2u9vUTJsOfObDa+a36RbPzLR2DPbdfLyrmja1iHN0R+yXXAmUzcZF0G+cgJUNPvU
         yojQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR1biJHSP58oJwg6Ab6ALla2HCaWVDJhVctjV37vj4+FCTS6BxP+d8ujtPku0HvnbqSUNRt38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4vP2eq8Nd1xHi45j9GoZ346sLIHbBVVwA/ziunsYWbh4vG/Qh
	VFKZwmYzwb1o3UpXYrIc58IpfrYoB7RqUxjhtsmDhjSW3GfRnygeqiIJmdFZ6oFtjV6pCE4y+Uq
	Q4lBPJyfeaEZV5MOQ4p8dcKtfYPYZOqpq1dsqUYH3
X-Gm-Gg: ASbGnctLuqnn2gK8xLCjj5OcdNnpbLltPuBHpUc82vdQfeg47ArCrvYEw5XMUukZisO
	OEKIX+6g+IOkjOSIi8bwEkS6Z/CTQxq5PDFrxW/85lQgyykD2+0rMDDLkinIReNR5m0uYk5Ci88
	UpY+S8s0g24LYOSpyfxhOzSdc4OxxMm9bTN0Wt19xqi3gIWgSMDN7HGnwmq9508Ycpa5JDq2Om6
	x6qRu9aCSCEt4jFlHT088MzDCKRg09/us1kv3CPIcERmR4CuixzZtaOGFd8AReMjBYgoYfM3utV
	Pxo28LnAfSiisNhLrA==
X-Google-Smtp-Source: AGHT+IFmTgBghJ4Z63fdzU76btJu2WQ9IXUf7TvnuoUNE4+PNenxcDLQl4UARxupttHUWsPvt3LaA2/eg6SDP3jnrxo=
X-Received: by 2002:a17:902:da48:b0:27d:6f49:febc with SMTP id
 d9443c01a7336-297c038c617mr14658455ad.1.1762468644160; Thu, 06 Nov 2025
 14:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <690c6ca9.050a0220.1e8caa.00d2.GAE@google.com> <20251106175926.686885-1-kuniyu@google.com>
 <20251106143004.55f4f3fc@kernel.org>
In-Reply-To: <20251106143004.55f4f3fc@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 6 Nov 2025 14:37:10 -0800
X-Gm-Features: AWmQ_bksc9oUawq3yqH36NtmDo0ccenJFt0JFKuoavuRugfDXyvaxpAeV7_fcSs
Message-ID: <CAAVpQUBkFxS6Dm28n7uDoO+x63npwZWb925+Gs3UHz-gAZo7yQ@mail.gmail.com>
Subject: Re: [syzbot ci] Re: tipc: Fix use-after-free in tipc_mon_reinit_self().
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot+cif2d6d318f7e85f0b@syzkaller.appspotmail.com, davem@davemloft.net, 
	edumazet@google.com, hoang.h.le@dektech.com.au, horms@kernel.org, 
	jmaloy@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzbot@lists.linux.dev, syzbot@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  6 Nov 2025 17:59:17 +0000 Kuniyuki Iwashima wrote:
> > -void tipc_mon_reinit_self(struct net *net)
> > +void tipc_mon_reinit_self(struct net *net, bool rtnl_held)
> >  {
> >       struct tipc_monitor *mon;
> >       int bearer_id;
> >
> > -     rtnl_lock();
> > +     if (!rtnl_held)
> > +             rtnl_lock();
>
> I haven't looked closely but for the record conditional locking
> is generally considered to be poor code design. Extract the body
> into a __tipc_mon_reinit_self() helper and call that when lock
> is already held? And:
>
> void tipc_mon_reinit_self(struct net *net)
> {
>         rtnl_lock();
>         __tipc_mon_reinit_self(net);
>         rtnl_unlock();
> }

That's much cleaner, I'll use this.

Thanks, Jakub!

