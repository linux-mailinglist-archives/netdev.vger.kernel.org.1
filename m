Return-Path: <netdev+bounces-105193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C6091010B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DF7284C82
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF31A4F28;
	Thu, 20 Jun 2024 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZTPe1U2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136419B3E1
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877876; cv=none; b=RDdITYGu9p18y6e3OCao5UwUikqqs3URhXCQ1VvdBgQ2am2nLjYseRCcwDb1uP4Gj+MNM/F+Wj022gra50G7KskDMXYmuOM79OXT+kEIHqDk8kDzyAN3VY6mMlgTN9Cqk8d8W9gVcfDEyhKE326GeJUr3XDv6oz70GtK99YM0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877876; c=relaxed/simple;
	bh=qoo2Q0Zqih/O71OjIZHibGDXD6Cjin7X8WUFbvQIdks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9IN4aNrXvffWAtV1NRgjfFcdQBqZvN6irAH6K9MyJLCqudd65Ud+a+/E8QU0kWNi6hRT0GvtI8iLgYzf+zxuK/FxNc/fJsa9dPw0SasHyaIIENNu4FiHeYsi45ZSmUAjT7KR/78QwHJ6SBmFvbfl3Og/N0qvHLm7/+RQZ9of7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZTPe1U2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718877872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qoo2Q0Zqih/O71OjIZHibGDXD6Cjin7X8WUFbvQIdks=;
	b=IZTPe1U212APe129gcFhyI9vta0jpKahX0foqQ5RfCfQW4zL+KcIq6azsaMuGLd281JwOW
	XCPpzFY70dNvWKYAx1g3XY6JM4zaSJJuhaX/Beq8bykaXsFdTPn5Q0Qf9VuGZal+T2C31y
	3fHLSF2Ceo7NBgktEBgen3PyCb4i+5o=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-GysVeLZpOAKNldhnY_uIAg-1; Thu, 20 Jun 2024 06:03:12 -0400
X-MC-Unique: GysVeLZpOAKNldhnY_uIAg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7043008f4beso795009b3a.2
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 03:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718877791; x=1719482591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoo2Q0Zqih/O71OjIZHibGDXD6Cjin7X8WUFbvQIdks=;
        b=a2/w7TJpZED0At2gas7lMm+KppBttkvLZB87+6H+hlYO7sN45Dd+46SnLWzowBQHcr
         Otxd6hL1InZfsIx9HZ1brUEqiP4wdSE0VusSevFAK3SxCPtydJGvpmF+5TdOoZyYi3q9
         yOcLfVtqbGs5+G6XK1SyuxMmCOiDOUFJbbAGiddQXTvvTrm2JVyNKsKTJv6zxBbkXGzS
         w3fTmRpYcOEFUpuUnRoosa1MdVCleG2BCut5kQGfZ+QHRtTHXvcA13sVUg7jMsDzLHvG
         4v83nUd8bgWk0/5SFCs5PEw3LmGYTEWV1ue+n4cmCFPPpRcmAjMGK2LZeU1BLVarfNRP
         dz2g==
X-Gm-Message-State: AOJu0Yz/pluANg7pb2PtkzBVmbWC9f6FWsclXlx6ceBITFCPCGWyZYjt
	YXD87bUlHnqHb9jp/6Ib92tSmcJQKxJq5+ArTOCLJ3IV8lvFCFzivw/iwX0O+nc0THg1HzpdWlx
	RH0sq9SOJdcPIysUL28bU3NT3VKua7RGUsxPvTmCQilMRye2YMSxJDgVN9sXoXjx3Z0WVUaX0/W
	r/aweuRZJcv1WwglS3klZxqofZ1rAU
X-Received: by 2002:a05:6a20:a128:b0:1b8:c2b0:fda2 with SMTP id adf61e73a8af0-1bcbb5d35abmr6483079637.43.1718877790909;
        Thu, 20 Jun 2024 03:03:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRC/XV2Fx8DNpODYsdVD20HF/u2bDPNfi/2ArFUsKbmboVuPQ5TpjVvdf+CxrBHWox1y0ZaJh1X8phqUki8Zs=
X-Received: by 2002:a05:6a20:a128:b0:1b8:c2b0:fda2 with SMTP id
 adf61e73a8af0-1bcbb5d35abmr6483047637.43.1718877790530; Thu, 20 Jun 2024
 03:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607160753.1787105-1-omosnace@redhat.com> <171834962895.31068.8051988032320283876.git-patchwork-notify@kernel.org>
 <CAHC9VhSRUW5hQNmXUGt2zd8hQUFB0wuXh=yZqAzH7t+erzqRKQ@mail.gmail.com> <1902e638728.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <1902e638728.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 20 Jun 2024 12:02:59 +0200
Message-ID: <CAFqZXNsQQMxS=nVWmvUbepDL5NaXk679pNUTJqe8sKjB6yLyhg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	patchwork-bot+netdevbpf@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 4:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On June 14, 2024 11:08:41 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Jun 14, 2024 at 3:20=E2=80=AFAM <patchwork-bot+netdevbpf@kernel=
.org> wrote:
> >>
> >> Hello:
> >>
> >> This series was applied to netdev/net.git (main)
> >> by David S. Miller <davem@davemloft.net>:
> >
> > Welp, that was premature based on the testing requests in the other
> > thread, but what's done is done.
> >
> > Ondrej, please accelerate the testing if possible as this patchset now
> > in the netdev tree and it would be good to know if it need a fix or
> > reverting before the next merge window.
>
> Ondrej, can you confirm that you are currently working on testing this
> patchset as requested?

Not really... I tried some more to get cloud-init to work on FreeBSD,
but still no luck... Anyway, I still don't see why I should waste my
time on testing this scenario, since you didn't provide any credible
hypothesis on why/what should break there. Convince me that there is a
valid concern and I will be much more willing to put more effort into
it. You see something there that I don't, and I'd like to see and
understand it, too. Let's turn it from *your* concern to *our* concern
(or lack of it) and then the cooperation will work better.

BTW, I was also surprised that David merged the patches quietly like
this. I don't know if he didn't see your comments or if he knowingly
dismissed them...

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


