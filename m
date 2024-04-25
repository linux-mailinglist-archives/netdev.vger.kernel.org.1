Return-Path: <netdev+bounces-91430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C658B28AC
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 21:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AF728343E
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E572B1509A0;
	Thu, 25 Apr 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNIBpNYW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370014F9F5
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071774; cv=none; b=i57VeFKyOU2nifcXvfIdtiHIQVz/TBX235oAzz7+2t2jmX9M7eV2eKyC6NlkivspZKVRw01ThQ2eUJTL4NqCe8UK/zWRnjUscXhBGvzjleDKUIKoaz/fMiSBABwYQZAj9nxdmI/EpK2ccZ9aI7E+n2Jtkol7xslHY7LPVCUBZys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071774; c=relaxed/simple;
	bh=vLLV/XFGLr4MmOWD7H9DGNwcLTHZR3jR2GrBzbTl8Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxr3/8ESFk2wlCpAu3+rTUJo2pWh+8UKvqj7pE3HjVyGeczvP1F8zrOqK2KjmhNQ0XL0MXa1lM3TonnBQv4U3czDmx/r2e2BsWxtTbyz8jzgbv8VfHo1RcaGLrTU+azZqxjNIY/6Cfd51ReUHluOA63X9CEypSv6UcmlN33uXxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNIBpNYW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so2595a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714071771; x=1714676571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLLV/XFGLr4MmOWD7H9DGNwcLTHZR3jR2GrBzbTl8Cw=;
        b=WNIBpNYWeqp8AJ+ovhL+4ww0PsTmGmvyq5tk07ibuxrjbCrJCt8Bt/ixZ440gPd+PO
         /W/8WYKcJRoPYb7C5JrT0RVt3619Tp+46SJ98yO52WyH+RWHtg7N1dric+wNX+iw2Qv6
         P9WXIKFxDGMlXtnLJ2uGu952P8jgyWBViKQ6hLbDMgMf9BmS0Ql/mZZU/MaM81LkO+F9
         vC8pce535u2U0yNeMmF+Vum9GD/7me53ly36G31GaPRY5YaDOdN+fCIlEI9K6roSfaFk
         ILoAX9pO6fmV5yYPI1ibN2W2gEnw559gxJBM0noN37mLPyhv/jkmvJpLyFRU5n3aILlN
         QXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714071771; x=1714676571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLLV/XFGLr4MmOWD7H9DGNwcLTHZR3jR2GrBzbTl8Cw=;
        b=EuarPIpbNnz3eiLq41f9jj42rPZg8+P7OotO3xev1F+t+8TYkWbRYi1XfSLM2NU3CQ
         BaklpdiYouBOEyNTGVBhMURNXbXAXxB1V4IFCKCVqmcWh8hboZ7l0E0oo2haGObHEeJv
         DeDwAF6lWlC33ShHWKK4AlGS3Juj7XVurtualzjwJn0zsLmGwSxnV+l7+v4MASySvc4P
         S7BYgK7LtfkP5Pf947kZyASkfddTKtN6GtI9WXt7OOvkU31wkCK41nER/VoPhu/s8SL8
         5gxqj+hPRaPFMD2eZPLmVwP9cZMf1EmffgngL771Jx/tnVFgdzPxGPlhH0kjnWbNissK
         Jbzg==
X-Forwarded-Encrypted: i=1; AJvYcCU4IpKSghEJUJujSK81n6SbOCbEiyUIC5auWuZxXRczUnkKXP+4NNrWIweUG3FbZRnuz2OCng/Z4cpCvnT19r5VEsvP2/9T
X-Gm-Message-State: AOJu0Yzeqm7thDUrJRQZTprMbTqd0gvyROI6QfopYQOLD7ev6uy3TBas
	C6sYTai+Bwe4I8clfHe79pdBnPDF4lFmf5gjYnS/E+fbVAs/MiGwYVH7/4VwnF+6alsS3W9tVip
	rtbZ+TBg6xGcswkYzxUynNlN+H8LGe1TSXTZD
X-Google-Smtp-Source: AGHT+IGOFLJSxkx9DnkiDOSZBcF2LTRrdjUDqMI8hOufj+4ZN9Kovd5j/NaQmTwPNgHuY/DQ4ZssdcRvgnUPl9gnMbM=
X-Received: by 2002:a05:6402:17cb:b0:572:20fb:190f with SMTP id
 s11-20020a05640217cb00b0057220fb190fmr13676edy.3.1714071771429; Thu, 25 Apr
 2024 12:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423125620.3309458-1-edumazet@google.com> <20240425114604.1023bc28@kernel.org>
In-Reply-To: <20240425114604.1023bc28@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Apr 2024 21:02:38 +0200
Message-ID: <CANn89iLiwEZkYa7skWHAZ3O9c1FUOQWGvS-rfZOi5oMxSF-aHQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid premature drops in tcp_add_backlog()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 8:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 23 Apr 2024 12:56:20 +0000 Eric Dumazet wrote:
> > Subject: [PATCH net-next] tcp: avoid premature drops in tcp_add_backlog=
()
>
> This is intentionally for net-next?

Yes, this has been broken for a long time.

We can soak this a bit, then it will reach stable trees when this
reaches Linus tree ?

