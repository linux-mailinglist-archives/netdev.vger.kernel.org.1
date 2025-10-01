Return-Path: <netdev+bounces-227509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DCEBB19EA
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 21:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1FF4C45F5
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66538283FDD;
	Wed,  1 Oct 2025 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7UGNvZl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815F3266B52
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347277; cv=none; b=eU3ygHMvVdC1ZepmyvuyEDq94W/mFDIuk9Qe9qb2EbhvpZEUg5kwAKDfAaUAbOb+CFxbu0DJY5EDmLgOMb7D8jBEi0dVuh4aSa7cWF483yjQEHy2jCEX7/0IreswAvwO0uObJm0VhHeqcH9sKWQb2VS1o8ZbfQf/FjnsWillvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347277; c=relaxed/simple;
	bh=+wEp8FY6k12SfpSslWhDOvNvg6MIJv1cyH/QabovNSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiASayNq0/PH27UGumQKLRYYB8ck1xbzfrJuQ6s2mAeXr+fn3be+Q9NHuamwawOYCx8X7edGLZvegsYAjpMFfGjTBWXYIocISDSdOjtKcm6EQD8IyNyLn2EUvlnrOfcN4OMNpstqzOQRXT/b0ktmbcubkK3/d0aGrDbm+ID3zyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j7UGNvZl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57a960fe78fso212936e87.2
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759347273; x=1759952073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYGG+lQD3/n82ZybzPGOHt5VupK6X05JQl8tmLzMiy8=;
        b=j7UGNvZlvFv0zCpSyswVkWRelJDR5oebGmWpy6ogZT1khZGBf2f6dVQJj18pIYc9mh
         7yp3Iey3ks6iKpDWkMWCd8EjhebYtLiuZDYwiSiB3kwvLjcb2mdriWjPVAuo5FpyZnjK
         ZgQYvaADetPT/3ar/FhKu+6HuKOM06VKOD2bfijzXgqp6VMjO6G8zqKBdpWme+lyYAaM
         rN8owzoKfwafQYpiFkRwC7lGzEOshxmrzzuM3khlfuIatTzBrluJBU2Oe7idsktYlP5I
         Pe+8DZr+Bace6qGWlzO0T0ltudo3xiPu4WEu58MOOdQTSSbzVu3j0LZxRTuBV34OI+rV
         qETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759347273; x=1759952073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYGG+lQD3/n82ZybzPGOHt5VupK6X05JQl8tmLzMiy8=;
        b=TkcG+zz6oTvPoq1nRCF0ReVmFdBCWH/NzY8UdXn3cuCpzpKYw1Juprbiumfb/G0Oov
         myFttuQplZZjTlyyDQX0ejJ1ZZ0TG0p8LEbona50DK015QRgGkaNmkHjjej80bhpWZNq
         /cecPd2e6ShKDZitA3vSjaIt174/tVsyULJEMBDDx/Cb6+aCxRGjQLkCvJbfAZzHc9Ct
         vH3VmHONWFFfxMbFrkJtR0qVJx0rqJJ8RHbCAx8sLHCLXnfs2VlAlV35De5sPyAAiH1f
         3U5usymx2jZxv+ORl3d3v25fLuWn3pRO/lTDox24GlS2krwRfABIXvurgk68hEU/qSCK
         vDcw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5JtdNj57lS9r1sKdsBH1yoa7DA8rzPFckqjgU/eieSLXzEZdINsMcr2mWs8jgTD59PGaXVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoVGKX/MYOXFKnzKWa1lHeClQSYQ1WR65fVB8uWpLp0UTg7BId
	tM4Ly3Msz9i1cGEpseOQYpH68LvFeCIXbyzv/U73SZhgYNRqOPACrpI7+NCINuZzEkqnGp0ka1G
	if6LlANae/UQ5bd/qoneyK+NfMy2E9E37JkqM4Nvz
X-Gm-Gg: ASbGnct2yBwTlAJAmcrQlO7N8v8ZI3/aTZk8Opjrk2P5OzmmK9RtbsEeUms0GR6//xL
	chSl1wfaPWl4lm5sHOvL0PeONI/MjVUQpJiQepkNs50/dH5MYdrndVkoKTucB3aWyJCadEosA37
	/9x760KUpmmW+/B1mBDW/q/KZnUT2yvtsXU7HpnVh1DYi5C8OUEGFR5CwIlgxHrJZNSiYwfLbje
	mrVdO7FUs19t7RR8et9hsRdb1mowb1ZyaowICsWz1ZF3owMmLr0S4bS02CAeNEl5w2tx5jiT46O
	9EpSh7FOkjXuMyLN823s3Bqv4czcqwD2puAjVb4=
X-Google-Smtp-Source: AGHT+IHnRQ/s9GcZH3c204Eq/Il7SAaUBkw5oQvc/Wn1TIw4EjxfGtQQeUYVyUlWabWoTVOH6yWkf29rnk01/N7RnHs=
X-Received: by 2002:ac2:498c:0:b0:58b:13d:7cf3 with SMTP id
 2adb3069b0e04-58b013d7f38mr103390e87.33.1759347273325; Wed, 01 Oct 2025
 12:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001102223.1b8e9702@kernel.org> <20251001185310.33321-1-kuniyu@google.com>
 <20251001122618.4cf31f3b@kernel.org>
In-Reply-To: <20251001122618.4cf31f3b@kernel.org>
From: Willem de Bruijn <willemb@google.com>
Date: Wed, 1 Oct 2025 15:33:56 -0400
X-Gm-Features: AS18NWCHCX9z_oDRuAmV-J_ufTDSlBj18YHd0wjT7wBjnJP25mJiwaEwNG7PNEk
Message-ID: <CA+FuTSfnOzbZrztVYX26M6xAd5Y-hP0=Ek7svJpDUSLKApK0aQ@mail.gmail.com>
Subject: Re: deadlocks on pernet_ops_rwsem
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, edumazet@google.com, fw@strlen.de, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 3:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  1 Oct 2025 18:50:22 +0000 Kuniyuki Iwashima wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > Date: Wed, 1 Oct 2025 10:22:23 -0700
> > > To be clear -- AFAICT lockdep misses this.
> > >
> > > The splat is from the "stuck task" checker.
> > >
> > > 2 min wait to load a module during test init would definitely be a si=
gn
> > > of something going sideways.. but I think it's worse than that, these
> > > time out completely and we kill the VM. I think the modprobe is truly
> > > stuck here.
> > >
> > > In one of the splats lockdep was able to say:
> > >
> > > [ 4302.448228][   T44] INFO: task modprobe:31634 <writer> blocked on =
an rw-semaphore likely owned by task kworker/u16:0:12 <reader>
> > >
> > > but most are more useless:
> > >
> > > [ 4671.090728][   T44] INFO: task modprobe:2342 is blocked on an rw-s=
emaphore, but the owner is not found.
> > >
> > > (?!?)
> >
> > Even when it caught the possible owner, lockdep seems confused :/
> >
> >
> > [ 4302.448228][   T44] INFO: task modprobe:31634 <writer> blocked on an=
 rw-semaphore likely owned by task kworker/u16:0:12 <reader>
> >
> > modprobe:31634 seems to be blocked by kworker/u16:0:12,
> >
> >
> > [ 4302.449035][   T44] task:kworker/u16:0   state:R  running task     s=
tack:26368 pid:12    tgid:12    ppid:2      task_flags:0x4208060 flags:0x00=
004000
> > [ 4302.449872][   T44] Workqueue: netns cleanup_net
> > ...
> > [ 4302.460889][   T44] Showing all locks held in the system:
> > [ 4302.461368][   T44] 4 locks held by kworker/u16:0/12:
> >
> > but no lock shows up here for kworker/u16:0/12,
> >
> >
> > [ 4302.461597][   T44] 2 locks held by kworker/u18:0/36:
> > [ 4302.461926][   T44]  #0: ffff8880010d9d48 ((wq_completion)events_unb=
ound){+.+.}-{0:0}, at: process_one_work+0x7e5/0x1650
> > [ 4302.462429][   T44]  #1: ffffc9000028fd40 ((work_completion)(&sub_in=
fo->work)){+.+.}-{0:0}, at: process_one_work+0xded/0x1650
> > [ 4302.463011][   T44] 1 lock held by khungtaskd/44:
> > [ 4302.463261][   T44]  #0: ffffffffb7b83f80 (rcu_read_lock){....}-{1:3=
}, at: debug_show_all_locks+0x36/0x260
> > [ 4302.463717][   T44] 1 lock held by modprobe/31634:
> > [ 4302.463982][   T44]  #0: ffffffffb8270430 (pernet_ops_rwsem){++++}-{=
4:4}, at: register_pernet_subsys+0x1a/0x40
> >
> > and modprobe/31634 is holding pernet_ops_rwsem ???
> >
> >
> > Was there any update on packages (especially qemu?) used by
> > CI around 2025-09-18 ?
>
> No updates according to the logs. First hit was on Thursday so I thought
> maybe it came from Linus. But looking at the branches we fast forwarded
> 2025-09-18--21-00 and there were 2 hits earlier that day (2025-09-18--03-=
00,
> 2025-09-18--15-00)

Is there a good SHA1 around the time of the earliest report?

There do not seem to be any recent changes to rwsem, let alone
specifically to pernet_ops_rwsem.

