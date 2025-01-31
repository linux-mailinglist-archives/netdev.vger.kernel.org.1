Return-Path: <netdev+bounces-161875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE69A24563
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 23:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CFB166D06
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 22:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789C21F03DB;
	Fri, 31 Jan 2025 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="vXbIeR2E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034311C5D74
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738363912; cv=none; b=cPL8c1t7L9i32IfRx0jFtgm+IOd8q48C8flCRMjIjLmHYJ8Swbypbt7hJJxYvMckyZgYt3UwQA2rEdkSLQ4HT1eSYUfi5iA84IYYJjS3tzNv1rl448DhQEKEmzFqQIjjb6T3IucZ3Yq501M6F9tGi4IBosNBM0IBGHgEapVJmMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738363912; c=relaxed/simple;
	bh=wOiQQ/NR+ufy6rrzti2+Gsiiq8HU0MaSXqynkGkBOFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5tbocdae7dGaQJb/UpQd5DvvHI8NKxlZVO2aUn/wx+jzra1rWoZYyGJ/85tBbskiL0rZnZV2+E/ePccw7pbkuvHWlquf3eGqbG2xN26xsl0UkaUjD89pNKoE3/gKrS6CtrGhPlWrWgdP+aG7jb8l1KDMEqa0yk36xVZZRqFknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=vXbIeR2E; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2xTWxnzhSDCvLLqIZxAmwBah4dFcmfhs0lhP/PcIKDI=; t=1738363911; x=1739227911; 
	b=vXbIeR2EH5ugKzb0hCQBYqV60RsNpVbdQqObcgE875H3G6jKlJYfDTVktYP1f2Cj3h4gDrTgOfy
	53/Tu3giT8G0kxQ0LCEgGxkf4el6tcK9VxKizVUYiJPA4eymz2V0dljE7l4t+cH/Uomn9u1OpzfxI
	0PXnyDB3qq75ue6tjxjeC9doz9KlQXhY0pi+3UzqlL2FpX4MGjiET8QwacJDAOoJ43Igl+OBi31V2
	ULdPF3yVOo4K67v6KxkfBI09ijBW397H5d5QqXYK8dx3V6D99aBL1yTq5A3rN4/9HAGzuTGBM1f3M
	/rOREjlYE/WuRxeysQeL8oHJQvHOPmd5AjdQ==;
Received: from mail-oo1-f52.google.com ([209.85.161.52]:58421)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tdzrZ-0005l5-JG
	for netdev@vger.kernel.org; Fri, 31 Jan 2025 14:51:50 -0800
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f31b3db5ecso1051910eaf.0
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 14:51:49 -0800 (PST)
X-Gm-Message-State: AOJu0YzI3Gf2G+tXNEsWmyCdL9IMVmRRGPn2PU9ULTJTfrX8D9yASogL
	Ypgy5gAlUAq0UG6xvASS5Dw/6WXPEATx88+0B3iaLZxf5Uyzqw4q+51NG/6569M94Vrzi4Cbq5O
	lFcFh5JyCSdSE8/ZZM3jFv/X57KA=
X-Google-Smtp-Source: AGHT+IFDow4rEuAiHpA3IfyYq4s1Zsp/ovyrHyVa57P0jfaFw6cDKJoXFQe2/CODaVcCXrojVLIPLQ+ewHmZTKTP0RE=
X-Received: by 2002:a05:6871:2085:b0:296:bbc8:4a82 with SMTP id
 586e51a60fabf-2b32f28615amr8851564fac.27.1738363909031; Fri, 31 Jan 2025
 14:51:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-9-ouster@cs.stanford.edu>
 <9083adf9-4e3f-47d9-8a79-d8fb052f99b5@redhat.com> <CAGXJAmxWOmPi-khSUugzOOjMSgVpWnn7QZ28jORK4sL9=vrA9A@mail.gmail.com>
 <82cdba95-83cb-4902-bb2a-a2ab880797a8@redhat.com>
In-Reply-To: <82cdba95-83cb-4902-bb2a-a2ab880797a8@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 31 Jan 2025 14:51:13 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxDozdg3FPDNkFUcQU9FXENr-Oefnp61eWzXo5Sne4C1g@mail.gmail.com>
X-Gm-Features: AWEUYZlxqUrnfpg6jKSEZdYrayjRnySfdKUq5LB760-u7FWLk_1LRA0dwzEr4SY
Message-ID: <CAGXJAmxDozdg3FPDNkFUcQU9FXENr-Oefnp61eWzXo5Sne4C1g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Spam-Level: 
X-Scan-Signature: 8577cc8f8d13cb4ae2b02fc82e253015

Also resending this message to get rid of HTML in the original...

On Thu, Jan 30, 2025 at 1:57=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
> On 1/30/25 1:48 AM, John Ousterhout wrote:
> > On Mon, Jan 27, 2025 at 2:19=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >> On 1/15/25 7:59 PM, John Ousterhout wrote:
> >>> +     /* Each iteration through the following loop processes one pack=
et. */
> >>> +     for (; skb; skb =3D next) {
> >>> +             h =3D (struct homa_data_hdr *)skb->data;
> >>> +             next =3D skb->next;
> >>> +
> >>> +             /* Relinquish the RPC lock temporarily if it's needed
> >>> +              * elsewhere.
> >>> +              */
> >>> +             if (rpc) {
> >>> +                     int flags =3D atomic_read(&rpc->flags);
> >>> +
> >>> +                     if (flags & APP_NEEDS_LOCK) {
> >>> +                             homa_rpc_unlock(rpc);
> >>> +                             homa_spin(200);
> >>
> >> Why spinning on the current CPU here? This is completely unexpected, a=
nd
> >> usually tolerated only to deal with H/W imposed delay while programmin=
g
> >> some device registers.
> >
> > This is done to pass the RPC lock off to another thread (the
> > application); the spin is there to allow the other thread to acquire
> > the lock before this thread tries to acquire it again (almost
> > immediately). There's no performance impact from the spin because this
> > thread is going to turn around and try to acquire the RPC lock again
> > (at which point it will spin until the other thread releases the
> > lock). Thus it's either spin here or spin there. I've added a comment
> > to explain this.
>
> What if another process is spinning on the RPC lock without setting
> APP_NEEDS_LOCK? AFAICS incoming packets targeting the same RPC could
> land on different RX queues.

If that happens then it could grab the lock instead of the desired
application, which would defeat the performance optimization and delay
the application a bit. This would be no worse than if the
APP_NEEDS_LOCK mechanism were not present.

> If the spin is not functionally needed, just drop it. If it's needed, it
> would be better to find some functional replacement, possibly explicit
> notification via waitqueue or completion.

The goal is to have a very lightweight mechanism for an application to
preempt the RPC lock. I'd be happy to use an existing mechanism if
something appropriate exists, but waitqueues and completions sound
more heavyweight to me; aren't they both based on blocking rather than
spinning?

One of the reasons Homa has rolled its own mechanisms is that it's
trying to operate at a timescale that's different from the rest of the
kernel.

-John-

