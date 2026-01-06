Return-Path: <netdev+bounces-247448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A6FCFABAE
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 20:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F7B23066428
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 19:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8AF2F6574;
	Tue,  6 Jan 2026 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0vx2dGkH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BCA305976
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728035; cv=none; b=aa8Ba/zKFNINDBaIKMKL5AjJLptTNgQ5ZHD/vviM8u7sf++gI/9Zz6OnpN11oaDC4uctbIoTu9XH39em8jjxbkqSPliQ9POoyblJVgKI0vC172Fd2M0bISIaWqMBNcpYmQ1DJBpXLed8EetbpTKJQHTZsw6QYEv9s71hxVxl1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728035; c=relaxed/simple;
	bh=zFy84/1g+GkYk6JTjv88iOhP9E1EoK+HNWWb0YIbo7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rO+PZmMGNhUB+5gW4VDCXhdyN5MES+g+C8fy55ZrJOz7N58nmjNXOm+IqK044SFf1Us6PjU5aZGUvUTleBLqQI82hQnyhR7yJzn+E8zQEad3755QTwsQySQ9yf/AvggithBFsxEteD9GB+F+gLY4fvydt6R1DzGhh+KnvGP7aoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0vx2dGkH; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4f34c5f2f98so12764341cf.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767728033; x=1768332833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HMmuZyZVi+UPeUhQFy7MHrWlFGwYMuZWm4ckhx02k8=;
        b=0vx2dGkHcZPTTsF/5So79z0W15nmTx6lrVrEh7LOsh2qZncwcD8a8RFL+dt1sKHbmH
         aFxW+WwN1prgRGv5Mx8LQiK/nM/bZA69x9E45InTENHsddZ60xiPuE2MkpPXsqBX3ckF
         mLrVIbN3wKRaGrny4bDpCKkqPSgzuPqu2TngqoEz9/0YzQVyKjx0ZeIQPlyUwmjdXol7
         0p+GbjrhvM5IAHEYQq8k1vlGsfeM4VX8LcueIGJjqX1vhnNgs7+4WBR/puIHMCSm1kKa
         CWP2FYijulC6+yxKDU0FhTCi4Up6fVQbpc3wxJYvLhCiWgdPPHH2gdilxNTaWfZWZeIq
         g1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767728033; x=1768332833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2HMmuZyZVi+UPeUhQFy7MHrWlFGwYMuZWm4ckhx02k8=;
        b=Ksj/oNB6ecukune5OMO4zfRMXGGxhgyuU4Ldwrxqm2GO0H1hYEbaao+JsYti9/D1Xc
         cbelQk/1lO8eTBqipIWU0BMydQA1GlwKqtLIxSVJxagEQ3m4xTbYZ3UULlRGzmRN0TDW
         NKFsgpuICWvBHMsW8Yv+hjR+7NL0Lhln0t/+aKEJYX+i93kPC25YGX6WlLzrDeQt/21d
         1bEjnoS81Z5QhsLwXmQQRfpwQH7zvhvRPJQnchFxQOAf8hrCBxvr+pRGxyeCk+sKWM+d
         3KwPSuG/c/YSFqUDwr5zSYLjEV4XQSPZJ+CJUL+P4qHSCJA0pwNbHueFyMfxI2Fmq844
         6wAw==
X-Forwarded-Encrypted: i=1; AJvYcCWX/m6t7s5tXE//uHLYoALc6yUwJhLXoCHin6DwI0GSPvLMWFhhl/PmTsheHGqz1BApsuX25v8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx9INsisu+2XJb8PB9GwqLUTQ4G4XFW6CM9TgUa9tAwZ4gAAJ5
	wjf5+brvhbvx94D/W/D8tsg/FYmgoIxpEwmuR/hhFS5adl1ccq0jKU6aRGeub9ekxgR6rkoLdLw
	7b/ZAWU3Q+yAkiTbF4s/HiNyTDZLP4zsXsCYzb7ES
X-Gm-Gg: AY/fxX7oRsf0mJp8EsLCgPFfrJjwt7lh4I+c8oZZAVFmwiqa0qv9r3xoCswIIe/gVz+
	kCpDYtRAbEZ8F72G0HYCMf3AgYuxDyFXFolCE10jdJGvygro9J+zr63Wl380A8tD0j2lC7giSJ2
	tHe8OlVNwIiZzIj5Y04rAdatMiv9dER4T+r1miHZD9zxg8axya20k79+rjDWHxNyEPFXqcVvGKi
	oelUIMvUjU1nJWDENAwVpy/1z1iFrORwBl1eTp3yHAHSgVnNn6Gty5DfSuFSp9BXq1/tVCdKBve
	ZnBHAQ==
X-Google-Smtp-Source: AGHT+IE/75J8yUY17os0VShsT6U/hNCd6vMYWkVgKYcn4Tp1vf3A664V6K45IymHVMow9ghVLpC/8tVWpTn2vuk7b9Y=
X-Received: by 2002:a05:622a:5905:b0:4ee:4422:5a75 with SMTP id
 d75a77b69052e-4ffb4866306mr816061cf.14.1767728032967; Tue, 06 Jan 2026
 11:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106144529.1424886-1-edumazet@google.com> <20260106095648.07a870f1@kernel.org>
In-Reply-To: <20260106095648.07a870f1@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 6 Jan 2026 20:33:40 +0100
X-Gm-Features: AQt7F2pg0bPrexZEIAG_lALaf-1r-2pM5sL0kvVVL9Cb5oIrFy1h16Vr-2w5yLM
Message-ID: <CANn89iJnXg892OU13PeJMGvBKw90fJdqDaAmJ867Rptsm0zgNA@mail.gmail.com>
Subject: Re: [PATCH v2 net] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com, 
	Mazin Al Haddad <mazin@getstate.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 6:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  6 Jan 2026 14:45:29 +0000 Eric Dumazet wrote:
> > v2: invert the conditions (Jakub)
>
> Thanks! Much better now, but still failing
> tools/testing/selftests/net/gre_gso.sh
>
> TAP version 13
> 1..1
> # timeout set to 3600
> # selftests: net: gre_gso.sh
> # 2.16 [+2.16]     TEST: GREv6/v4 - copy file w/ TSO                     =
              [ OK ]
> # 3.16 [+1.01] 2026/01/06 10:32:57 socat[20546] W exiting on signal 15
> # 3.17 [+0.01] 2026/01/06 10:32:57 socat[20546] W exiting on signal 15
> # 3.17 [+0.00]     TEST: GREv6/v4 - copy file w/ GSO                     =
              [FAIL]
> # 3.18 [+0.01] 2026/01/06 10:32:57 socat[20533] W exiting on signal 15
> # 3.19 [+0.00]     TEST: GREv6/v6 - copy file w/ TSO                     =
              [ OK ]
> # 4.19 [+1.00] 2026/01/06 10:32:59 socat[20559] W exiting on signal 15
> # 4.19 [+0.01]     TEST: GREv6/v6 - copy file w/ GSO                     =
              [FAIL]
> # 4.20 [+0.01] 2026/01/06 10:32:59 socat[20549] W exiting on signal 15
> # 4.22 [+0.02] 2026/01/06 10:32:59 socat[20560] W exiting on signal 15
> # 4.23 [+0.01]
> # 4.23 [+0.00] Tests passed:   2
> # 4.23 [+0.00] Tests failed:   2
> not ok 1 selftests: net: gre_gso.sh # exit=3D1
>
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/461862/65-gre-=
gso-sh/stdout

For some reason I am unable to run this test from a virtme-ng instance.

I guess I wlll not make a new version of this patch, maybe Florian can
take over.

