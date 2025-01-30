Return-Path: <netdev+bounces-161578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19094A22751
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 01:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33287A28E7
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 00:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D746D9475;
	Thu, 30 Jan 2025 00:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="jhsGdf++"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8E339A8
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 00:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738198157; cv=none; b=O1TYbLhVdTEyh0VadlJMHFgKdx7eDkfV8UGdmHveuu0jVW/M7ZdHCGS/uK1HscuQLvCSw4T+2huj8Q74Ox1P/nMgCcpLcA3+Y1HoUrbpg35opFVegMmby7Huab5tfunlhtRaqH18spHDq/227iYCAUREWWJUJtyQyQZ87sNxCF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738198157; c=relaxed/simple;
	bh=OtDQDpLtO7LcXBzrdcjzZdoWLe3q1RbstvRWjZUdz/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKq32VAaeauR7OceNsnHL0sdRjtxzeVS/R3squQ/3Fba5axyYUwiXukyHToxNo6cOlesUozEkwr8LZqqVOFoayKI6OAEFm5CzAPkaoh7BXMLdzKzCltnl95drPFJaLXz2izwrIsz70vIhAxd/1pG8WjrVwqIMgvnT4RwRZevjtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=jhsGdf++; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7R0CcuiBmptZJ+KF6awTttj//YsAX2zVX6AKmk2vfpM=; t=1738198156; x=1739062156; 
	b=jhsGdf++bP42hh/aYI0mozR52IYh4mg349V+Ycj3DBvGfbQQ9SDLZ/xFVcfY7Esh+3QOG2FPmxC
	rn00hr/TBKKoskXKklBZJ4o2ADJKfYbf7XOHH1tcGerU4jXDUiKey3JyqeH8BZmyYugriTwAI7VhO
	VkQD1dXp/qIZRwHwnPuBLy0B0cnsOX5Sm77nPxPUwyOgf5UYNDV9HPyXscf1QVFUdv+/1xzWDu6sY
	BBvlwDFGG8+8VpucJZkN2R3owMvuSFi5K/VxavwoP6nwuMM8N3oAEeP9ZjcN2Vg4DxPymRRn6DerO
	680kSedGmqK6psY/N4G12u6AuRaytacrmvrg==;
Received: from mail-oa1-f54.google.com ([209.85.160.54]:57730)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tdIk5-0005fj-MX
	for netdev@vger.kernel.org; Wed, 29 Jan 2025 16:49:14 -0800
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2aa17010cbcso104655fac.3
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 16:49:13 -0800 (PST)
X-Gm-Message-State: AOJu0Yzi/mzfB3wVfKNPgr52XWlJ8c3/B6NWOJ+5jArb62yf24DanlCl
	sxdy4fY5ytFeBeXrhz9Va2IsdC6r26Gk1Ex7Wf9/XoKJTS1aMlGnvZMua4yIDd99a4rzznbfiPX
	29RVQge5i9c4xqlH7B9RrChKAfP0=
X-Google-Smtp-Source: AGHT+IEG54YEM06ONeAME6XlCO/WJxgSagnF15nTKn7FNe63iWhZE7f0x1h1tu+h7qEMEFBAiTg5lRIdzy+qjfhfHUM=
X-Received: by 2002:a05:6870:ce81:b0:29f:e018:df85 with SMTP id
 586e51a60fabf-2b32f08a73amr2748454fac.22.1738198153075; Wed, 29 Jan 2025
 16:49:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-9-ouster@cs.stanford.edu>
 <9083adf9-4e3f-47d9-8a79-d8fb052f99b5@redhat.com>
In-Reply-To: <9083adf9-4e3f-47d9-8a79-d8fb052f99b5@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 29 Jan 2025 16:48:37 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxWOmPi-khSUugzOOjMSgVpWnn7QZ28jORK4sL9=vrA9A@mail.gmail.com>
X-Gm-Features: AWEUYZmnR7yWKs1OPhpBUIWKZ8G8wwbhbhgxe3dd7k1JTnCvTQIvZvKNMBfhJDM
Message-ID: <CAGXJAmxWOmPi-khSUugzOOjMSgVpWnn7QZ28jORK4sL9=vrA9A@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 6b0537b5faa14548adc1759647fcb4de

On Mon, Jan 27, 2025 at 2:19=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/15/25 7:59 PM, John Ousterhout wrote:
> > +     /* Each iteration through the following loop processes one packet=
. */
> > +     for (; skb; skb =3D next) {
> > +             h =3D (struct homa_data_hdr *)skb->data;
> > +             next =3D skb->next;
> > +
> > +             /* Relinquish the RPC lock temporarily if it's needed
> > +              * elsewhere.
> > +              */
> > +             if (rpc) {
> > +                     int flags =3D atomic_read(&rpc->flags);
> > +
> > +                     if (flags & APP_NEEDS_LOCK) {
> > +                             homa_rpc_unlock(rpc);
> > +                             homa_spin(200);
>
> Why spinning on the current CPU here? This is completely unexpected, and
> usually tolerated only to deal with H/W imposed delay while programming
> some device registers.

This is done to pass the RPC lock off to another thread (the
application); the spin is there to allow the other thread to acquire
the lock before this thread tries to acquire it again (almost
immediately). There's no performance impact from the spin because this
thread is going to turn around and try to acquire the RPC lock again
(at which point it will spin until the other thread releases the
lock). Thus it's either spin here or spin there. I've added a comment
to explain this.

-John-

