Return-Path: <netdev+bounces-213185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9BAB24081
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0371AA08F3
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 05:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C90A271443;
	Wed, 13 Aug 2025 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ly6WycZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AD2BE034
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 05:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063923; cv=none; b=qx7cJrRGTlmieitXXs2DeNP8zB4lJw+egZ6fOmDvCpozcI1czoUFTR+65d6lLfl1sHfxDCYd8H17UR74KWPc7egFny1lwRET7noqMU2aVJmGaBxXYQojdViXZFkYOk2XpqdVWTQYih+8DTPrgWMB0Oe1BSWLhYIKkoCjiuNsAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063923; c=relaxed/simple;
	bh=ZYikq6ZDg+ibMQL/f6nWlqVFdcz+u4wrp9M122wgNXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kX3blpJaFlww/hJ0hYVERBDmoUOmvbdjWZ1go1PatiXqAEg/7nFIbTsYbZg9v5JLWB9qJWR+Z4pTY/HO9vqncC/XO1DC8B8vrrPIaEmI7X86tXID9XqA06bu0X8dku97jwUHYS5fiAh2/JHkT8Pm6B+sg0I3p+7HjW5Bt/0J9ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ly6WycZQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24041a39005so39789095ad.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 22:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755063922; x=1755668722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qaq36KFIzFlqF8k3WREWRlkTXlOGZc20Ijz7fxyxT5Q=;
        b=Ly6WycZQAzkUC6rZ7ZwNu1jFJ8pYGrFcls7+QhjjJFoipmZmFQBTAd2b9PEsukzRoO
         dSzUi4jhrOEK4W0FXnVbVbfpRdvyvcX0H7GDAIH1mFHAN97mzxg/0OuX5HzaXAa3ZLGC
         Ti3vg5cUPABxI4s7dIVTaA55ogbmWpEmgHLa70uQSLnoB3b150le3J2FTkIFQDYbhCQm
         WcVg0ddxdYVGa38prnKMoEfRaLJc4L5OBZaasvSVchXlv6+OZ62GVI6paUQT7C6MVS0Z
         lKnfBUl/70kMx6icBSM1ZzqNXcPaXasooXZVKvt7bi2ZCld0/dSCEEq60o+fdFgoIBKy
         qqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755063922; x=1755668722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qaq36KFIzFlqF8k3WREWRlkTXlOGZc20Ijz7fxyxT5Q=;
        b=l99q8brgwoIHSWaX23UftwpKiqHnAWvw96Fpv1zLOq9nZ7QZWhkmo1NXNjFqboHMI8
         KUawp4Fx3zTq98CE2TRNwHc8u7RTI38ssPO/j70BZhyRPWaBZvaaBLxwdgKSODYPqzdi
         8E5WS9YhWXl2lqtnxSL++44eBAxjlat4Bvca5qztz760dqJIR+kWS4tnBvT4KjbBgyjR
         PeO1X7Eo9khgRDWu7h6MZJZNWoj8Klv+cdoaC5Tuo8DV1FDwO9KH5ethL31FaEEVJ24Z
         XEtd0mdAOCAaiUiqpPu/Rzs+7qCuEAPNz8p0k96qAtN73W9x9Reo/INt0L0lv6oKRLsC
         qi4w==
X-Forwarded-Encrypted: i=1; AJvYcCW8aORIGqTUlmLls0xV1emwGzMY1X4VMa2CZTMHlpXThV+ABCWBTXiNRfHzicU25b+oggUcCSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqmcZQkyF9Rw5KytWWa9JYFe2o0VR8Fr8NZgbAJbRZGdEsETQR
	Poc8y/ohhc8NhKX6g5zkA16hnmOfkVDepUvHU5R8ycYlSPkPbH/RM8+0K9MRX9jMqz5REJ0liv9
	Jl/dFt3Nt3CxV9GxHaYT1WPfJ95Hg/jLxI2LcwJTh
X-Gm-Gg: ASbGncungKpcPxTLSSw241RjTK4Fi+3A8AwS+Xc15ZFpfFi+By1be0v9XVh+L1N+RdS
	ZS/ZBnJfzU+0YiUVZJ3SF5wy2j5B3kn0X70P3v0lN1Km2upTO0nhy+mE2Aukeo4Qz2rm80+DOJb
	eEO0VOuVBfU2bPYQcGXAoTPb8SMMaQZRj9Nct8kuNqkpVIqgFGHIAcngivlRWIhDjIvNqiAmVIF
	zL85u8qIGhTC0tLvt/OnMdpIWrv2w1xTHpg+42Yki4Awu7a03I=
X-Google-Smtp-Source: AGHT+IG2uHnAmpipqO2dw+6rmaFjRxOwwGwijIBr0q2ylLWKUeVEMmgNwQuLFjll+r/Km/0aRMJkibnVfDWFBCU5A04=
X-Received: by 2002:a17:903:988:b0:240:72e9:87bb with SMTP id
 d9443c01a7336-2430d201f87mr27649015ad.42.1755063921657; Tue, 12 Aug 2025
 22:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813005602.4330-1-hdanton@sina.com> <689be791.050a0220.51d73.00b9.GAE@google.com>
In-Reply-To: <689be791.050a0220.51d73.00b9.GAE@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 12 Aug 2025 22:45:10 -0700
X-Gm-Features: Ac12FXyf66bi4XKtwyVD-x7BvsY22TKhwNiZ5ZyHMSgOzp6HLclNMDHU6njSXSM
Message-ID: <CAAVpQUBB7eE2LCLXSFv3wzPhmTKJxz5ZP_Hw9FPRj6y5hHtArg@mail.gmail.com>
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_queue_free
To: syzbot <syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com>
Cc: edumazet@google.com, hdanton@sina.com, leitao@debian.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 6:17=E2=80=AFPM syzbot
<syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggeri=
ng an issue:
> KASAN: slab-use-after-free Read in udp_tunnel_nic_device_sync_work
>
> netdevsim netdevsim3 eth3: set [1, 0] type 2 family 0 port 6081 - 0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mut=
ex.c:577 [inline]
> BUG: KASAN: slab-use-after-free in __mutex_lock+0x147/0x1360 kernel/locki=
ng/mutex.c:760
> Read of size 8 at addr ffff8880434426b0 by task kworker/u4:10/1096
>
> CPU: 0 UID: 0 PID: 1096 Comm: kworker/u4:10 Not tainted 6.17.0-rc1-syzkal=
ler-00016-g8742b2d8935f-dirty #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Workqueue: udp_tunnel_nic udp_tunnel_nic_device_sync_work
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xca/0x240 mm/kasan/report.c:482
>  kasan_report+0x118/0x150 mm/kasan/report.c:595
>  __mutex_lock_common kernel/locking/mutex.c:577 [inline]
>  __mutex_lock+0x147/0x1360 kernel/locking/mutex.c:760
>  udp_tunnel_nic_device_sync_work+0x39/0xa50 net/ipv4/udp_tunnel_nic.c:737

This is apparently another issue that I hold in the syzbot queue.

