Return-Path: <netdev+bounces-142025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC67B9BCFF7
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 16:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25312B23630
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FB545008;
	Tue,  5 Nov 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcE3Z80k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903E53D0D5
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818879; cv=none; b=noabm+sGoO9+SMe3bA2Dd3pd/OrXeC5x9SwYgxlhIt27VtOCBL9xLT2O6JDuZlhV7zQtDpTa7+n1qm3Zit/HEiZLaq/KSpRgwzeNyDbTe8A674RxbszKnt0McrEyrMldKYqxeboUvfp6N9opN3jNRW3+H5xYQBV78WGl7HZrhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818879; c=relaxed/simple;
	bh=1/jXZfoW/IqqPdO53+x/2GbvrUY5OPAPskD9+gAd6Nc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Wp0XnSOQ59rhvTV6V2dPl16p36kqoK9gkU9UQKHAIVsr6LQxU2JTG4Ggl297RDi3KUBPuBIpOhQOOPqkMW6NO03XQdibaeoyPdoIEP/ovqBeRSGlmT41PR/ZOzuhxGJOiyzt66rXYCfo7DzF53ldFjbdVlgd+k/MDKLLQYcLCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcE3Z80k; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b158542592so393616385a.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 07:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730818876; x=1731423676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKAH1qJCvx/dVD5woYo3bK0sUg6YLNb5xQ8/QZKL85w=;
        b=TcE3Z80kjSAT7uXWHiPF6xU1ewFzOFAOJrQR0F5MLByRGON3un+yLtt9RvtJcS6f/C
         pbEW2sCYrNEGrwfCCMjknbStFGcfFyq7xNVqCuI4TRFHqDOg2tmXxcWTNvttSgfeSYW6
         9uXSvCuVWkOi9ZS3i1xI8H2mdmKk1eT1ao2F9IZEdNwR+UDp/RL+1Nd5a29SpXaZzL6D
         h9Y5ZmCAJRXId5euR4rcGAJzM1WUZUKnIL00flsDNHHEUy9by374vjXjkIXJNlIlW/Fy
         E6hNTNDoaXUPEKOPgrsxTMLNsZQOTAu0+Oj6MD9mb6P3R3jLIW3Jp7Sm8MgvX2twUu9X
         SpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730818876; x=1731423676;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZKAH1qJCvx/dVD5woYo3bK0sUg6YLNb5xQ8/QZKL85w=;
        b=rQ7dcNns3sWRkGIKkJELg07ZuYX0W0JBTPmGorQvM76JwJIKqeWgj2Db+3c+6J/LYV
         tUSL+JiGJ3ehoZzcR9Cby4ryBijaALoeP9AH3SEo6xFrXoqfm8QeWvlYcrfp6rswx01n
         rIh7cjCuVbkAlj2q1f5x0CsMLdlffFjDa1mfvjykOZ3JFIKuThoqoc6i9y/IXceL8WSb
         4uFm++nGFIMYlTgKFknGOGVF87nmPomUePvwTmolpklpuCSXm31iM9Ba3MK+r/S3QfRc
         989NSrFnimb/Xp9bzM4BQgCM+goqTlEp27fvLaafkeIrIS9ufSgyiZe7XiQw1Y+MUDlv
         +XBA==
X-Gm-Message-State: AOJu0YwKFNIOjxbd7H9nwnOy9yKrAMNzuxZaRKt307R2l9Xv7Xq0f8Aq
	HtGhUpvVGNoN25GjUZjJWb2r8A+SDapX/2fOHM7rjXd8DhknYq0I
X-Google-Smtp-Source: AGHT+IHmRvCWZYo+2/NjMisrOhBbnkKEx93yUymBfmzipldZOkhO+P/i4iRsp+b8bVk2C+K6BKfrtg==
X-Received: by 2002:a05:620a:430d:b0:7b1:45ac:86bd with SMTP id af79cd13be357-7b2fb962bddmr2320889585a.18.1730818875933;
        Tue, 05 Nov 2024 07:01:15 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a112edsm524552885a.58.2024.11.05.07.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:01:15 -0800 (PST)
Date: Tue, 05 Nov 2024 10:01:14 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Nyiri <annaemesenyiri@gmail.com>, 
 Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, 
 fejes@inf.elte.hu, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com
Message-ID: <672a333ad7b68_7dd002940@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAKm6_Rv8yUvoY1XpEZVb6ve1s8XtodxTHYBCXqakQwnmhMGhQg@mail.gmail.com>
References: <20241102125136.5030-1-annaemesenyiri@gmail.com>
 <ZyekEJHEzJnyX6_j@shredder>
 <CAKm6_Rv8yUvoY1XpEZVb6ve1s8XtodxTHYBCXqakQwnmhMGhQg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] support SO_PRIORITY cmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anna Nyiri wrote:
> Ido Schimmel <idosch@idosch.org> ezt =C3=ADrta (id=C5=91pont: 2024. nov=
. 3., V, 17:25):
> >
> > On Sat, Nov 02, 2024 at 01:51:34PM +0100, Anna Emese Nyiri wrote:
> > > The changes introduce a new helper function,
> > > `sk_set_prio_allowed`, which centralizes the logic for validating
> > > priority settings. This series adds support for the `SO_PRIORITY`
> > > control message, allowing user-space applications to set socket
> > > priority via control messages (cmsg).
> > >
> > > Patch Overview:
> > > Patch 1/2: Introduces `sk_set_prio_allowed` helper function.
> > > Patch 2/2: Implements support for setting `SO_PRIORITY` via control=

> > > messages.
> > >
> > > v2:
> > > - Suggested by Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > >   introduce "sk_set_prio_allowed" helper to check priority setting
> > >   capability
> > > - drop new fields and change sockcm_cookie::priority from "char" to=

> > >   "u32" to match with sk_buff::priority
> > > - cork->tos value check before priority setting
> > >   moved from __ip_make_skb() to ip_setup_cork()
> > > - rebased on net-next
> > >
> > > v1:
> > > https://lore.kernel.org/all/20241029144142.31382-1-annaemesenyiri@g=
mail.com/
> > >
> > > Anna Emese Nyiri (2):
> > >   Introduce sk_set_prio_allowed helper function
> > >   support SO_PRIORITY cmsg
> > >
> > >  include/net/inet_sock.h |  2 +-
> > >  include/net/ip.h        |  3 ++-
> > >  include/net/sock.h      |  4 +++-
> > >  net/can/raw.c           |  2 +-
> > >  net/core/sock.c         | 19 ++++++++++++++++---
> > >  net/ipv4/ip_output.c    |  7 +++++--
> > >  net/ipv4/raw.c          |  2 +-
> > >  net/ipv6/ip6_output.c   |  3 ++-
> > >  net/ipv6/raw.c          |  2 +-
> > >  net/packet/af_packet.c  |  2 +-
> > >  10 files changed, 33 insertions(+), 13 deletions(-)
> >
> > Please consider adding a selftest for this feature. Willem already
> > extended tools/testing/selftests/net/cmsg_sender.c so that it could b=
e
> > used to set SO_PRIORITY via setsockopt. You can extend it to set
> > SO_PRIORITY via cmsg and then use it in a test like
> > tools/testing/selftests/net/cmsg_so_mark.sh is doing for SO_MARK.
> =

> Of course, I will send the test. However, I would first like to
> clarify which option I should assign in cmsg_sender for setting
> priority via cmsg. The -P option is already used for setting priority
> with setsockopt(), and -p is used to specify the protocol.

Thanks for adding test coverage.

If all the Ps are taken, use Q. It's a rare letter, and happens to be
the next. In the end, whatever is available.


