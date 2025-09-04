Return-Path: <netdev+bounces-219983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9272B44033
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 17:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DE4165829
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D9531AF1F;
	Thu,  4 Sep 2025 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BpvHdX66"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C968313547
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998795; cv=none; b=OzeOtIESxi7v09yt8bM4LK9Lh40JRAGtjQA7kOw/JfKFrX2oKfq/6vmDpEw/qBsh5PfmiOSofkFccfpICxN17s/+2bwUxfr3Hr02aoDmc/eMUJb5/ipuocCRy70r2TGIj4HzEgaRr0euYxUiIcdvC+iQIgH52Yzv10p74emn9+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998795; c=relaxed/simple;
	bh=hQTesLUjwHoE69NvEeQegylR6nw/aEJIYz4xhLEq3pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEDvKpI2s1iV8lsdE12mpwVw8iPr6n/K/jTvU7h5cV3qG6Q2uqFWHA21JhR8JkOnYuVZ85IBwKExU7f5McZdqcjFPedTVnCw8GsFxqx53n9eL07aUqwdZ/0aTOterC95QuDAwqo8xZ24hrNtjHMVeXZqOLAwULGYLv8UPY8bRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BpvHdX66; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32b6108f2d5so789843a91.3
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756998793; x=1757603593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWu8/uT79TLkFHaoOripy/trgu/RnF6WTT4bI5QB+j8=;
        b=BpvHdX66LvkycmwydTOg/y7ECD+YX4EjnHp/f0PRlCAltaGzCodAfm2TX9c77LiJF4
         9j1wYGKxoj8xxT7IcVcZ6XGcKxpbmjZn1YywAh935G3WjDNKCpG20ojRzELorZ5DhL8a
         oUx96WIDS8oeYFGOgBNtlcsjEnC0Q5MSA/BgLFGw5JrxNXNAjnnj/A2JakkfO9tzZUvB
         05eF2WwEHp7fRyNwbkk2UOW80WuV6BszewWr8MwKEq8jO05eDlAuoKmXxO/0X2wMCEYv
         dV2Fohl7aIPCTcPplo0VBdMn0SKMU5uT1D4IAYKQBYgahXlYY79f/+XgSBi4/1moUbc3
         Is5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998793; x=1757603593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWu8/uT79TLkFHaoOripy/trgu/RnF6WTT4bI5QB+j8=;
        b=UUUQ/3dRZiEOfjnh57ipF8sO9+BzL+8dXzkBU7DRb9dYeesN7/1u3wFZSCxWkv5jnx
         2iIL6v55QfsH6L5UOowHIaAXJrLXDwl3kU31IcIdO4N8vSvoQZtKnykfLARIjgF21NMp
         L8jxnqveUJCp4w2ODi0WQo3psywTboOTuUZRlQO2S+bjPSTijhl1ab5N83SdsMO+IBpU
         Odw5w5YA44KeY0oZng+bXdh9Tj/RvaGmevYEy2IP78yPnIswpKJwW9MQo6cEvV/zVs34
         NxMkw2pL8tZpmg97kPODXUjdFJFwIZvrYgBiZp2WReHtBvoHsR+zIHIWvIcH/HhiWlPT
         F+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbHLqaxykbTCaYsWfP9se950LJIBOJQd1k/PaFsckbJt5rqd4SrBsSNpBRmc50HpBqfhQ3E3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNB/skvSM/3YcExewaCD+NQ2zIoFS3r6JoTayr2QAn6O8oFFY0
	ntvu9J/lScSGJhmw1vtJf8whjVxXyFI9SyGRBbfES2eF3orazIIhp/I4CscYaryG6TrB+JVnF8s
	DNkicOdZ+5M70wNip9qiSU3EcL6xA95gr1zGTVRq/
X-Gm-Gg: ASbGnctw45+Ht1GBtqDCqWBu6MDPcoQtyiNq9r0hfBOeZSuKv9QEjLONu2c8eh+q61u
	TlQj1Wn2vBHUIRA7zaRU5SPeXBCE8vjqb0LXaroNPQmNGiVVP/xqFAElTH6j97e4mYX7dV1W8JV
	zSYB87tcpY4x78ZAE5nIjlGmirzx0R/PKTrqJJJlbHEDHsidy+Z4KTDBp0CjXLlHNLxxQTyLE8B
	Q6sBr28/QKKukxmhw==
X-Google-Smtp-Source: AGHT+IGqcMqHHAT75zSTTPlBqCVyFcn6AnTIKyagfTnT5D4zUa/iS7NyI7Sait1maUMEoXcJ2nw24OBTrZDWN8ZihOE=
X-Received: by 2002:a17:90b:2ec7:b0:327:e59d:2cc2 with SMTP id
 98e67ed59e1d1-32815436083mr27618387a91.10.1756998792394; Thu, 04 Sep 2025
 08:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68b93e3c.a00a0220.eb3d.0000.GAE@google.com> <68b9ab18.050a0220.192772.0008.GAE@google.com>
In-Reply-To: <68b9ab18.050a0220.192772.0008.GAE@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Sep 2025 11:12:59 -0400
X-Gm-Features: Ac12FXzmdDvybcxdLMeRBs2OONbitrTJM6yCl57blUt8t099sFu8t2Ati4PBkBs
Message-ID: <CAHC9VhR6+cHx+FvonHtAvuNZ-Ls77HjGnU5k5VR7qy1BUSaxdA@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] INFO: trying to register non-static key in
 skb_dequeue (4)
To: syzbot <syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com>
Cc: apparmor@lists.ubuntu.com, audit@vger.kernel.org, casey@schaufler-ca.com, 
	davem@davemloft.net, edumazet@google.com, eparis@redhat.com, 
	eric.dumazet@gmail.com, horms@kernel.org, jmorris@namei.org, 
	john.johansen@canonical.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, luto@kernel.org, 
	netdev@vger.kernel.org, omosnace@redhat.com, pabeni@redhat.com, 
	peterz@infradead.org, selinux@vger.kernel.org, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:07=E2=80=AFAM syzbot
<syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit eb59d494eebd4c5414728a35cdea6a0ba78ff26e
> Author: Casey Schaufler <casey@schaufler-ca.com>
> Date:   Sat Aug 16 17:28:58 2025 +0000
>
>     audit: add record for multiple task security contexts
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1199fe6258=
0000
> start commit:   5d50cf9f7cf2 Add linux-next specific files for 20250903
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1399fe6258=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1599fe6258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7d2429dff5531=
d80
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbb185b018a51f8d=
91fd2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15b9a312580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16819e6258000=
0
>
> Reported-by: syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com
> Fixes: eb59d494eebd ("audit: add record for multiple task security contex=
ts")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

The timing on this is amusing, I got the sysbot report just as I
merged a fix for this provided by Eric Dumazet :)

https://lore.kernel.org/audit/20250904072537.2278210-1-edumazet@google.com

The commit has the appropriate syzbot tags so this should close out
automatically.

--=20
paul-moore.com

