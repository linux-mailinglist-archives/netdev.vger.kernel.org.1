Return-Path: <netdev+bounces-137598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F7D9A71F7
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D46281BF4
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBB31FBF56;
	Mon, 21 Oct 2024 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K152SrHR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1D21FBCB5
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534027; cv=none; b=j5N+lyfYGUTYZE9cB/5ahtfmqDW9FqZ1ItDjGHa9TVZixRGbsw/TCc/XUPitowGCdcaDqAlz/TW8V3Ve1Sb/787GpHAxoe3PysByyrHUV3XKQ6vm2MeOlPhEF9uLi0rRSumdjuVXwfbXFNRd4w68QWqfF4PKUwzZOVMQ7+oO0nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534027; c=relaxed/simple;
	bh=M4kM5lUArydv5dJlC3xGAgRG9sLdyI57ghLl58KLUck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Se2msG/MgUA6HVjV4YAcvSfkGYjrAZlMGdlx7c8fnEJSuqKbzA27OLTXuxV9yap2MBG5lMuq5TB8MyrtcHH0JGoVZPFTcQbkk7/UDkK9BtCaqyYXJp02uAA0XK+x3gFsUdWv7dECsgdXnAo1TOSNiV19ou3zyzlhhsxEnsd8vGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K152SrHR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so535194366b.0
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729534023; x=1730138823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vxq8+fnWQoCNUD9nqgZ6L3cBMv3ogByZUUYEqazDFpU=;
        b=K152SrHRU9KWrstr3Okf/eKmyXJyvX9rLbGcqIMudzJO22urnwJvkbLUIdqCq9iGYH
         MNc8oUeC/MX6oHenzH3Ofjk9IG7eV/UByWOjfVi/lAP1s69c8X8W8To9+Ii+TMlpd7N+
         cgeTpYPWv1c7eBF+p9V+0l2X1jdoacKy9YQt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729534023; x=1730138823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vxq8+fnWQoCNUD9nqgZ6L3cBMv3ogByZUUYEqazDFpU=;
        b=Fgub0W8LSDEo6epSPrF+XATqFtfngLua8+dVNjc05tJymRkEBH6RPUEaqzqrvm2B6Q
         +cau4Z6RQi9H3+L7TSHD4eVEuTDogaQ+GaaOoQ21sAOR3j8hBVbJNkBkAnKUKDa33OAJ
         W+xsQNGrx4OG0NptvE3piv2+njPZot9b8AcbujpHIRT1wCdEYBXCmGUJS2xH0cVlH/J3
         FNdd3zIyEhZT5NCqz4HQrGJ3VBzaPwAjald+9IOCDkuejLOgH62jTDyfNY9dNiAFmScR
         uyCfJBibidHuU5ZRZkBM3XOg45bbu4PKPjEOlaYNY+Q3bDa36c2xUpfYLgJQNXHrYras
         quQA==
X-Forwarded-Encrypted: i=1; AJvYcCVWg8GMNC/Cl0wLtDGEiInj0udz08+fTVxo2EE1SRvzB/6ap1DeJx1iOWQYb/dgIOP32K6LhP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MQar89NURS0SYgWN9VCQha89u+4KSpIFstT8nGs+9iH/McB/
	VCgRPkcaoRSQdYIYs1T5Dflc/QNEgpzv04sYkN4iwapGeZ5sWVlputqKzLta40BaqELBTqtDwLq
	tlYI=
X-Google-Smtp-Source: AGHT+IE0wBwbVF2LnRBpjSlUS3BtCZ6dOcNgxxRnADU5VUsfOk4w83h2S30DUf58N8emB31iNJ8ZXA==
X-Received: by 2002:a17:907:3e1a:b0:a9a:1796:30d0 with SMTP id a640c23a62f3a-a9a69cd3009mr1064699566b.62.1729534023079;
        Mon, 21 Oct 2024 11:07:03 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91559951sm236005566b.106.2024.10.21.11.07.02
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 11:07:02 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9aa8895facso49514666b.2
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 11:07:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJ4aD8G9cyenIQ43HCnpliyqnUQmI4DtOqB3IogKAQy//CCgvNY2XlcZ8YWYca//CzffY51eI=@vger.kernel.org
X-Received: by 2002:a17:907:1b84:b0:a99:e4a2:1cda with SMTP id
 a640c23a62f3a-a9a69ccfc7amr827335866b.56.1729534022017; Mon, 21 Oct 2024
 11:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016204258.821965-1-luiz.dentz@gmail.com> <4e1977ca-6166-4891-965e-34a6f319035f@leemhuis.info>
 <CABBYNZL0_j4EDWzDS=kXc1Vy0D6ToU+oYnP_uBWTKoXbEagHhw@mail.gmail.com>
 <CAHk-=wh3rQ+w0NKw62PM37oe6yFVFxY1DrW-SDkvXqOBAGGmCA@mail.gmail.com> <9e03dba5-1aed-46b3-8aee-c5bde6d4eaec@leemhuis.info>
In-Reply-To: <9e03dba5-1aed-46b3-8aee-c5bde6d4eaec@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Oct 2024 11:06:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQhFPvneqAVXjUZDq=ahpATdgfg6LZ9n07MSSUGkQWuA@mail.gmail.com>
Message-ID: <CAHk-=wgQhFPvneqAVXjUZDq=ahpATdgfg6LZ9n07MSSUGkQWuA@mail.gmail.com>
Subject: Re: pull request: bluetooth 2024-10-16
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	Linux kernel regressions list <regressions@lists.linux.dev>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 01:22, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Just to clarify: I assume it's the "taking things directly and thus
> bypassing -net" that is the problem here?

Well, it's not a *problem* per se. It's just not something I want to
be a regular occurrence, because then the lines of responsibility get
less clear.

And we've seen (many times) how that causes a kind of "bystander
effect" where everybody kind of just expects somebody else to handle
it, and things start falling through the cracks.

IOW: having clear lines of "this goes here" just avoids a lot of waffling.

So that's actually one of the main things about being a maintainer:
sure, there's the whole "enough technical knowledge to be able to
handle it", but a *lot* of maintainership is literally just about
being responsible (and responsive) for some area, and people _knowing_
you're responsible for that area, so that there is less of the "who
should take care of this patch" confusion.

That said, in situations like this, where some small part missed a
regular subsystem pull request, I don't think it's problematic to just
go "let's bypass the subsystem, and get just this thing fixed asap".

Not when it happens rarely (like this time), and not when it happens
in a way where everybody is aware of it (like this time).

So I think in this case it was probably *better* to just pull a very
small and targeted fix for bluetooth issues, than have the networking
tree send me out-of-sequence pull request that had other things too in
addition to a high-priority bluetooth fix.

Put another way: having clear lines of maintainership is important,
but it's also important to not make things *too* black-and-white.

Exceptions are fine, as long as they clearly remain the unusual case
and people explain them.

(That is basically true of pretty much everything. A lot of the
development rules like "don't rebase" are things where the occasional
exception with an _explanation_ for why it happened is perfectly fine)

Developers are people. Black-and-white rules are for machines.

                Linus

