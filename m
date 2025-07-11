Return-Path: <netdev+bounces-206261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2814B02597
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 22:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DE016D442
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 20:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741311EA7FF;
	Fri, 11 Jul 2025 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XjtI82QI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ACE537F8
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752264492; cv=none; b=qnoVqoV7ADlHOGfo/+7sAYfhNr6NowxKzRgg/nfXEvBiBhjINieNe/IiG0X8ajqv8w74STgBgFoS+WV5JHV04RZaGC+A7d6G3N00UZx1rJwzHRIBbpBSzZ7rLMm0tkIvTZDqiagvJZSaP7P6ksY/umj52P55toM3ECdJZ2GhAYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752264492; c=relaxed/simple;
	bh=s/f/z31jtKFrsm8Df9/DtKEOKiK/hSRygdBu/ovSdkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUTRSdRYKbEFFpYvzFwOP+77rl2bTkbczkI8AoQ2fgNe2oMZpnkcrVASGmA9+9MHXaJoKeNjuRmTlxhZWDfSa/uxffnTv7RQ9qnkIMF84xvUPo5YOz8Uuyu37DFT3yxMtIfMNnET1dZtoZVy7G6Vkx1Z211AXSyyYjva4N2brDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XjtI82QI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso4868502a12.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752264488; x=1752869288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3PEIy8sr1TZluoxMMwYFZHAXfdHvp21bOGwTcdKyt5g=;
        b=XjtI82QIGJIhLNDk3Ox7o9LvjVezmZy01p6rGsgyVfm6hHFwIuC4+E9JVrOMdAISk0
         bACdrbmDD0pSoxgBLwEr/1WzpmRLmmQxEQSTVf6jxXeyZi906lc3GZua5ZQcb746P1bF
         keuEa5OAU0pCJ8exqMJPdJW/Gl10FU4oX1U9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752264488; x=1752869288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PEIy8sr1TZluoxMMwYFZHAXfdHvp21bOGwTcdKyt5g=;
        b=WPDcAsz2/F7+dw/VQx3b1lo/Or92239t8D7NZw+8jRSrbJ5ZNx/Tf3Kx1vWgYu8oU8
         noKZaudrxPQYU0Cq/PXgMEzrWR5wr/HR8+sqXAR8m7P9VHKayJsD4/r1tXl4vLNgKTg+
         368VQ3xj/UdqHkaz1O1pTtnnZrbMDE1TixXfiuI2XVVw3EYvLastReqdHl3t4nNEicbR
         J+DzbDzb+Ka3ivdF4+DS964q5etjdYDLsETXSccFmUkJ6ihpeqpOiFKbwX5ZB5bCg1ww
         FFSPV0z+KDqKQzqr96pYexE7AOXIjgXFwimm+Ntjr73tjNSzwMfN52cwmWJ81yVSKZzr
         Ej0A==
X-Forwarded-Encrypted: i=1; AJvYcCUqECCdtFHc0ayMI66JIy/i8eUxl3QtHLJVfkf+5WvEVNlXzWdawOk/s0AJ1AIPb1u+WwNCbTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrD3KGW9G4EAvMlT3rFq+j3cP0UUcwf8d+7AiQ1qux7alYkwlY
	QDUo4chLneE+lkW6cz3r4H+pw6d1hBvZXvm0FjJLupufS8wTM1Y7JbN4/HnOTVpohzJCwY+tI4e
	CF/I21hqi2w==
X-Gm-Gg: ASbGncuvMjtZglLpCYvFwysjQWx8JYhUtkr4M8llppn9JhNffhGKc4022RBrCehVkcb
	VF/GfJSvmDzzOecksz20B5iZIXIdBFdwo/Fu0L75BzCQ8Xf9411xvSs3MkNnfW87xWCf4r4AbN0
	K4xB4flJgTpI45nQSKw2uRoUljPygvlliqNx1i0AjfTbCRXgPEdwNF/eio56VGyTFlHhk0yFFuE
	egIpP6tUFMoKr+/UyITtbECplN8ywBYR1dA5mE9SjTkW33f8iCRqNgciJpQS+L4oziwX3RECPNB
	ZQdctgCXp3ox2gRBOxZfuyj/QRef9SbaS42QKyqFxKE9JRmuBH1kWkupdjj2ANmhLEclKsgF8vN
	dpAkJCsuxCMWKW8OKc4kDPTTHGION++tXIM3yYhLJyJS07keG/shQ0lAUyA4qAcftWt3VPKYx
X-Google-Smtp-Source: AGHT+IGjsR71p4nPnIgOJAhTpxBsAdBD6yYgDhtMLivDHEt8oLDijkrtZcaaHOityd7v46Kk0C/znw==
X-Received: by 2002:aa7:c587:0:b0:610:3378:3d97 with SMTP id 4fb4d7f45d1cf-611e84e7bc8mr3801281a12.28.1752264488129;
        Fri, 11 Jul 2025 13:08:08 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9796dd0sm2581919a12.77.2025.07.11.13.08.06
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 13:08:07 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so3989954a12.3
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 13:08:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWiq2hme1duhlKNVCwe6j3xdn7dJI3bSyeMDRkp6J3YSex8cap9dVPGqjvpBdbDdXutKCZqZPE=@vger.kernel.org
X-Received: by 2002:a05:6402:518d:b0:60c:4521:aa54 with SMTP id
 4fb4d7f45d1cf-611e8490749mr4202220a12.17.1752264486410; Fri, 11 Jul 2025
 13:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org> <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
 <20250711114642.2664f28a@kernel.org> <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
 <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
 <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
 <CAHk-=whxjOfjufO8hS27NGnRhfkZfXWTXp1ki=xZz3VPWikMgQ@mail.gmail.com> <20250711125349.0ccc4ac0@kernel.org>
In-Reply-To: <20250711125349.0ccc4ac0@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 13:07:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjp9vnw46tJ_7r-+Q73EWABHsO0EBvBM2ww8ibK9XfSZg@mail.gmail.com>
X-Gm-Features: Ac12FXzjp4AGZ7WX6h51mZw8s-h9Pt8Rdamdc2UExJ4zq0chj2Qhdb4f4rcsT30
Message-ID: <CAHk-=wjp9vnw46tJ_7r-+Q73EWABHsO0EBvBM2ww8ibK9XfSZg@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 12:53, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Let me keep digging but other than the netlink stuff the rest doesn't
> stand out..

Oh well. I think I'll just have to go back to bisecting this thing.
I've tried to do that several times, and it has failed due to being
too flaky, but I think I've learnt the signs to look out for better
too.

For example, the first few times I was just looking for "not able to
log in", because I hadn't caught on to the fact that sometimes the
failures simply didn't hit something very important.

This clearly is timing-sensitive, and it's presumably hardware-dependent too.

And it could easily be that some bootup process gets stuck on
something entirely unrelated. Some random driver change - sound, pin
control, whatever - might then just end up having odd interactions.

I don't see any issues on my laptop. And considering how random the
behavior problems are, it could have been going on for a while without
me ever realizing it (plus I was running a distro kernel for at least
a few days without even noticing that I wasn't running my own build
any more).

I was hoping it was some known problem, because I'm not sure how
successful a bisect will be.

I guess I had nothing better to do this weekend anyway....

                  Linus

