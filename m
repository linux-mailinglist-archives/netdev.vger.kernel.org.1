Return-Path: <netdev+bounces-152192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C18D9F30BE
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7146616672A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BFD204C08;
	Mon, 16 Dec 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zpzwlbG1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2544B1B2194
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353024; cv=none; b=cVNW0VUl8xH5fOmpsdP3ZBY7MLE+RjapVpelEp662FfUh+iKagUcpcWuY8jshMM2WAcf0cGmekRXTJTobm3ozG+O77Sz6yHKHWKYI8vmO8dvJpS7AQ50Cf/SMV2dvfvQ0Uiv1OozD+qLlzleUS8N7GUtRVXsS0clHjstdTUlPA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353024; c=relaxed/simple;
	bh=cZkh0AZozsNptSxd4rD/09HIJx7QaOjQWpnQftNsFWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwoYlxu23cqqwsvp5iV8ilFWE7lSVbeCdiC9Hawk3KBuEdpFitht7OOdwvjRKlip+3QJ8JVV+sWgFN8VnbxND1tPJRF6CiqJQ50jY92fC4ceGWJz4FUHrCusgbOBdNfOHu+M0RITotRGRyuD6CpNuOAtImDMnbyZEW5NyBMT5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zpzwlbG1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so7396775a12.3
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 04:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734353021; x=1734957821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAjDOaoBeR3j10H4yGH5iSfm+WmObSUX7zsz7QJQ+X4=;
        b=zpzwlbG1FaPAV+dd4cdybQfO5MvQNlvrxwg6HE2H51u9TtShIn0cihBUuwjrvGSBz+
         jhF8oDOQ7ue10zfN+iq7NbtRBd0wpvClIYS30Lsbr5sctbTJAEIc6v5LH4dzhQq4rVHJ
         4Xg+shNUUvxtF866ZO1IfLhhRteVIaEMTkOHFDBl4EVJzr6zeJOR8aedvybZTua96Yjm
         VSDQGIrtfPSwY+14Lg5YyByZE3u8T6/dT489IyaYHcOC4rJvhojwBOgx9u+3jwUCc03s
         MHb5mgJEhgu4UXdSPFlHuGbU9La37Rokl6ETx8AfDUNk3AlXpAyZbabxVscRrMF/8A0q
         8wvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734353021; x=1734957821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAjDOaoBeR3j10H4yGH5iSfm+WmObSUX7zsz7QJQ+X4=;
        b=dM6Xmi9XUx2qnEjmLssVktGXlCSyrgKWAWf5746d5bzmAoouyFe+imh1K0J6SBE6UQ
         zvuP45IzuEVFRZ4n6ikXqV+lPg9g7NSxsS+viJm5fGVOq01ouLqJEUs4/wz6hiSVBuZQ
         BTX/Zr8FZm1mVLJqYHH8/uRvYPvow1QS835xMrlwclXU2Tlt/tsiQ6B4shUSKhZKEoIB
         7AZJamUGQ6jVT7Qmu7jE9JTl99jLarI9zvKFey4OR/QeXYAmVkew4cbJpv+nIZzrhNbg
         qbBy0eVrMH/+RumYf30bP2AgvWZ6/zpp2za0cinabJzFulAnmDuXbKRJp2kisLeXwIPx
         uCMg==
X-Forwarded-Encrypted: i=1; AJvYcCWFuzGCfjKldx2k1/e9zkUq32s8oa8bSMUa3kV7fRsq90Q6DIpqLgaC9qPCV9q8XwobsZwNnGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF0MMmdyxYHDnw4doXM/i0kJelfGAzvAGXdWdi+uInqmiMIoku
	MrTaqXaQRa65/ukG6UKb3shmNUHNEh2L+SzYZgF4QJlCPFZeiucLGUdMvvXKAcLyvWO2gBzc6U5
	bvoleJw2qBCLPUGaTwY4TN2IMS/djpe7VPNCq
X-Gm-Gg: ASbGnct9x4cR1GO2m7d4pmwVPHlMTvrX9orQ9x1YxN0uOws4BHjVruBmI8/oEbfsApd
	X9h3tI3F1h7VagrOupD4kSi+LTWwunQohhyFriIZdLNcnk4UbzSSe1VrQ+SNol5NqIqw5C0Cm
X-Google-Smtp-Source: AGHT+IHukk2VvDoS5P68jRqa/VNid3yYK6VmHjj2RqTvat7rxCMcUd4gH+kPyRzBQwDmE4jXFOUkU+EZPnavX0N/iqs=
X-Received: by 2002:a05:6402:2682:b0:5d0:81f3:18bc with SMTP id
 4fb4d7f45d1cf-5d63c2f8966mr10947749a12.1.1734353021391; Mon, 16 Dec 2024
 04:43:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216-sock-kmalloc-warn-v1-1-9cb7fdee5b32@rbox.co>
In-Reply-To: <20241216-sock-kmalloc-warn-v1-1-9cb7fdee5b32@rbox.co>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Dec 2024 13:43:30 +0100
Message-ID: <CANn89i+oL+qoPmbbGvE_RT3_3OWgeck7cCPcTafeehKrQZ8kyw@mail.gmail.com>
Subject: Re: [PATCH net] net: Check for oversized requests in sock_kmalloc()
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 12:51=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote=
:
>
> Allocator explicitly rejects requests of order > MAX_PAGE_ORDER, triggeri=
ng
> a WARN_ON_ONCE_GFP().
>
> Put a size limit in sock_kmalloc().
>
> WARNING: CPU: 6 PID: 1676 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x=
32e/0x3a0
> Call Trace:
>  ___kmalloc_large_node+0x71/0xf0
>  __kmalloc_large_node_noprof+0x1b/0xf0
>  __kmalloc_noprof+0x436/0x560
>  sock_kmalloc+0x44/0x60
>  ____sys_sendmsg+0x208/0x3a0
>  ___sys_sendmsg+0x84/0xd0
>  __sys_sendmsg+0x56/0xa0
>  do_syscall_64+0x93/0x180
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

I would rather change ____sys_sendmsg() to use something different
than sock_kmalloc().

This would avoid false sharing (on sk->sk_omem_alloc) for a short-lived buf=
fer,
and could help UDP senders sharing a socket...

sock_kmalloc() was really meant for small and long lived allocations
(corroborated by net.core.optmem_max small default value)

diff --git a/net/socket.c b/net/socket.c
index 9a117248f18f13d574d099c80128986c744fa97f..c23d8e20c5c626c54b9a04a416b=
82f696fa2310c
100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2552,7 +2552,8 @@ static int ____sys_sendmsg(struct socket *sock,
struct msghdr *msg_sys,
                BUILD_BUG_ON(sizeof(struct cmsghdr) !=3D
                             CMSG_ALIGN(sizeof(struct cmsghdr)));
                if (ctl_len > sizeof(ctl)) {
-                       ctl_buf =3D sock_kmalloc(sock->sk, ctl_len, GFP_KER=
NEL);
+                       ctl_buf =3D kvmalloc(ctl_len, GFP_KERNEL_ACCOUNT |
+                                                   __GFP_NOWARN);
                        if (ctl_buf =3D=3D NULL)
                                goto out;
                }
@@ -2594,7 +2595,7 @@ static int ____sys_sendmsg(struct socket *sock,
struct msghdr *msg_sys,

 out_freectl:
        if (ctl_buf !=3D ctl)
-               sock_kfree_s(sock->sk, ctl_buf, ctl_len);
+               kvfree(ctl_buf);
 out:
        return err;
 }

