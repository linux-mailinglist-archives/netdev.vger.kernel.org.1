Return-Path: <netdev+bounces-201773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F26DAEAF39
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BAC18924FD
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 06:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5CF21517C;
	Fri, 27 Jun 2025 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2q1Eaky"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6F139D1B
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007169; cv=none; b=tZQdN1tMISFOTal97pU0hSV8IcVG+vP8w4Pld3CV6W4MIg3TVQy77xpN7wG8bSCeCdP40ChKa0Yr3U+09EdzPByAt3+rrVoFSnvl1v+3Shf4lFTINDMlEviQf6v4c60zqpkrMKk+CYgTBCb0M3LPQcy9aVuyuuZcUvZPAI1tnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007169; c=relaxed/simple;
	bh=al0hP3jK7BMgOXJbds9j4gsxtWUZxEhNq2cDmR5SwyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UE2aA58zDcRNBzMwcT+bGexQlgWCq/iiCTqa9XoVp31LHSSxgGz3aJAaA6js9nDh5M65dxPY9g41homLgrlDvD7JlEfTaUbjRHtWLUlx3hlmV5SyadFh58R+ciqa0T1bUN8y4x6J9rVGVCmVbH+9cEto8t+NHxghTt+D0YhP99c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2q1Eaky; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6face1d58dcso31591556d6.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 23:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751007166; x=1751611966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=al0hP3jK7BMgOXJbds9j4gsxtWUZxEhNq2cDmR5SwyY=;
        b=s2q1EakyH6Vv7xtxa2wv/qMA4dvJKABbIfc+h6/9VUxqCjjtjm3Sh705oPJdUv/dL4
         G/WOfswHPgMMjvO1UPDbv5ASni4aANQ8R+W8GP7Ip8rqRhh+obXY6oMBGJCiU6IxphY6
         HWIxcyR2LX9OQ7Xcaj1UNXlJ74y4um6K3icbR322mQrI+uUc3zOIYDmeTePEpd6EZD4n
         XgGJkKV5KhNGVGztuPa+ua8hLhFcNVvpRz3c4l6glp+6cTA1/qacv7lmiXhYXXw+1Nyw
         Dh6zVhkjpwrICee+1mG/B92nIbk3pfxbRi/CpKQ+qPROIL12D02luQGql2PO4RRyx9mV
         KTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751007166; x=1751611966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=al0hP3jK7BMgOXJbds9j4gsxtWUZxEhNq2cDmR5SwyY=;
        b=n/hTMOpUZrfLaN6plPb8T7Hws4bu2KyFmUVhS/x4nFMjBzclXUaXipV+L3eTdZ/MAB
         QdU1wcEt+n6tbpqIoh9iRBPy4AKN/1EFtk+G/xHw/34Mo8lpPz8FDGJnZwShkYRhbvu+
         Kjl07VWCN5Ue9MGJ1YBZa0vqRMrIXpzh96N2B82z7ZiGU8c9u8Vfys3vk/HOT+1kz9/B
         aRhcI8e58/NREu3jvS6okDqXHKGxtOggQtkIEpR8UNBqY2beElys5QxKajyNjKcgdPnt
         672JDNTlABSb27UZGvtw674Kzlzs/jAxWoF9ThTuwE6tuOxrWJYITbuKqF5PUmszFfIo
         LrAw==
X-Forwarded-Encrypted: i=1; AJvYcCUSI+yF5DDWU1Dd/wQwJubw0xiN8KXs5gmJEvle2IxRiasFLY+hairdgDhvNOIODZH1lgyGYA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZHuq/zVTlBUnauzYDrGZnA5xfhmANaPlmWab1laxnKlXwHRdL
	pPoEOgyuUUE14JrKF/npbEclgtqnQfHXvvUlosIL+9Y9yXx6h1olX8xc44KK9sihytWwCHbHsN0
	HdXAi/EG3UjWhoHQsGj839pziO9CD3uQ4c4fn7BbtWlVtBl/ewnkf9vKjrHk=
X-Gm-Gg: ASbGncvCAUIdyWHDSbeTlAax4QrMqKJJIyPc8ft+teW15lOZV8BfpbhCEad11Y2FZlw
	RON29yD4V1c2PGSG4vZE/F6N3ah4BwSLhoIP3wi9uDotkBsq0mcLQc77GEHr9t3R/lk958qUg6P
	dNlHhJVwUVUHd+8aJzCmu9N1/JizDgBTSD+lJnp7iAow==
X-Google-Smtp-Source: AGHT+IEPBqWT/GV01Fy00IJ77bWCUdtJK/GlNaGd/pKF+Z/UsurcBd54QfHuDJmPQ+IFuYw4TsscuIy8eVOU5/Hm7c0=
X-Received: by 2002:ac8:5f0d:0:b0:4a3:5ba8:4978 with SMTP id
 d75a77b69052e-4a7fca45d98mr40468011cf.21.1751006669534; Thu, 26 Jun 2025
 23:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625034021.3650359-1-dqfext@gmail.com> <20250625034021.3650359-2-dqfext@gmail.com>
 <aF1z52+rpNyIKk0O@debian> <CALW65jasGOz_EKHPhKPNQf3i0Sxr1DQyBWBeXm=bbKRdDusAKg@mail.gmail.com>
In-Reply-To: <CALW65jasGOz_EKHPhKPNQf3i0Sxr1DQyBWBeXm=bbKRdDusAKg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 23:44:18 -0700
X-Gm-Features: Ac12FXw8B5uCF1YYGK-NP__GnNnDRKGjEfGKypkayVaYnKX9pkP04LmQrIHb8dk
Message-ID: <CANn89i+GO3jSDs94SaqvC8FvO9uv4Jyn_Q0W752QcvRSPLnzcQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] ppp: convert rlock to rwlock to improve RX concurrency
To: Qingfang Deng <dqfext@gmail.com>
Cc: Guillaume Nault <gnault@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-ppp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 9:00=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> wr=
ote:
>
> On Fri, Jun 27, 2025 at 12:23=E2=80=AFAM Guillaume Nault <gnault@redhat.c=
om> wrote:
> > That doesn't look right. Several PPP Rx features are stateful
> > (multilink, compression, etc.) and the current implementations
> > currently don't take any precaution when updating the shared states.
> >
> > For example, see how bsd_decompress() (in bsd_comp.c) updates db->*
> > fields all over the place. This db variable comes from ppp->rc_state,
> > which is passed as parameter of the ppp->rcomp->decompress() call in
> > ppp_decompress_frame().
> >
> > I think a lot of work would be needed before we could allow
> > ppp_do_recv() to run concurrently on the same struct ppp.
>
> Right. I think we can grab a write lock where it updates struct ppp.

tldr: network maintainers do not want rwlock back.

If you really care about concurrency, do not use rwlock, because it is
more expensive than a spinlock and very problematic.

Instead use RCU for readers, and spinlock for the parts needing exclusion.

Adding rwlock in network fast path is almost always a very bad choice.

Take a look at commit 0daf07e527095e6 for gory details.

