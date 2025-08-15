Return-Path: <netdev+bounces-214074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9B2B28154
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 16:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0932B668BA
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 14:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D981E5B88;
	Fri, 15 Aug 2025 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UlLIlLen"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C91E0DEA
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267153; cv=none; b=ujSSxyEgtC8tczB3Jxbvw0yW3CskWkCSreBYewrqWrcGeXYRbBZoaG0tOgGLrE8n9alWnlsidKmRBQd17fSzfGy0XBnHeywq3yoWRKo0YNtrP3dWNW6/6UwUhbR3CGhcE7ZlUdr1+K3Pw9fR4IjarDdGOQskU8D64jqWJEJ5qHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267153; c=relaxed/simple;
	bh=Ys+oneiDmhfbSorAOTOMl93fEW5CDf2p/1hA9u/SrZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQc+vvB1H6iIDaTxJOQZwx2Ok8gaTV1NFSSsSPnTjd4JYugC0V+aYfG006gXixmJEkXJV/mGuuYswyFw+0NxX/KuoHyOrwyCA3KzJ99BBFMkToAKWkXO+P/wdT1ABM7I5BCLPznASUlVrVohyNDcqgO0mhswV8S4IlJVAwtrNMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UlLIlLen; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b472f0106feso332209a12.2
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 07:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755267151; x=1755871951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSNwVo+foGrqxtDIaBkJMFB12vMpB+ZeRSiJiXS17MA=;
        b=UlLIlLenJeK49QmdA0Iq9oe+qzxfqL6PXBrhrlFPwM0zqvjtBOvg09kxLaEo6bAusz
         T1YJSxGNgzPF4y5U3pzb6xqYcGx2n6NgMK6GEVH1b3qJsCl7R+9d9sSyJV7RTuQAb/jd
         moajXH6p2iuKAub89FjrNkJN8x7lT5Nxq2XuNBfS2TKdmNvTqUzlCW3TxQ1SBxBiGlAh
         E+oSI+WZyWPQ25bPfT9NTMm/JlRNAG9o7O+yUW1E6sQo5BG89Yg5+ith9KriAtTv4GKy
         xd0duu47M/aSFDf0wKbUKzpPp9pzFmOAUsp6I5Csm0kO0ShP0x6C8zEu/sPEkUG+DOVp
         E1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755267151; x=1755871951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSNwVo+foGrqxtDIaBkJMFB12vMpB+ZeRSiJiXS17MA=;
        b=mvUW5c1CcMfamtUGcYYzOfilzECEy/TnXq85oPRxDwM94Kwy5NXab7KvbF6xzMoFZx
         LI7dTdCRM8y8aKNeuuq6FicU/Y/8Wx87PQmEyrgb+Gkymfe0uJaxj/1yyK+TVwI4RErm
         aUXSm+OMJupSC6BKjrcLPT9IT/9KUYjV5Vc/0no3oHLy8k+p5BZrrpUCEaXeLdFk9yXV
         xvkSsRIpFxN8pCjlEDQG0fQMcaKuNiB2HKVgyFSMbISxEuiEm69vwtH5OuJb0WY+nKQJ
         Mb2pOG4PmJAY404gZMdM9mrHwgfN9UxEAdD9/ahtxo84tM5i5E+JV0/FZaw1cLG7ThUE
         uAOg==
X-Forwarded-Encrypted: i=1; AJvYcCUqqNGx8X0NulA0efwrl5SB7OOG3TGXu9jDUFFoNEksUTgPDUN4jtcMNKM+uTZFzz3QmHKkMNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6FHpTtSIpuP58nu/3XFSN9dTm4Yi2E0W30aYstS+cHUWUA31h
	uFWNDkEvR6t82ZCJ7fomlRQch525PzSzK04kkz31JSKwW1a7PuA3KuTyehmbIA4JhIC3YgERl03
	d2Wl8u+5InI2CboLgGA8Xfu1jOi2g3G8be4sqZp2F
X-Gm-Gg: ASbGncuAF052KTykWrCZJtWzDzmSGi1WT+21TkT12UCEuTWjFyttJqkFVH1CrFnzQiU
	iPgWE2+j79xH3WVVgYb8iXoJVdl41PgXEuUIgpI2/gP11s971D9I0llbuQFU71M1OHdH5/4agRF
	B724qhFq6PWpgy5njtfL6rAyuv5/MnJ8uCjvolnHhxHot6LBc4GijG5RnmUPMO5wQcqSiDtXsf8
	ZMNbQk=
X-Google-Smtp-Source: AGHT+IHZq87aTV2sDiSoIWzGjDI+X0kBjD2MtNl2nJmB9n8IEJQ2H+W6gTh1ML5Er6EysEcIv95tzQvcLKzQ6DmnBSs=
X-Received: by 2002:a17:902:fc8e:b0:23f:cd4d:a91a with SMTP id
 d9443c01a7336-2446d8b5f2fmr32266165ad.30.1755267151279; Fri, 15 Aug 2025
 07:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704054824.1580222-1-kuniyu@google.com> <20250808-parent-noise-53b1edaa@mheyne-amazon>
 <CAAVpQUAi6sQ+=S-5oYOPkuPEFk68g2zG81YOA3MYVnTSvTxcjg@mail.gmail.com>
 <CAHC9VhRbLSJhz=5Wuyi1RE8xxXPAGcEVXMUyTevawhAFPUvUoA@mail.gmail.com> <20250815-herons-fair-c5f3b931@mheyne-amazon>
In-Reply-To: <20250815-herons-fair-c5f3b931@mheyne-amazon>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 15 Aug 2025 10:12:21 -0400
X-Gm-Features: Ac12FXwr0fHM_Tc80tAdDEFOaLCy-u3hTEfEHXzorZt-p5EGqGwTtNfC-IWK3_E
Message-ID: <CAHC9VhRDyiNnULse4yfi7=K27VFxpVxfnGdY-E2Y+21F7YOfxQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] netlink: Fix wraparounds of sk->sk_rmem_alloc.
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jason Baron <jbaron@akamai.com>, 
	"Ahmed, Aaron" <aarnahmd@amazon.com>, "Kumar, Praveen" <pravkmr@amazon.de>, Eric Paris <eparis@redhat.com>, 
	"linux-audit@redhat.com" <linux-audit@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 6:00=E2=80=AFAM Heyne, Maximilian <mheyne@amazon.de=
> wrote:
> On Wed, Aug 13, 2025 at 03:00:29PM -0400, Paul Moore wrote:

...

> > Hopefully that resolves the problem, Maximilian?
>
> sorry for the late reply. Just tested the commit yesterday and I can
> confirm that this fixes our issues.

Great, thanks for confirming that.

> > Normally the audit subsystem is reasonably robust when faced with
> > significant audit loads.  An example I use for testing is to enable
> > logging for *every* syscall (from the command line, don't make this
> > persist via the config file!) and then shutdown the system; the system
> > will obviously slow quite a bit under the absurd load, but it should
> > shutdown gracefully without any lockups.
>
> Thank you for suggesting this. Will add something like this to our
> internal testing.

I wish I could say I regularly stress the audit subsystem in that way,
but I typically only do that when I make a related change or happen to
notice something in a related subsystem which might have an impact.
Additional testing is always welcome!

> Do you know whether there is already some stress test
> that covers the audit subsystem ...

Aside from the manual test that I already mentioned, which is my
preferred mechanism for stressing the logging/queuing mechanism, there
are two (?) contributed stress tests in the audit-testsuite, but I
don't run them and I doubt anyone does on a regular basis (look in the
tests_manual directory).

* https://github.com/linux-audit/audit-testsuite

> ... or would have any selftest found this issue?

Not having looked at the root cause, as that work was done before I
dug into this thread, I honestly can't say.

--=20
paul-moore.com

