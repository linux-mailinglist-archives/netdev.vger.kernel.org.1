Return-Path: <netdev+bounces-210853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ADEB151E3
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 19:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CC718A2D04
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAF22980B8;
	Tue, 29 Jul 2025 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx3SUq3q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E5227C162
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753809137; cv=none; b=IEzWOeacrmOiiR26qDlUvDjgIJDO6yYn8oQzoJz6KOqrCW/47udzFHTk2BAdW/ZRizn19powbTyshvV7Bmqy4fCqLWGCfrQxFrlmNwbqi0PvQ4UCozk30EC8Xb9kvhi10u2AadlGqT1AZgnfv+u7r5P2hKCPYad2SLFENP7sY3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753809137; c=relaxed/simple;
	bh=mWS459ReIrgH0EIF7yTQIPUXCpxWBAbo9zr5F8GGlAE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VVedrsZZd8CUsy7aZ7loOxPMdn51dEM2gV3Hh7B51v9ePOJC2EKNvPAk2MzguJz+kt0xh3Ppg9uYI7how8ObnISaX15B7qGalDx1/x+DSJdKvflpdC+0Hdafge6gcIt5edDC4c8Zluv2T8a5+sHd3yJNsjlzQmmrqYS2C6Y6Ssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dx3SUq3q; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71a04654b82so24984697b3.2
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753809135; x=1754413935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9owSosFVIaYlWDG0Tb6r8vhaUJXcRiw9cNwSqnzF8E=;
        b=Dx3SUq3qE8uKFyBP+COP4oq6K8X+7ORD+t0A8yfw8pfzvDSBfsQ8TALsePj4ag+vAm
         G+VDzCdA17o7M0JQCEeOer0mDwyDT3z2ftpRYWtZ1xzpay3fiKl9xwFcKRh2t9wrtZWM
         3IBeu14zdTQprpeQBwDWPcyVRqcIvwWHnis4/PxBGujahi0pZOyCvtVBb6iJOXIuJcg1
         8V30ZyvDdrC3R/9XhA9bUXfRyd+woxhlTBvwM5kaTcM5//3MwGtuL80plJ1MQ/24ZtR6
         6x6FK7RJjxt2BsZgOKZKAmR+MYs/lBbLSuOGuYlcvBs4QWsJiEEvi+emI/qHvmsNRdH5
         0pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753809135; x=1754413935;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O9owSosFVIaYlWDG0Tb6r8vhaUJXcRiw9cNwSqnzF8E=;
        b=bwzLLDRfBrYEB75kqvGXNQMciuzo8nrkGc0+QMF6lLOEyiYkBqs6RZVXajFvRaMurC
         URwd1dCxLa46oPc7R4eQiIQMmv4PPQqZj90yUCTNvZiBLIRojPPgoGr+41LcWfYSy1Q8
         Cgm0cWwkxJMMkVSFG9lae/yygkAotoJXgyRS2b4Z9XG38979AX5KnPGy13++8Ptat0CK
         oIZUDapuAUx4WJHrfiWz7mYaU6KVrtnHcEDyiqVcNs2oVpBDEv6i+cGMTogmyyxwWzPy
         S4tayLZAnlmMt/ITl0GfEvL8LEt1l5yJqfCNboMy4snbcgeUT7P44kVwui9QbcQefpIv
         SiAA==
X-Forwarded-Encrypted: i=1; AJvYcCV2I7Oj6ubeidJeIWFYCaB2aDqmLUWtUXtwY23rdKT2pK4xRk3f3F+RuNIqNgT/k1/GWlu33FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj5JZjsnIEcQdgeeNajZ/Cd7zuYuUl1G4AUUImk1ntEG+2tJwO
	e5iIlB60BfeYtibKCXcWUIczMw1hTOyZ923IjWDdFIlA/iHOEvNaMXjN
X-Gm-Gg: ASbGnctkFJ2sYUQz0YtFKW8bp+6gVWHTVUkDhAXYm/3SXju4ZTRv5iditGpx6OhN6th
	+Y7mYqsVTxuChzZFN5aZJaFim7NJa0s0JaVdpKWccIFbo3Q6DW3XE5gWL6Vs38zWu7RRKthdnXe
	1rfJWAWsHxuFDcOb7kAiMN9HQD7hLUwFXYF6lQv7fBvj+6oDLfn865gkAjXmf60/ntQujfty5it
	HEldcKFDvaEiAp5xoEiynWNeIWDMHBBB0Bvt5kuREW2LiHZyCimCR1kMCkCfb4qmzRnrHo1Whtn
	dt58DmhvLC4R3se96Z1q8zuYaKy2HBAZB8qIuPLOeO8BOt1C9mQE6tG8h/oRoLi54Z38JjRtRci
	fmIOvfLmVGwf0gCFUea+kD6ceOnx8A2QVr8XWtP94iR44dIJ12oFIirfqy34/C+CTkr6NSg==
X-Google-Smtp-Source: AGHT+IHVyDcuWdgaTfJJUAKmGbLpwI83jpq66xORbtNmPU70I1SbI1QEHVpvs01pXgCu9eL1aZEOEA==
X-Received: by 2002:a05:690c:46c4:b0:719:4c96:f13a with SMTP id 00721157ae682-71a46576fa5mr9390467b3.17.1753809135312;
        Tue, 29 Jul 2025 10:12:15 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71a4296f899sm2118417b3.75.2025.07.29.10.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 10:12:14 -0700 (PDT)
Date: Tue, 29 Jul 2025 13:12:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org, 
 quic_kapandey@quicinc.com, 
 quic_subashab@quicinc.com
Message-ID: <688900eddd162_16a694294ae@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89iKA9O1jsTjm+vOQqN7ufBJFod7oySUC=2G7wcV2cGTkSw@mail.gmail.com>
References: <20250729114251.GA2193@hu-sharathv-hyd.qualcomm.com>
 <6888d4d07c92c_15cf79294cb@willemb.c.googlers.com.notmuch>
 <b6beefcf-7525-4c70-9883-4ab8c8ba38ed@quicinc.com>
 <6888f2c11bd24_16648b29465@willemb.c.googlers.com.notmuch>
 <CANn89iLXLZGvuDhmTJV19A4jBpYGaAYp3hh3kjDUaDDZJqDLKw@mail.gmail.com>
 <6888f5eb491ac_1676002946c@willemb.c.googlers.com.notmuch>
 <CANn89iKA9O1jsTjm+vOQqN7ufBJFod7oySUC=2G7wcV2cGTkSw@mail.gmail.com>
Subject: Re: [PATCH v2] net: Add locking to protect skb->dev access in
 ip_output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Tue, Jul 29, 2025 at 9:25=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Eric Dumazet wrote:
> > > On Tue, Jul 29, 2025 at 9:11=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Sharath Chandra Vurukala wrote:
> > > >
> > > > > >> +  rcu_read_lock();
> > > >
> > > > How do we know that all paths taken from here are safe to be run
> > > > inside an rcu readside critical section btw?
> > >
> > > This is totally safe ;)
> >
> > I trust that it is. It's just not immediately obvious to me why.
> >
> > __dev_queue_xmit_nit calls rcu_read_lock_bh, so the safety of anythin=
g
> > downstream is clear.
> >
> > But do all protocol stacks do this?
> >
> > I see that TCP does, through __ip_queue_xmit. So that means all
> > code downstream of that, including all the modular netfilter code
> > already has to be safe indeed. That should suffice.
> >
> > I started by looking at the UDP path and see no equivalent
> > rcu_read_lock call in that path however.
> =

> ip_output() can already be called from sections rcu_read_lock() protect=
ed,
> or from BH context.
> =

> The caller's context does not matter. I am unsure what you were
> looking at in the UDP stack ?

I was just looking indeed for a caller that held rcu_read_lock already.

I saw the __ip_queue_xmit caller only after I asked the question. But
indeed calling from bottom half is another obvious answer.

Might be informative to add a comment to the commit message to that
effect.


