Return-Path: <netdev+bounces-65434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B563B83A715
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 11:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED2E28C716
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EAC17C77;
	Wed, 24 Jan 2024 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="welx1qfB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988D1B271
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092991; cv=none; b=DN3yxqRHTMg0yInejtFphYtEK5RyI9Xv2/vn9koxTiC4Eosd3sS0042UUSXNbnr6Wijj+a/zIq2gAIYGU0Rxzv5DQdJ0WMo/+meFTaJUrQuO39RWu/DY4X1VatVJ9UET5o0XOZBVOeQTsoBk5WLftgnIuut9+4YE1MoKQJ/Y5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092991; c=relaxed/simple;
	bh=tm8SYL6OBqZKJ3UXZA0SZY268RFJ9rT+2W3TJ8wRTfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2lyXGAf+X4x2TNOyIDo/b81LJVnjjPICB49pMuNgwqzFyt+3naeWX/7XRfrU5ux6KfBqAlS8h6VkG/vTzgAdLvxWTAXtKaLCkuqjh/JHjIHS+Pk9xjhUMI5FRuL7/Pezoismt0eMnvTpcddXazLR6KtGu0WWkMmYW+1/v1Gcgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=welx1qfB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso13389a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 02:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706092988; x=1706697788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqCT08+MvCKkOTXY4Y0tOOr9UtqwBr/HZdtw0FsPlto=;
        b=welx1qfBG8rQ0qTKu6refLligzZY+FgISLKCihmtE3zHP/JhtWgOq//RkkzxEkSibe
         nKTRGPzn2A/4j8nGpvpN6SJvBd4R2GQgweHlkAKyIBEG7NfRQxcvbdErUwbB+8pR40qo
         KSCFvZrK5qOwDLXo0r1VmttiRyJimak12eJQcZoH4Uofdfzs68t85LnQxU/8mZhCJl0/
         0ml7dEPwhiDepB5DvT6DWF+io7faIYHq/LW3NndftKn8mbT5T6MmlYLF9jdPVa9Y4ywh
         nazoH1832EyVvdSVUYWsDyGV6RRUn+hcHLdv6Z9yh11ZSUlOc3cK9k5BLsUb2BrAyTWo
         ThEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706092988; x=1706697788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqCT08+MvCKkOTXY4Y0tOOr9UtqwBr/HZdtw0FsPlto=;
        b=WKHTijA6p+uYqsz+lsE//8MB74s9n++cXt8h4mNtHKpWLX1N4PNhp/lD8hbrQhAFfW
         wIhWWTG1SuUMu/srgP2f9pgJdA2slVy+z+rOetE7gY3XgGKoJK1IyE3yDzWVmrPnrszl
         nUdjWjk1jnUkdh3jRgy5yDicBiCfNZgm6GnaRchm7lqzB0XLEnnJT1Lu3/XJSYuJVXF4
         5dd4xXbmCQeLnudiMcnoBmwohdj4WzhsdDyCf3+gA7LL3pDQV0uMo/1uFDbgIc10++hX
         CA5zpfZVjX8lH+aXSv/jSnNBlIvH6fatPwVHI+myXk1lbm8sLNoGNVMn7ynCuZsJLVkN
         hLEQ==
X-Gm-Message-State: AOJu0Yy//1QxCRglF4UCMkyBKkm3jVZKM1XcP+EO8sQnd9FMYPcl02HE
	DMhVggV66QJ0HwQGk2bNZthqS/J+daKRUYCZ3ZKOFrfAc5MhFmXEZKi1PGvj5zQvlR7yJeQEFnT
	zzyA6rPL9DNd/zSkT8p3DcS9yj2NQc/fYM+XiCeU2NiW46Ll0HpFg
X-Google-Smtp-Source: AGHT+IFA4Tc1j4sf2WdSd9/PHzO6hw9s+bdVXHkMEgmkV/sJrLFCLqNCgSWRThpV968rVYpmG1ZNtjXk5o4YzlQpA2I=
X-Received: by 2002:a05:6402:3109:b0:55c:6037:c237 with SMTP id
 dc9-20020a056402310900b0055c6037c237mr99964edb.6.1706092987914; Wed, 24 Jan
 2024 02:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124101404.161655-1-kovalev@altlinux.org> <20240124101404.161655-2-kovalev@altlinux.org>
In-Reply-To: <20240124101404.161655-2-kovalev@altlinux.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jan 2024 11:42:54 +0100
Message-ID: <CANn89iKxC5KiqZ-NS7qkgX-6qcUYBJVsdbesXwrAOKTh=oJyZg@mail.gmail.com>
Subject: Re: [PATCH 1/1] gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
To: kovalev@altlinux.org
Cc: pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, osmocom-net-gprs@lists.osmocom.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nickel@altlinux.org, 
	oficerovas@altlinux.org, dutyrok@altlinux.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 11:14=E2=80=AFAM <kovalev@altlinux.org> wrote:
>
> From: Vasiliy Kovalev <kovalev@altlinux.org>
>
> After unloading the module, an instance continues to exist that accesses
> outdated memory addresses.
>
> To prevent this, the dump_pdp_en flag has been added, which blocks the
> dump of pdp contexts by a false value. And only after these checks can
> the net_generic() function be called.
>
> These errors were found using the syzkaller program:
>
> Syzkaller hit 'general protection fault in gtp_genl_dump_pdp' bug.
> gtp: GTP module loaded (pdp ctx size 104 bytes)
> gtp: GTP module unloaded
> general protection fault, probably for non-canonical address
> 0xdffffc0000000001:0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 0 PID: 2782 Comm: syz-executor139 Not tainted 5.10.200-std-def-alt1 =
#1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-alt1
> RIP: 0010:gtp_genl_dump_pdp+0x1b1/0x790 [gtp]
> ...
> Call Trace:
>  genl_lock_dumpit+0x6b/0xa0 net/netlink/genetlink.c:623
>  netlink_dump+0x575/0xc70 net/netlink/af_netlink.c:2271
>  __netlink_dump_start+0x64e/0x910 net/netlink/af_netlink.c:2376
>  genl_family_rcv_msg_dumpit+0x2b8/0x310 net/netlink/genetlink.c:686
>  genl_family_rcv_msg net/netlink/genetlink.c:780 [inline]
>  genl_rcv_msg+0x450/0x5a0 net/netlink/genetlink.c:800
>  netlink_rcv_skb+0x150/0x440 net/netlink/af_netlink.c:2497
>  genl_rcv+0x29/0x40 net/netlink/genetlink.c:811
>  netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>  netlink_unicast+0x54e/0x800 net/netlink/af_netlink.c:1348
>  netlink_sendmsg+0x914/0xe00 net/netlink/af_netlink.c:1916
>  sock_sendmsg_nosec net/socket.c:651 [inline]
>  __sock_sendmsg+0x159/0x190 net/socket.c:663
>  ____sys_sendmsg+0x712/0x870 net/socket.c:2376
>  ___sys_sendmsg+0xf8/0x170 net/socket.c:2430
>  __sys_sendmsg+0xea/0x1b0 net/socket.c:2459
>  do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x62/0xc7
> RIP: 0033:0x7f2ea16c2d49
>
> Fixes: 94a6d9fb88df ("gtp: fix wrong condition in gtp_genl_dump_pdp()")
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> ---
>  drivers/net/gtp.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 477b4d4f860bd3..3fc4639711cd83 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -1675,6 +1675,8 @@ static int gtp_genl_get_pdp(struct sk_buff *skb, st=
ruct genl_info *info)
>         return err;
>  }
>
> +static bool dump_pdp_en;
> +

Hmm, it seems there is a missing try_module_get() somewhere...

__netlink_dump_start() does one, so perhaps we reach __netlink_dump_start()
with a NULL in control->module ?

