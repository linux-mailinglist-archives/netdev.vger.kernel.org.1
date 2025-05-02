Return-Path: <netdev+bounces-187470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D945CAA7474
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 16:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7064E3720
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCB9256C8A;
	Fri,  2 May 2025 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KCfaLU10"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3B254876
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746194713; cv=none; b=g6BReqyXeSbeWxtINXVu7aPus4F1KrkODVO9rZfgufphTFT3bEdrH1riSGVSrjmWH06qgcsM4WHd7Dz7oRTnA3gr2zhJYWWpUxY1pve0cFMtpDbHexMSNQr+f0Z37JjpE7BCzl+voJOMTUVR+txV6xFFHYh+LEZVhMymtRFPgCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746194713; c=relaxed/simple;
	bh=u3bCcvNuqwsKSKUwyi8x1R/rJebyJfXEs0GloV4+rzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4Er+88ITAHeVkCnGeoKsZjtZdWtfYBL8zoxUM6fSnlyMO/i3ZcYUShlmBftiYCTPW4qfJ+22g8nGNxHIufVSKCMJDd1a5PTgp7TeX4iLMyGMtZSNdpUM0+5xzLAvp9v2USF8SCxW5DpwvLEvVpSakpEGKkcABxqCARQh5lqhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KCfaLU10; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so10928a12.0
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746194709; x=1746799509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIUkLEuO/0R6FFK/5E6ascv0dB5aqKKlLkCLuO+aNpk=;
        b=KCfaLU10xRMqbHREUYrJKzO6l9byY3YKXP+U4AwoHmmlI0vY5ifnKznttHivHx0Wir
         753GXVnkeUG0R+1XkuGj7FSZqwqN9SsHF98L/zYxxE4bfDv9g+wrxmhk8TvUFUqAmH0G
         fhCQSjQKHkIoymrF9Qv5zVBaSqeweq5P66u+40rpto6Hu2jZOPc78/4+1ERuQvieaaSA
         NeNt279zwpq0RtSk5VtvdtY3KVGhvVLUm2cbDabfjYAzdhqcrt6+92A2W5ncic1Gyjv8
         DP2o08WF3wLcgOejsB+rZtuwumUOPLqqdRXhVy8Ep5wuEJcv+GzA9rl809vxhL1URdcf
         4E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746194709; x=1746799509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIUkLEuO/0R6FFK/5E6ascv0dB5aqKKlLkCLuO+aNpk=;
        b=YMPW/QAsJXeSzNQarq3hnzIOj2U5l2naVxweTkPdJKGaWO+giJOT2FG7/DVWRyd6b8
         iRUqdMgP1DrCPBhVvJ/2EfuMwAPQtpO4lVQ6FyZ7OXBQgylQ2RLNm/LVHJKTaDos9nUk
         InXHc0flfTO8TJf2IHTLHp2K9C8LI9bT7EKYbYwKMbkHJKfbZEYV/qyYCijTO7b/Hfox
         lC/STrF5rhEr+UWRIzZQi5Xrcm2KxtJREmDOWFzliZqY0W/ccXfPk7T46oGZ1GeGPy+G
         cuSTlsJIto2LfrcPLON0egWVrOX7ZMwBv9HGRXscXGZhv4ImvB7WIRrEWn0HKwYcBNdV
         c4cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKWrUzfvP5/2VjjIIh2pyPNbJoBUrnDaqbmp9Jw48YzkIx6llLLmmc/dvS96axZgRvKSKwxBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRFunOYF9ChBzkzBGxvUpEC6jqH4q9Ov9vFzQjI2GvDU54IWrU
	ermfYxZJykO/VAXUblEG612dOmI62eyMXL/sS7eLZo1lfhslEmfQ0wendBbTDpmmvgONPTdAPrX
	uFHJu5Mg2ElO/P98r0mll743MA/mLBnJJrxhi
X-Gm-Gg: ASbGncvUF1VjSn1bW8kbTyRCMSGGZ6+Sj8ZhHTKq2LrgcKk3oEoquyCcl6/VKOKL8oe
	8drqqbLVTuE8cn8hKoUGY299b5LkudODQUka+Yan05oPOhDWqSuvOi+SkuNPToIYbeijCL2qIpD
	fyiEGV6rbAirpL/rQUftTiyC6/twSJLy8INcHVH9kyranAmt8/2Q==
X-Google-Smtp-Source: AGHT+IH079h8T97+GdbfLlz4ZTQu0SIeE7/FcxZKXrGaki/lyIvv7PFx+pafXehKr4vx1Hbtav8zz1kPAxAFy1FP/mk=
X-Received: by 2002:a50:c018:0:b0:5f7:f888:4cb5 with SMTP id
 4fb4d7f45d1cf-5f918c08662mr174264a12.1.1746194708830; Fri, 02 May 2025
 07:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org> <20250502-work-coredump-socket-v2-3-43259042ffc7@kernel.org>
In-Reply-To: <20250502-work-coredump-socket-v2-3-43259042ffc7@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 May 2025 16:04:32 +0200
X-Gm-Features: ATxdqUHMFraIA12GhTqlpB1U5cC0A5UkJsNTEJvN5fJ5qnYj4W9vpCcDcDr5py4
Message-ID: <CAG48ez1w+25tbSPPU6=z1rWRm3ZXuGq0ypq4jffhzUva9Bwazw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/6] coredump: support AF_UNIX sockets
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 2:42=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> diff --git a/fs/coredump.c b/fs/coredump.c
[...]
> @@ -801,6 +841,73 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                 }
>                 break;
>         }
> +       case COREDUMP_SOCK: {
> +               struct file *file __free(fput) =3D NULL;
> +#ifdef CONFIG_UNIX
> +               ssize_t addr_size;
> +               struct sockaddr_un unix_addr =3D {
> +                       .sun_family =3D AF_UNIX,
> +               };
> +               struct sockaddr_storage *addr;
> +
> +               /*
> +                * TODO: We need to really support core_pipe_limit to
> +                * prevent the task from being reaped before userspace
> +                * had a chance to look at /proc/<pid>.
> +                *
> +                * I need help from the networking people (or maybe Oleg
> +                * also knows?) how to do this.
> +                *
> +                * IOW, we need to wait for the other side to shutdown
> +                * the socket/terminate the connection.
> +                *
> +                * We could just read but then userspace could sent us
> +                * SCM_RIGHTS and we just shouldn't need to deal with
> +                * any of that.
> +                */

I don't think userspace can send you SCM_RIGHTS if you don't do a
recvmsg() with a control data buffer?

> +               if (WARN_ON_ONCE(core_pipe_limit)) {
> +                       retval =3D -EINVAL;
> +                       goto close_fail;
> +               }
> +
> +               retval =3D strscpy(unix_addr.sun_path, cn.corename, sizeo=
f(unix_addr.sun_path));
> +               if (retval < 0)
> +                       goto close_fail;
> +               addr_size =3D offsetof(struct sockaddr_un, sun_path) + re=
tval + 1,
> +
> +               file =3D __sys_socket_file(AF_UNIX, SOCK_STREAM, 0);
> +               if (IS_ERR(file))
> +                       goto close_fail;
> +
> +               /*
> +                * It is possible that the userspace process which is
> +                * supposed to handle the coredump and is listening on
> +                * the AF_UNIX socket coredumps. This should be fine
> +                * though. If this was the only process which was
> +                * listen()ing on the AF_UNIX socket for coredumps it
> +                * obviously won't be listen()ing anymore by the time it
> +                * gets here. So the __sys_connect_file() call will
> +                * often fail with ECONNREFUSED and the coredump.

Why will the server not be listening anymore? Have the task's file
descriptors already been closed by the time we get here?

(Maybe just get rid of this comment, I agree with the following
comment saying we should let userspace deal with this.)

> +                * In general though, userspace should just mark itself
> +                * non dumpable and not do any of this nonsense. We
> +                * shouldn't work around this.
> +                */
> +               addr =3D (struct sockaddr_storage *)(&unix_addr);
> +               retval =3D __sys_connect_file(file, addr, addr_size, O_CL=
OEXEC);

Have you made an intentional decision on whether you want to connect
to a unix domain socket with a path relative to current->fs->root (so
that containers can do their own core dump handling) or relative to
the root namespace root (so that core dumps always reach the init
namespace's core dumping even if a process sandboxes itself with
namespaces or such)? Also, I think this connection attempt will be
subject to restrictions imposed by (for example) Landlock or AppArmor,
I'm not sure if that is desired here (since this is not actually a
connection that the process in whose context the call happens decided
to make, it's something the system administrator decided to do, and
especially with Landlock, policies are controlled by individual
applications that may not know how core dumps work on the system).

I guess if we keep the current behavior where the socket path is
namespaced, then we also need to keep the security checks, since an
unprivileged user could probably set up a namespace and chroot() to a
place where the socket path (indirectly, through a symlink) refers to
an arbitrary socket...

An alternative design might be to directly register the server socket
on the userns/mountns/netns or such in some magic way, and then have
the core dumping walk up the namespace hierarchy until it finds a
namespace that has opted in to using its own core dumping socket, and
connect to that socket bypassing security checks. (A bit like how
namespaced binfmt_misc works.) Like, maybe userspace with namespaced
CAP_SYS_ADMIN could bind() to some magic UNIX socket address, or use
some new setsockopt() on the socket or such, to become the handler of
core dumps? This would also have the advantage that malicious
userspace wouldn't be able to send fake bogus core dumps to the
server, and the server would provide clear consent to being connected
to without security checks at connection time.

> +               if (retval)
> +                       goto close_fail;
> +
> +               /* The peer isn't supposed to write and we for sure won't=
 read. */
> +               retval =3D  __sys_shutdown_sock(sock_from_file(file), SHU=
T_RD);
> +               if (retval)
> +                       goto close_fail;
> +
> +               cprm.limit =3D RLIM_INFINITY;
> +#endif
> +               cprm.file =3D no_free_ptr(file);
> +               break;
> +       }
>         default:
>                 WARN_ON_ONCE(true);
>                 retval =3D -EINVAL;
> @@ -818,7 +925,10 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                  * have this set to NULL.
>                  */
>                 if (!cprm.file) {
> -                       coredump_report_failure("Core dump to |%s disable=
d", cn.corename);
> +                       if (cn.core_type =3D=3D COREDUMP_PIPE)
> +                               coredump_report_failure("Core dump to |%s=
 disabled", cn.corename);
> +                       else
> +                               coredump_report_failure("Core dump to :%s=
 disabled", cn.corename);
>                         goto close_fail;
>                 }
>                 if (!dump_vma_snapshot(&cprm))
> @@ -839,8 +949,25 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                 file_end_write(cprm.file);
>                 free_vma_snapshot(&cprm);
>         }
> -       if ((cn.core_type =3D=3D COREDUMP_PIPE) && core_pipe_limit)
> -               wait_for_dump_helpers(cprm.file);
> +
> +       if (core_pipe_limit) {
> +               switch (cn.core_type) {
> +               case COREDUMP_PIPE:
> +                       wait_for_dump_helpers(cprm.file);
> +                       break;
> +               case COREDUMP_SOCK: {
> +                       /*
> +                        * TODO: Wait for the coredump handler to shut
> +                        * down the socket so we prevent the task from
> +                        * being reaped.
> +                        */

Hmm, I'm no expert but maybe you could poll for the POLLRDHUP event...
though that might require writing your own helper with a loop that
does vfs_poll() and waits for a poll wakeup, since I don't think there
is a kernel helper analogous to a synchronous poll() syscall yet.

> +                       break;
> +               }
> +               default:
> +                       break;
> +               }
> +       }
> +
>  close_fail:
>         if (cprm.file)
>                 filp_close(cprm.file, NULL);

