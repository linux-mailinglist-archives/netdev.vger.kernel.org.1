Return-Path: <netdev+bounces-244587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64105CBB010
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 14:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1C7B30B0253
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092A02459FD;
	Sat, 13 Dec 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HeqkSJYv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1819D8AC
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765632644; cv=none; b=umMVfcErgDc958nD7zxf2u3ndX2eEAHUErc6FOvadPPkag3nS/7gwpOGQrOJhjg+tz4XUcobwbrHKDNmBxCm/0SL+6SYvBvaG9C0NRZr1Ta3YhlSyK/P+dpXIKwce+J1S5BQn2a+CFgPKsRKnOUZI8W8DQynTHrOC84g/LouGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765632644; c=relaxed/simple;
	bh=iNJmgjNt8hfzXUOvViJKQ5jTIIDxVoRT/N89pbF0Doo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6XntF8NkOgffuHhG+2WX/6DK4O8ZHbvH7PL8u6ifE0Ko+OC8XnRlKgIhdA+RIiHlyRXgAidjIY978rVP1011h5Rc4rQjg6Fd4ugyxfMknyGxy8uSIpzTNq4cfih/4Y4EgdFZJ4aTOU1A/8wIw9WddULOQ5WFBkHZNCsyzkPx9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HeqkSJYv; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ee19b1fe5dso20743251cf.0
        for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 05:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765632642; x=1766237442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNJmgjNt8hfzXUOvViJKQ5jTIIDxVoRT/N89pbF0Doo=;
        b=HeqkSJYvmcFkQrxeY0qxyvHsxOKM4a2L0f1FN2cIjA6RKyC4xhPF+2ncRNsu03Gx0U
         /BGIV5qKa8k+p04ZyV4HZRu+IlBYF63UvQXKcMcvbVJt8HgptmA/qewLI+R0yBWOIEr/
         6SwBwQLmye+CkJCrhZE+9GhhDAD/NPA+G+o2qPDgYRilcMyNFEy2zGPrpUBIYNzra1n2
         hQbPIrO3i4dadfqp9UCriqbyfDWrjIs92rP6MQHLtfkN8Fm7bMykZbSSCxM9/sxNqgrj
         zHJYvAKiiPl1T47wkYMCWFCtjtkdWlFFBOGSl17T+GDPGwaO1D+KBq3OnBmogylOFhvn
         HNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765632642; x=1766237442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iNJmgjNt8hfzXUOvViJKQ5jTIIDxVoRT/N89pbF0Doo=;
        b=si1L7d2NRn4zg0sNHU2wPsg6Rxon4n8f3iE7yW+kahZxr1NuWZOYl20kycDgZK7rTb
         qvCuHj+Dz5QAc08v1lIuytPo7xpBevftHYfsMm/Wo4l77MwmfxSXLqhlyHUki3WVAnyV
         s554Bq1K1hq2cvJ2k1jXhp3TFefGMpt1pdfl3GXPS1zLQT2OdOAoKkbpsZT6U0vgCsrs
         TlqqsTWngpfZjvWMBY+huZbwzZ/vYGOdYHXpqS8VqVVOSh7m0CRDngVf966T5MYMYa2r
         0fbksm/1zQkTg7PTqBItZPTMmK0VQmCZkvIcVxxCn/ETSPwg43CJJgCmDieUBLGLjB/s
         s/zw==
X-Forwarded-Encrypted: i=1; AJvYcCUEcW5o8hItNqT49ZcobyC31gkd3ypU/8+I/48LRnSFkncuRdjFEhFvnoE7hFgeWe92PdOTEpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkA9idL/AfXGx0YqtrfOtBe+UofAvWem6sbbXZS9hKabZVvUFm
	eaMaiFQbdPcqaEASxIS4Zu+ZFNg957hCmHuWcAiYzd8PmX5A6pbRxpNTEgIptjwbnZeV59Qb8sH
	MegTLxOKOceLnCizACnGf+57FQKvV+6ijkXfJuPfN
X-Gm-Gg: AY/fxX4VuT39q8BXroRP0ukJsn7mY7ncRhe7owdn59n7cYyJNj3IQRDfHgNSt7X5yUe
	OcZjzWLbVo0cQl5tZUrje3nvF8A8MaERFH4ELevyzSMKgiN8vI15l8bEJQb03tVFddogztNkDBg
	ZBVK0t1HIF5YFeSSvzdWbiwsbKClfD71E29OHdRN21zSPYCAkg8kGhtMKsYCdGbokxiKjRdRcX6
	cEAvgVBLcJYdLrd5nWpFilfFk/jD6ajHjjh3lOjT7lmOHseIMssoZiWP2rcmIB40eddYw==
X-Google-Smtp-Source: AGHT+IFb1jUp06E7fInH3b1048r2D9XwZIrQYi7V8bxYxuuaw4Uq7pyEwvZL+Rbvw0TCa6Ea6/a48v1EE6nsiVA1RyQ=
X-Received: by 2002:ac8:7e8e:0:b0:4ee:222b:660a with SMTP id
 d75a77b69052e-4f1d0620ddamr69405861cf.76.1765632641891; Sat, 13 Dec 2025
 05:30:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <693b0fa7.050a0220.4004e.040d.GAE@google.com> <20251213080716.27a25928@kernel.org>
 <aT1pyVp3pQRvCjLn@strlen.de>
In-Reply-To: <aT1pyVp3pQRvCjLn@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 13 Dec 2025 14:30:30 +0100
X-Gm-Features: AQt7F2ppD4jRUvpX56OKG-nqH9BtiC_Z3HxnK_1wRuqNUXKpW2IeQRSc5ldPoZg
Message-ID: <CANn89i+V0XfUMjo5azSAkcr6EKucQFs6fv6mpNeL3rN41SsTzg@mail.gmail.com>
Subject: Re: [syzbot] [netfilter?] WARNING in nf_conntrack_cleanup_net_list
To: Florian Westphal <fw@strlen.de>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	syzbot <syzbot+4393c47753b7808dac7d@syzkaller.appspotmail.com>, 
	coreteam@netfilter.org, davem@davemloft.net, horms@kernel.org, 
	kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	phil@nwl.cc, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 13, 2025 at 2:27=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Jakub Kicinski <kuba@kernel.org> wrote:
> > On Thu, 11 Dec 2025 10:38:31 -0800 syzbot wrote:
> > > ------------[ cut here ]------------
> > > conntrack cleanup blocked for 60s
> > > WARNING: net/netfilter/nf_conntrack_core.c:2512 at
> >
> > Yes, I was about to comment on the patch which added the warning..
> >
> > There is still a leak somewhere. Running ip_defrag.sh and then load /
> > unload ipvlan repros this (modprobe ipvlan is a quick check if the
> > cleanup thread is wedged, if it is modprobe will hang, if it isn't
> > run ip_defrag.sh, again etc).
> >
> > I looked around last night but couldn't find an skb stuck anywhere.
> > The nf_conntrack_net->count was =3D=3D 1
>
> Its caused skb skb fraglist skbs that still hold nf_conn references
> on the softnet data defer lists.
>
> setting net.core.skb_defer_max=3D0 makes the hang disappear for me.

What kind of packets ? TCP ones ?

