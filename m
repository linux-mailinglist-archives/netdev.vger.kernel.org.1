Return-Path: <netdev+bounces-157825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BF3A0BEAA
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A4C3A9C69
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9FC1FBBE8;
	Mon, 13 Jan 2025 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="WRAY7N9+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C661FBBD3
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788356; cv=none; b=Qj3ANbuwBqBzaZc2HNjY+LYweBfRrDxA4vf693h7ros3H1X19ERNE4a64MyWNCPebg4Reau5RY9qMIsNnkyDsMNmI3F7foQxsRANdDt5p+SiagwoLNPDa5y4k+XR65V02kqa/RtZFxnyC1HwECp5Uk5DGaBX8Hx5xEyteRgoXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788356; c=relaxed/simple;
	bh=bn2X/31DeTAdZIPRs+q67hQscMz0ehP2bu3W+277cMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFLmjwxzQ8Fu+UD1lmAFbNZNovyOP0IPyOhX+cIFSCIbqqQSruNmDXlN7b0ZNqLLxwQs/ibYGnBt6x5qLoWZuvh1uaJzoPyqATVJmR3XwxmaA5xTeqgOR8UNJwPwoffo/NgJHWQya2r39nPU8mn2wR9+fUXNZYZ+mv1s8HmnbJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=WRAY7N9+; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8sPk5RBIpSmdCcv4pVL7PlKrQ4PtyrleBXQmVe4hAtQ=; t=1736788355; x=1737652355; 
	b=WRAY7N9+FTdFE6SWO6MMfQ444Au7FibqtHz09xmwNj9TKAHHO631KSyZqg59VEpheEEqJ12utTm
	mIR3+bttIhgwtnI2v8brwo3o5vGpQzpkTBuLoW3AUgkHa+uVzyGMtQ/qCJWeffcUKx1AlT+5F7ZqL
	qOXz7O7OZ5VZ304ngBoDiKSdMGrfW2ThQ9Mpt57P8YGw0L/7GnMJMhOVj/XPPE4VjqChiJUCRlrJX
	tn5VVFG+buNqBXMxshbOl8RftgmFZpFoMlnbMTX9WdSVQuwc8phbIlFT1wIqUoF48VfqprJ49NLP1
	NsxaEzYJ+uJnqv5H8cAXSdW+ukr1aTLAi4hw==;
Received: from mail-oo1-f48.google.com ([209.85.161.48]:61587)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tXNzH-0001vo-AD
	for netdev@vger.kernel.org; Mon, 13 Jan 2025 09:12:28 -0800
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5f2efd94787so2752279eaf.2
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 09:12:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLXyFpMhPpe/AOn1Qmf8pMTLNwOgzA2gJ4qqa6292/OftaHELMkjBrlTMZ7xb7q+n+zS2FkYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt8RRSejgvG6k3uZK+xwSx0t/NQ2p/sOVBt/z+1mytSkXn679+
	fek3K6tUXsAlirs8JEnZ18Sk4qD7+INmgxdwIyyvveVXcEIUyCK7Xf6nEqjynuTCEA9ifTZ7SEp
	pwhmgamMWl4BcEUrzJxW0iYlKyNE=
X-Google-Smtp-Source: AGHT+IFV2dSPyQUeOXgo1+IUM8e3n2rWRXTrpQ4GujBi5IptrdWRSrBaBpdbCmODi5Rk1DBi3J2gVRY2RNtLVNrNRZA=
X-Received: by 2002:a05:6870:ae0c:b0:297:274d:1c38 with SMTP id
 586e51a60fabf-2aa066b202bmr11172776fac.18.1736788346749; Mon, 13 Jan 2025
 09:12:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106181219.1075-1-ouster@cs.stanford.edu> <20250106181219.1075-8-ouster@cs.stanford.edu>
 <20250110092537.GA66547@j66a10360.sqa.eu95> <CAGXJAmyYmizvm350vSGmJqdOt8d+d0soP95FGhBUQ5nr8kNqnw@mail.gmail.com>
 <CAL+tcoCOSk2ezZ+OnsKBZc_JcO_U01X1q3KmTd6WhObuzbuzsA@mail.gmail.com>
In-Reply-To: <CAL+tcoCOSk2ezZ+OnsKBZc_JcO_U01X1q3KmTd6WhObuzbuzsA@mail.gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 13 Jan 2025 09:11:51 -0800
X-Gmail-Original-Message-ID: <CAGXJAmzCx6NJGeHrW+CB6+Uc0_DDBMJRMzfCbCs3FNGcdBtX3w@mail.gmail.com>
X-Gm-Features: AbW1kvZ-8nIbxImVNsCRZm6B0JsiCnm3ja1uUiF4n1phXBGlA886Zus3q2twH2k
Message-ID: <CAGXJAmzCx6NJGeHrW+CB6+Uc0_DDBMJRMzfCbCs3FNGcdBtX3w@mail.gmail.com>
Subject: Re: [PATCH net-next v5 07/12] net: homa: create homa_sock.h and homa_sock.c
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, netdev@vger.kernel.org, pabeni@redhat.com, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: dfe9a19d2d5d3f4658608889c96f7beb

On Sat, Jan 11, 2025 at 12:31=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Sat, Jan 11, 2025 at 8:20=E2=80=AFAM John Ousterhout <ouster@cs.stanfo=
rd.edu> wrote:
> >
> > On Fri, Jan 10, 2025 at 1:25=E2=80=AFAM D. Wythe <alibuda@linux.alibaba=
.com> wrote:
> > >
> > > > +void homa_sock_unlink(struct homa_sock *hsk)
> > > > +{
> > > > +     struct homa_socktab *socktab =3D hsk->homa->port_map;
> > > > +     struct homa_socktab_scan *scan;
> > > > +
> > > > +     /* If any scans refer to this socket, advance them to refer t=
o
> > > > +      * the next socket instead.
> > > > +      */
> > > > +     spin_lock_bh(&socktab->write_lock);
> > > > +     list_for_each_entry(scan, &socktab->active_scans, scan_links)=
 {
> > > > +             if (!scan->next || scan->next->sock !=3D hsk)
> > > > +                     continue;
> > > > +             scan->next =3D (struct homa_socktab_links *)
> > > > +                             rcu_dereference(hlist_next_rcu(&scan-=
>next->hash_links));
> > > > +     }
> > >
> > > I can't get it.. Why not just mark this sock as unavailable and skip =
it
> > > when the iterator accesses it ?
> > >
> > > The iterator was used under rcu and given that your sock has the
> > > SOCK_RCU_FREE flag set, it appears that there should be no concerns
> > > regarding dangling pointers.
> >
> > The RCU lock needn't be held for the entire lifetime of an iterator,
> > but rather only when certain functions are invoked, such as
> > homa_socktab_next. Thus it's possible for a socket to be reclaimed and
> > freed while a scan is in progress. This is described in the comments
> > for homa_socktab_start_scan. This behavior is necessary because of
> > homa_timer, which needs to call schedule in the middle of a scan and
> > that can't be done without releasing the RCU lock. I don't like this
> > complexity but I haven't been able to find a better alternative.
> >
> > > > +     hsk->shutdown =3D true;
> > >
> > > From the actual usage of the shutdown member, I think you should use
> > > sock_set_flag(SOCK_DEAD), and to check it with sock_flag(SOCK_DEAD).
> >
> > I wasn't aware of SOCK_DEAD until your email. After poking around a
> > bit to learn more about SOCK_DEAD, I am nervous about following your
> > advice. I'm still not certain exactly when SOCK_DEAD is set or who is
> > allowed to set it. The best information I could find was from ChatGPT
> > which says this:
> >
> > "The SOCK_DEAD flag indicates that the socket is no longer referenced
> > by any user-space file descriptors or kernel entities. Essentially,
> > the socket is considered "dead" and ready to be cleaned up."
>
> Well, I'm surprised that the GPT is becoming more and more intelligent...
>
> The above is correct as you can see from this call trace
> (__tcp_close()->sk_orphan()). Let me set TCP as an example, when the
> user decides to close a socket or accidently kill/exit the process,
> the socket would enter into __tcp_close(), which indicates that this
> socket has no longer relationship with its owner (application).
>
> >
> > If ChatGPT isn't hallucinating, this would suggest that Homa shouldn't
> > set SOCK_DEAD, since the conditions above might not yet be true when
> > homa_sock_shutdown is invoked.
>
> Introducing a common usage about SOCK_DEAD might be a good choice. But
> if it's not that easy to implement, I think we can use the internal
> destruction mechanism instead like you did.
>
> >
> > Moreover, I'm concerned that some other entity might set SOCK_DEAD
> > before homa_sock_shutdown is invoked, in which case homa_sock_shutdown
> > would not cleanup the socket properly.
>
> No need to worry about that. If it happens, it usually means there is
> a bug somewhere and then we will fix it.

I'm not quite sure what you are recommending in your comments above
(i.e. should Homa try to use SOCK_DEAD or stick with the current
approach of having a separate Homa-specific flag indicating that the
socket has been shutdown). Based on what I've heard so far I still
prefer having a separate flag because it eliminates any possibility of
confusion between Homa's use of SOCK_DEAD and the rest of Linux's use
of it.

I see now that SOCK_DEAD gets set (indirectly) by Homa when homa_close
calls sk_common_release. However, this only happens when the fd is
closed; hsk->shutdown gets set by homa_sock_shutdown, which can happen
before the fd is closed. This seems to argue for a separate state bit
for Homa's shutdown.

-John-

