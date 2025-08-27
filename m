Return-Path: <netdev+bounces-217401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24283B388AD
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 19:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792CB1B27013
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5E427A452;
	Wed, 27 Aug 2025 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3V1JdYe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9D274B2B
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315850; cv=none; b=Tcx7QG07TnJWdgLBRtHSi/7EtQKpruvmeWD5iw1xZm6lwsXaIPAJYEvVKxO7BdrqcvVBuuIrY7gP2H9PyQFHN/m8TzORykg+IZwVxwcKzRChzi4W4TLAV9YouOX95DUNam9juVIQviZghOQro4zRJ5y9yroaXOLcqOybl3Gtq5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315850; c=relaxed/simple;
	bh=dt51XtCNtXci/EXGFridVV04c650fzkzb2P4qqJpBFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsG7CbL0wuD4X1vZ3q/EJk6Db5GNAVXuessFg8OlUeGBvIWXvIBsIu4b/S0me9kFRswyg8jNSTFylP2i3mO4PBK/Yz0fIKVZpPEUJPRBBSMZXMZKjVTjfX0LBMgu7+bYdnhqsIgMEr/yv0rqYDVY5FLZDdL8ljL1aZhY3aoNMmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V3V1JdYe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24646202152so1022925ad.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756315848; x=1756920648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfzGUTTji+nM3rFcZXPv8YZXSEkCQdfI1L9zsyO3/B8=;
        b=V3V1JdYemUd9bRXgVUb41nM+vY246hCwHRnRcpUjuuKjXomnxLUi2fQsqCQ0s9a8Wb
         a298GU9cKR23yAGSS3aDqpb/oMYCiuPy8qgdAo17VA+NytCx+rr/gP/k9RjKB7TZCKOV
         cepU2FIzCabXikC02F+fXuWuymeWXFLSUPkbcX1iqOYZwvq+cMh2bLqW9NFMkTHDsdI6
         mmf2IZlJlQsu2BHlJgIUovvztkpbOynXV3Ercc+RixPVnVsU6ywATwp138pvHMME2lsR
         flWNoEjaCnnWOUk7YyaPlCY4NSgdueJ+HRWNfs84F9sq6iUbs4U218swNfQUanC2zkvM
         w3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756315848; x=1756920648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfzGUTTji+nM3rFcZXPv8YZXSEkCQdfI1L9zsyO3/B8=;
        b=cx9Bd9Nd1E9gMXrGTZjIbiqnY6qnr+CbUPBBRUNN93ejzYQten93+tl/H/wNpPHMsx
         5MVPzL2UJzNSPnrnU8JYWd84SQznxUPS9ZBXszxkgMKI4rsOJqMMrDMA1t4VzRciI5MO
         SAlbo8ZH2kDP+lELpVoLY1Ocg4q1D3CUUZSAWR2dyJZr2jVQ1BjFHt/d/TgYwh2KtVAw
         QUSLpcHp9jYNV+cYdrYbv+ReVTDN0giwskgVmJpC1t15KjYZC7RtKYa8a2TolkEd+9fJ
         rmu4mPC3q6Po1PN3dVI/7l6S0viNlAY79i068JlZhSl1uENN28XBtLIgKSLNk1vkkYJ5
         okiA==
X-Forwarded-Encrypted: i=1; AJvYcCVyCWHPSseDDb8EFqQvqBTPgCTAIRGEAiUcgqOVRLRMZ14RgcVCHPxIwVdahbHE5B6wTFwBN0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5zonpb8cmx0z/TaZy1jZ504g7aT8Jh/BnAngjgb8PmP+VyjGZ
	cU4wn4pY6zcC+EAz65otTixm6Ri29p4UJ//0XD1TK4MUFGNuTogYupTKlzSdMVq12HczCzrdoNU
	6UNHiYv9LRrdqaF2AxGFAsP+jg2XcLVgrR0u/ZJlKAESrg/BpmYoj2a41bCI=
X-Gm-Gg: ASbGncspUqWoinXSSxUsNkWAV0Zy8tSm664X0SXxSrZLhtzdkx4KXr/KY4q8dJmnYxy
	7Tgk1sVMPqayuu/OEK2fT0aylYHebu/0AVyxlNTI3LsRfrMiQO6elRzmcbbFl/f4YecjfZiUjbM
	tuiCQI82cn27gJbguTpYd8m/ZP1b5CJknCq8zJNqrSZVIrKiYpwmHb9O4bMtRUnEOj2o1tzTUpl
	lENfvJ+MqoRyB1eMeEjiAz97p5/eLlDZsLCqPhWM13TJ0iV5aXZXx3+XJvocDxb+AF/SnVokl/5
	GHP5W9c=
X-Google-Smtp-Source: AGHT+IEewcIHqbvFQXAza4xnDbj2JYUBmsqWv9W+i7nqd5dHzl7oDRm17OoihFioOZJap6XJUu5Hy9ed944ukd0YKRI=
X-Received: by 2002:a17:902:d4c8:b0:246:d00f:291b with SMTP id
 d9443c01a7336-246d00f2ae0mr153539885ad.33.1756315848143; Wed, 27 Aug 2025
 10:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827172149.5359-1-edumazet@google.com>
In-Reply-To: <20250827172149.5359-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 Aug 2025 10:30:36 -0700
X-Gm-Features: Ac12FXz_tUvndPtNsj7yZ1rTu5_PJFFFDAMiLBC3I-5D5p6_oTbGjerzUfr2Osc
Message-ID: <CAAVpQUAPJFzz5PRbrYi2+RU3sZOV71MSfL=T_iP=xo76JoaE9A@mail.gmail.com>
Subject: Re: [PATCH net] net: rose: fix a typo in rose_clear_routes()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+2eb8d1719f7cfcfa6840@syzkaller.appspotmail.com, 
	Takamitsu Iwai <takamitz@amazon.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 10:21=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> syzbot crashed in rose_clear_routes(), after a recent patch typo.
>
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> CPU: 0 UID: 0 PID: 10591 Comm: syz.3.1856 Not tainted syzkaller #0 PREEMP=
T(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/12/2025
>  RIP: 0010:rose_clear_routes net/rose/rose_route.c:565 [inline]
>  RIP: 0010:rose_rt_ioctl+0x162/0x1250 net/rose/rose_route.c:760
>  <TASK>
>   rose_ioctl+0x3ce/0x8b0 net/rose/af_rose.c:1381
>   sock_do_ioctl+0xd9/0x300 net/socket.c:1238
>   sock_ioctl+0x576/0x790 net/socket.c:1359
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:598 [inline]
>   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: da9c9c877597 ("net: rose: include node references in rose_neigh re=
fcount")
> Reported-by: syzbot+2eb8d1719f7cfcfa6840@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/68af3e29.a70a0220.3cafd4.002e.GAE@=
google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks for the fix !

