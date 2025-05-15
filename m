Return-Path: <netdev+bounces-190848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2991AB9108
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FAC3AEA31
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6E4288C9D;
	Thu, 15 May 2025 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2E4TkUI+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEEC253F3B
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342626; cv=none; b=U5QGtJ0DvaHunAFv6j+l/SmwOWEMpkvIijUndddz6WtLD+cAJxlsZkMx/Uh6GkDyJN3hjZVs8QYH09aulppzgM9GutzSzlBgh5m9qE/1W/uqfS4Y6kjSJCxUN0WgUjF1Gnl5X/wTJdOJc32DfizbOfkkr3HmX3KSg5P/KHjnMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342626; c=relaxed/simple;
	bh=WAuojBQeTYGID0V8nfyJqR75i/8ljPBUHbmJ6zl0Hyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoTi8I3e65GXEt2x8sYVLTPshXNYA/TQrUC1+H+InXnDVAtBscaNeC6wwS0zy3dEw3l/4ZUlkqzcciEdY0tsJAR119kK6PTql4o4tK1vPcRxI/mXgm4zhwceA5+YptYeM50LNZKCQtoKkhI+3VV7R0Y+dT/zp49G87r0r1yNqpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2E4TkUI+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so1325a12.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 13:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342623; x=1747947423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6d1ws3HBhNK42TBISsMf1OSa89s2CwS14owdyho6Rk=;
        b=2E4TkUI+CkbZkAlnC250Mxe9/xitNISCbm+s0arngzN0SxILB4dg3HqI1BK5I2zKgR
         7GvKDcylgzK2pQ8eohgxuiqSAqXPEBBRpOLErS9ShOHKJzGF9hlw+W3Qusq8Kh0RKJRH
         1uv9KbqG70Pudhl5fpsuzWxkf9fEHohYHWmoF1/VcMn9aB4uWARWkKn0F0C7lU75gr9I
         NN31mT6E32bLzayS0b299ZgICa992MhsyXDwmx0w0rOrghswTtNGP4OOYvHhd+MDzOzh
         s2i8n7hfxoOkW8mB1+ej/yFWZc5FpQg8COHGEr0eu5XYG8ry1xBhWe9Wt1aIp4x5KIqv
         5rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342623; x=1747947423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6d1ws3HBhNK42TBISsMf1OSa89s2CwS14owdyho6Rk=;
        b=InYLRAFt03GS14Nq6Q262PfA7hOCdsuuL9otsBDsx0/zrXFH7FHKZXUF8JO3AEO+Od
         TVWw/gsthUJ2X/0RM0gmj1j8/S6MPqDxqEBR4Fsxb6PZSNkiV60I+F1zC68grc/vIHaH
         GzQ9p7C6YF3+tHmaYWCPwPOtzEz8cWQsQlTINNWLjESJhRXOxhe/hI0Qd62djpaMFzWB
         jCtW7rW93iBWaSRaTJ8z1PJrk6yTDidTm+hgPQzyI1mQBLo0ZK3Jvfd4CdcPeXAOW2hf
         cCuJzMKyGKikTfOx50amOFD95D6lPdNorlzjLYX7U9RDPXflRcZZs+4ErD2bQdReT6/K
         3Z8w==
X-Forwarded-Encrypted: i=1; AJvYcCWOayD/Mgc46yihwsz2O7vVe8EvsrCFBtET5/VLutf+cmN02Bb6m5Z8QWJbz/uT/wIFcilqj1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBOa+Cgau+3115G3oaHc7Izo/AvC+iouRe8JLxjCnxWU+K33sF
	9CNQUFJyLlYCCP6QbQUV7TUrFta2jkWldNVEgVAuAsiIOOZatKLVhKY4jPAm1P9FmECuUwskkzO
	ebMSOdvrqK/PywB63N/Gblm6he1UGxSgL5sG8hncb
X-Gm-Gg: ASbGncvJ3Y0pMArQJiinis5GL6Yo1fF4dv2rm0pdV5gqB0UR2/FLkdHm4u1bTwYQ+tK
	R0dbFzpw6UDckwOipOUOq70TpRFMPH+wB2bIXTMkG4QszEdhWmvfmYPE0oEs57fKzCp4PkqwFwB
	+A+G09EUph3NI6kfbStZbu3u3x5V2tTnkl3NJy6uc6cCFlfiH4GahRv9Hpd896
X-Google-Smtp-Source: AGHT+IE5Rdo2+rJoO+MntkgAfh3AGDE0/YaYr5xKepwgWrPQCmQuQyp16WQnYIKaU4pJoL2XM+cnwZSzgGO0Z5SGp6I=
X-Received: by 2002:a50:cd19:0:b0:5fc:a9f0:3d15 with SMTP id
 4fb4d7f45d1cf-5ffce28bb43mr138842a12.1.1747342622880; Thu, 15 May 2025
 13:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-5-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-5-0a1329496c31@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:56:26 +0200
X-Gm-Features: AX0GCFsmCNdRDo8SbhgKUg3UIm_6Yt4H4myWdmQn9E_klnoqzxRp7OxxuDj2C0g
Message-ID: <CAG48ez3-=B1aTftz0srNjV7_t6QqGuk41LFAe6_qeXtXWL3+PA@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] pidfs, coredump: add PIDFD_INFO_COREDUMP
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 12:04=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> Extend the PIDFD_INFO_COREDUMP ioctl() with the new PIDFD_INFO_COREDUMP
> mask flag. This adds the fields @coredump_mask and @coredump_cookie to
> struct pidfd_info.

FWIW, now that you're using path-based sockets and override_creds(),
one option may be to drop this patch and say "if you don't want
untrusted processes to directly connect to the coredumping socket,
just set the listening socket to mode 0000 or mode 0600"...

> Signed-off-by: Christian Brauner <brauner@kernel.org>
[...]
> diff --git a/fs/coredump.c b/fs/coredump.c
> index e1256ebb89c1..bfc4a32f737c 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
[...]
> @@ -876,8 +880,34 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                         goto close_fail;
>                 }
>
> +               /*
> +                * Set the thread-group leader pid which is used for the
> +                * peer credentials during connect() below. Then
> +                * immediately register it in pidfs...
> +                */
> +               cprm.pid =3D task_tgid(current);
> +               retval =3D pidfs_register_pid(cprm.pid);
> +               if (retval) {
> +                       sock_release(socket);
> +                       goto close_fail;
> +               }
> +
> +               /*
> +                * ... and set the coredump information so userspace
> +                * has it available after connect()...
> +                */
> +               pidfs_coredump(&cprm);
> +
> +               /*
> +                * ... On connect() the peer credentials are recorded
> +                * and @cprm.pid registered in pidfs...

I don't understand this comment. Wasn't "@cprm.pid registered in
pidfs" above with the explicit `pidfs_register_pid(cprm.pid)`?

> +                */
>                 retval =3D kernel_connect(socket, (struct sockaddr *)(&ad=
dr),
>                                         addr_len, O_NONBLOCK | SOCK_CORED=
UMP);
> +
> +               /* ... So we can safely put our pidfs reference now... */
> +               pidfs_put_pid(cprm.pid);

Why can we safely put the pidfs reference now but couldn't do it
before the kernel_connect()? Does the kernel_connect() look up this
pidfs entry by calling something like pidfs_alloc_file()? Or does that
only happen later on, when the peer does getsockopt(SO_PEERPIDFD)?

>                 if (retval) {
>                         if (retval =3D=3D -EAGAIN)
>                                 coredump_report_failure("Coredump socket =
%s receive queue full", addr.sun_path);
[...]
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 3b39e471840b..d7b9a0dd2db6 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
[...]
> @@ -280,6 +299,13 @@ static long pidfd_info(struct file *file, unsigned i=
nt cmd, unsigned long arg)
>                 }
>         }
>
> +       if (mask & PIDFD_INFO_COREDUMP) {
> +               kinfo.mask |=3D PIDFD_INFO_COREDUMP;
> +               smp_rmb();

I assume I would regret it if I asked what these barriers are for,
because the answer is something terrifying about how we otherwise
don't have a guarantee that memory accesses can't be reordered between
multiple subsequent syscalls or something like that?

checkpatch complains about the lack of comments on these memory barriers.

> +               kinfo.coredump_cookie =3D READ_ONCE(pidfs_i(inode)->__pei=
.coredump_cookie);
> +               kinfo.coredump_mask =3D READ_ONCE(pidfs_i(inode)->__pei.c=
oredump_mask);
> +       }
> +
>         task =3D get_pid_task(pid, PIDTYPE_PID);
>         if (!task) {
>                 /*
[...]
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index a9d1c9ba2961..053d2e48e918 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
[...]
> @@ -742,6 +743,7 @@ static void unix_release_sock(struct sock *sk, int em=
brion)
>
>  struct unix_peercred {
>         struct pid *peer_pid;
> +       u64 cookie;

Maybe add a comment here documenting that for now, this is assumed to
be used exclusively for coredump sockets.


>         const struct cred *peer_cred;
>  };
>

