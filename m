Return-Path: <netdev+bounces-206231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2483BB023BB
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 20:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A27A62D6A
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B11A2F430C;
	Fri, 11 Jul 2025 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Unc4eNq/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D702F3C22
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258813; cv=none; b=e7LBX5Ly2qr6qyAt3tMVmIFCWV6lgf1vS32gmJ1ohRFsz/DybqLPwglO+cbGptTU1rYJmUB31lJBbURtYy3DlXYmgxrPGvYfuGbAjinbh+X4DUs4m+DH6n6zcBlWP81CCYb/5fzVrY3IEeUPjYK2W6NGH2YMNv2TaqrfPmsCzio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258813; c=relaxed/simple;
	bh=bWCC4ZoPLffqwFBCGshYKFXjSxX0H1BlPT8PIH3CjDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GygF2wpto+CbQqy6NcXBzhlgrDKggdz/yBHkr46mNbP0sxX/36SXyR3eaGb83DMXHveSmnkJ+UmWRFfJIcxgK/ExlYiY/QxfoLq7JCKYaBhWyE9Tqh7YDPb6Fq4b4H8u0z3zX6eAjDf893gbUUagLNOrP99Zjfkiu6YK4aowOGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Unc4eNq/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so471420166b.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752258809; x=1752863609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fkiMZ2J4WWxAe30Yz9eXRKes27bISK6iOQFaa/jG/i8=;
        b=Unc4eNq/ltpEup6WB13kLDMZh+EEbnYwSNKiPtqjd4cAi/lKD59yzh+eCMBbTW4A0D
         hn0RBaiBadQ9bVyq/fvK8rAYhSEw+bZlhFC9aV+ZD1pgv1teJeElN8isRdLAWauXkoxm
         YFOISZynAlU1mLzXycae6AY4Ci+rN0qFcMxtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752258809; x=1752863609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkiMZ2J4WWxAe30Yz9eXRKes27bISK6iOQFaa/jG/i8=;
        b=Ihce4+zOLfDds262w3v0YyzwhPwjChZSv/AhOitte8FpMVII0DWqbtn7/H1DmwQrpF
         5KStRYXYCabq60rIesLkTLPwRiNNqjQ5+umaQp5OUV0SWo/8fXny1vSc9LYYBNqDId6z
         SVLWsuPfNebZ/oR5keepu28jB4A5jVbEjaoeZNg5+HRJa1e89lNoBd25iEm5zIBcLJDF
         xkBmJVUzxIw/9kFa2OukvZrgHYkPoEvxTFE8eHRzGdEXugle8O0W1z9bYBQ9Q9HXGzoL
         MIrYeo/NYRaJzQ1d3BbVG5QyaaFsOcVWsHYrs0x+xopyx5GwjYlIMYF4e4r5m5kzKHXl
         rHXA==
X-Forwarded-Encrypted: i=1; AJvYcCXzUyqvVwNw/Jshi2xnazU6lfIafD1ocVifzpjBxir2AagMduNREAkKN2sSHMAzeM/0zbMu1FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynnmhZ0R5SJoCu1N6JVIDS3h1YQ6PJVqKpRkNh5Y02UlYXlCXT
	EYbhTLTrcfV4hQGn3ZCtSgPpH5DVD+OLcg7FCkeF/KUJ/BFJ+pa3/jgExVIljtrSR6f9EY27TRu
	LpVvNO2++sg==
X-Gm-Gg: ASbGncsqG3Pg8mPYRMrZzkqTOYOtHQAGKSrZx68yMEdImIth3wykci1iBCHiGCGuv9v
	GQ3zeUjjOamfh+SPBAgfRWnOiNfB1TS2LhBrTCK0pAkJKBawYjVs85CUlj74IVTU8hjYrudD0P1
	Stnohv07ZFeT57sl8w0VEPJcw4hrQmGKWDfcOO+WwPZL4q8rd/NEoS0JlaA8wH8X4YK3FxC8/bV
	BhUZcawErnuqrkwFEWLI0W/yAsY56K+cjATwE1avAMbOjUohN310eagyD2XJF1D1YrOUl5nOHf5
	cGsZt9XpP1Fmme1sQDPaMdCFFvtc9qfkaODxkezTklxOr5LuzodKa5Yl7p+UjM8DSRzY8q5EkjT
	cWyugqO3ep1NwAPqqY2LvQNYz6aB13S4dY2RG36YNLz3sg1Jkp3UduB5jb6RHOluejxuOxYqMBl
	Nud/IJyPo=
X-Google-Smtp-Source: AGHT+IHcmp2G4WYXss2fUMFT1lrCHmCgHsK6TC/3mTkYHYNvyqauwLW3yELI4eUiTY6dJQiUb1NRGA==
X-Received: by 2002:a17:906:f599:b0:ae1:c79f:2b2e with SMTP id a640c23a62f3a-ae6fbf968ccmr498006066b.40.1752258808940;
        Fri, 11 Jul 2025 11:33:28 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df54csm329901566b.155.2025.07.11.11.33.27
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 11:33:28 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so471414266b.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:33:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUklN1Qn6uwIVTolS2dLXH9Tf//6PRzE0pVMurOSSBl7x8VXyvlp9PEwKMcLr1AHmccX5a1JEo=@vger.kernel.org
X-Received: by 2002:a17:907:3e95:b0:ae0:c6fa:ef45 with SMTP id
 a640c23a62f3a-ae6fbf96592mr483791366b.41.1752258807150; Fri, 11 Jul 2025
 11:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org>
In-Reply-To: <20250711151002.3228710-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 11:33:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
X-Gm-Features: Ac12FXykIL-Mz_Bqw9_dzJEakCBd9Y2pyk80DOugpUKw15R_JJAEpkwfYZHB3M4
Message-ID: <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

[ Added in some drm people too, just to give a heads-up that it isn't
all their fault ]

On Fri, 11 Jul 2025 at 08:10, Jakub Kicinski <kuba@kernel.org> wrote:
>
>  The Netlink fixes (on top of the tree) restore
> operation of iw (WiFi CLI) which uses sillily small recv buffer,
> and is the reason for this "emergency PR".

So this was "useful" in the sense that it seems to have taken my
"random long delays at initial graphical login" and made them
"reliable hangs at early boot time" instead.

I originally blamed the drm tree, because there were some other issues
in there with reference counting - and because the hang happened at
that "start graphical environment", but now it really looks like two
independent issues, where the netlink issues cause the delay, and the
drm object refcounting issues were entirely separate and coincidental.

I suspect that there is bootup code that needs more than that "just
one skb", and that all the recent issues with netlink sk_rmem_alloc
are broken and need reverting.

Because this "emergency PR" does seem to have turned my "annoying
problem with timeouts at initial login" into "now it doesn't boot at
all".

Which is good in that the random timeouts and delays were looking like
a nightmare to bisect, and now it looks like at least the cause of
them is more clear.

But it's certainly not good in the sense of "we're at almost rc6, we
shouldn't be having these kinds of issues".

The machine I see this on doesn't actually use WiFi at all, but there
*is* a WiFi chip in it, I just turn off that interface in favor of the
wired ports.

But obviously there might also be various other netlink users that are
unhappy with the accounting changes, so the WiFi angle may be a red
herring.

            Linus

