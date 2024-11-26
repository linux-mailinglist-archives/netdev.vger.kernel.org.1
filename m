Return-Path: <netdev+bounces-147467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47929D9ACB
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 16:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D670165D64
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F361D9A48;
	Tue, 26 Nov 2024 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FTnPyA3z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187471D89EF
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636460; cv=none; b=UWxCWTd3GjqknX+l+NitJ/BOBxVnm6qNBqF7gdDx2abbDV7l9iSgO70xtlC3dOfKXmdL+nhOcfB9hWwHsM3jfaCTWSMu0quXnSqktGFlp46oJQPt1RTlPK68VWTBIdxF1zd9jhnrl1jYbjKLBtkIjV+bwkwGt9TtLZJ5HUb/v34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636460; c=relaxed/simple;
	bh=rosU/WtGHzpg1m5SoGV9dmJI8h3VMeqSG1DBeFmqTII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guCcLxWNsNsdOUD4qq4KcYpDSnBl0His7RqGMxgCYkQQMWrUQPfLTOnek6KWqWhpOVlpGlvulLfkYSZxWGHPCcTDNwxu+QdpQKhxLSj17H/ww7I+pn4hnSodvbOCeBTihzwZrqX9PqVmu5LyAHjoFEq+p60ZNAJsa7b1YpPubMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FTnPyA3z; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e388c3b0b76so4610286276.0
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 07:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732636458; x=1733241258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOXYwSglgs6HHLdPsjLwekOgaVMw0pcZEJPHu1HrIhI=;
        b=FTnPyA3zNxBjiMYwEqmA+X6v/HA8PG+BpxE9S91aPfMCF/BS26ce7jP+mdMM8kn0YL
         aB6TnhkLSPGitwZq/l4p3z3Nq8rwpEk3iQCr6jvP08Vc0nIaAvoqj7i0zhdikOubSyyf
         wELRcZQGncHx+zoJZTce8f4eBGcZi0xZt2Kx8H7Tyj4Q3xMgGL2PfkyphkpBmzVlCaWf
         oge+2hdLKmmQJnqfUnbv3CrRXcGQ8khKhIQEI094PTYF0xdGcCDBLRXk4ck2Ub0pX62K
         aQrZssKlfig3JK6euuZHU7pKWTd0fHebvMkMSx3/aaecewOZCDJggwV6QLIprOqek4iw
         m3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732636458; x=1733241258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOXYwSglgs6HHLdPsjLwekOgaVMw0pcZEJPHu1HrIhI=;
        b=PfTIGgssMjH3/7LTCfQDaKdYUp8Us/qn2UY1wygJ7YFw8a3KWWgfSP4PsbKmA6Dpje
         hjU8j+ZtgvhYOdHiMbIkhdQxyTd/rDYBPcv+vbR+P272jLXRnu32Gyx+BCKVrtjyFge2
         plNRcexCaVYVs+ao0m820353AKYpJ4KKQdpXrvsBs1hSqu3i7qR/0PRywwXj6Tcl/TZP
         LjQgG1ORynNJHJUdevHe7TDF7BJ9mmFRWLkPzofGOONKDFx5M29CXpcHWZGDagDztdSR
         obCj+fO1vvY3lleUmV5Uq47q3/kwLlTs01gsHu+Cu7o2FZqkQ8kl5aL1hVi5lmPm7Tiq
         /Hpw==
X-Forwarded-Encrypted: i=1; AJvYcCV/lJhSGEU5eO/74ruinCzXliPD6q25xgGg/JDQjPrbmTgtNpJ2Xfkgm+Y+nQ/CrXtZAZxOIU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP58gyE6RB5poMQbaB0Jddh3w0cKQKAyTcfzPEiMSXrob5myNY
	HI4R4WTvucc4zYFPLkGMVMSBEGGniyC5d64XL6okXn9hqJ8KulekG3jFwTUEW0pWpUhMTXhZOZR
	OSF6jje8sLvRB3YlmYYBrbbckHifLYYt+yho4
X-Gm-Gg: ASbGncs/uAv+JgPIcejlGMW7LmjslbdBO7gXOH3Qp26DU5uhndeeXxW2UCWoUG2eXaY
	NcqZMJhP6qeHvnBL6ijyYSkSKrz33PA==
X-Google-Smtp-Source: AGHT+IERJpr6pJPyD8SpbpVUXGGQbVE+6cJ+xyM6TzXPHqxtR/wM+P4HF9a+NzJOK5C8S/UvZZh5FuFhmfMN46a5Q34=
X-Received: by 2002:a05:690c:7109:b0:6b1:1476:d3c5 with SMTP id
 00721157ae682-6eee08a476amr143151387b3.12.1732636458099; Tue, 26 Nov 2024
 07:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126145911.4187198-1-edumazet@google.com>
In-Reply-To: <20241126145911.4187198-1-edumazet@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Nov 2024 10:54:07 -0500
Message-ID: <CAHC9VhQ9qJGBo3CmgBRvqLMfctHUOZrT3R8iiL9ZH7mM735YPA@mail.gmail.com>
Subject: Re: [PATCH net] selinux: use sk_to_full_sk() in selinux_ip_output()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+2d9f5f948c31dcb7745e@syzkaller.appspotmail.com, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 9:59=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> In blamed commit, TCP started to attach timewait sockets to
> some skbs.
>
> syzbot reported that selinux_ip_output() was not expecting them yet.
>
> Note that using sk_to_full_sk() is still allowing the
> following sk_listener() check to work as before.
>
> BUG: KASAN: slab-out-of-bounds in selinux_sock security/selinux/include/o=
bjsec.h:207 [inline]
> BUG: KASAN: slab-out-of-bounds in selinux_ip_output+0x1e0/0x1f0 security/=
selinux/hooks.c:5761
> Read of size 8 at addr ffff88804e86e758 by task syz-executor347/5894
>
> CPU: 0 UID: 0 PID: 5894 Comm: syz-executor347 Not tainted 6.12.0-syzkalle=
r-05480-gfcc79e1714e8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/30/2024
> Call Trace:

...

> Fixes: 79636038d37e ("ipv4: tcp: give socket pointer to control skbs")
> Reported-by: syzbot+2d9f5f948c31dcb7745e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/6745e1a2.050a0220.1286eb.001c.GAE@go=
ogle.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> Cc: selinux@vger.kernel.org
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Brian Vazquez <brianvv@google.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This looks okay to me and based on the "net" marking in the subject
I'm guessing you're planning to send this up to Linus via the netdev
tree?  If not, let me know and I'll send this up via the selinux tree.
As long as we fix it I'm happy.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f5a08f94e09402b6b0b1538fae1a7a3f5af19fe6..366c87a40bd15707f6da4f25e=
8de4ddce3d281fc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5738,7 +5738,7 @@ static unsigned int selinux_ip_output(void *priv, s=
truct sk_buff *skb,
>         /* we do this in the LOCAL_OUT path and not the POST_ROUTING path
>          * because we want to make sure we apply the necessary labeling
>          * before IPsec is applied so we can leverage AH protection */
> -       sk =3D skb->sk;
> +       sk =3D sk_to_full_sk(skb->sk);
>         if (sk) {
>                 struct sk_security_struct *sksec;
>
> --
> 2.47.0.338.g60cca15819-goog

--=20
paul-moore.com

