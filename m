Return-Path: <netdev+bounces-190724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4567EAB87D0
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CF89E14C6
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDECB7262E;
	Thu, 15 May 2025 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="SkNwMkB+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC361548C
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747315314; cv=none; b=iyINSJcvU4eVYwZ5q44c8OjgAAgqt4v7AF2G9/veUedhFz/FKw/vOGYMk3NAsH9qVqhdpkMxgkDo77xqyFw/7ckoO7TNrYZ7Ed6ODymSJ2BfLrxhtIVTO8D+q2rMChoRZ6ugLhStIQdR1Y/rh1FJzyDx3e9DXofIZBNiSf9Tsdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747315314; c=relaxed/simple;
	bh=0qwJq3bQ4wZzZYyMLfyzoU+4N0UDYrslGD8tXICI3XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCksuAFUKJbv4S9R+Vf/8lim9plxBU7bRBUnaFRuACgkxg2UC5i0IQrRS5uqm8LfeW09WT5kZIlCMX1E+/lrGEIvnZYtIMKguY9l6LFvk/OIN1x8+0pv+MEzUHwbdH10p94YiLJ8Y46IRXnHypfU320zmNBU9/VfFRQHsFo4Kno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=SkNwMkB+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso958516e87.3
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1747315310; x=1747920110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9/0rLioWunSkOUNMsdKO2DuQooK8T/s9++j3a8KFy8Q=;
        b=SkNwMkB+Ld8aOJ1zwEvD7G20w+oLfIBQZjVrSF0U0npzWMVl5Lb5L4zNS//3wHIQIS
         bQehNUOAed52zmdlWCt3ZElD6ZbIK3rBLyUFMzvAYiBRSEitwe/79UFo84je7XSeYhBK
         UxS1cve7qTB6g9tYKaKpDXxII6DAXvlQkEQ5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747315310; x=1747920110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/0rLioWunSkOUNMsdKO2DuQooK8T/s9++j3a8KFy8Q=;
        b=hmbmgLY32hVj+eyDoPbSXZ4tpR56Lms4U6yBT/uOilgFsefGUXe2Fxv+6X+TqIvpwV
         G5HKN4pkB2GbKyKV1FSrETY01Jkff69b6ts4VPeJJC/ZvtvruArBqn53gxCRsQsDyqH9
         QH5AfACEPrQet0LC+J2UK19R+xkMMIfDVKnh1Sg7h8GyFbW9RpprSEzkvnR2t13zOdNn
         lCvFd02lWKfL9Ufg3/rJdZJkoATb+vKXIBapbTg+0Jrutf2IfunOAzpM45alF48Vxu4h
         Gwjk5WvE6Q+8/Oo4eo6DwN5jqwCwMxinZUJuLcdC+WpxfV9Mi2DI/5Kke9m1NoiSyv4y
         EdzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbYwLWGGaLNoWy8ZTQOgq/vBMXeOwvN5vKHAYvB4TuFKdD5YMZjK1Od+8T2Jo4yVTB45C+FYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTnAlicZUYdKU/2+vg3g+5QKKpabPr5f2b3tNYU/chSSYQN7H3
	jhgyNZUIutDn72Kq/n31Rux8LOIk4M2U9X9EaVIjJYaI7aHmSWvDE04MtJFr3ORd+f+VAoTBbbR
	l4v2icjCXopU0Lvr9LdE8pvNv4n7zY6dAx5AIXglnMPj0DNkWDSVPFURl
X-Gm-Gg: ASbGncvEq7+p+Ixaw7948T/ztwKOoqYenVQFLl/UWWMpFnZ0lF9V/Qo/78eVx4hWXAj
	at/+7oTq+6BToGsWTuZqHZSSqsdrrrXLYmF+NL/UZl8uwIVxneZeYfKNTxOepgqpOV/Om+H6ut9
	DsSp40thNE8nIKYYv8TrUZoISeurPNaXZUrhEymKJlHoA4
X-Google-Smtp-Source: AGHT+IFsP3ydWrJ83abQUqhyxXRR8VIad8vuhq9qo8X9+orqDhs7UiCFmfG5cRgOacMsA7cZGJHNLHHILRRTmcZZ8a4=
X-Received: by 2002:a05:6512:6c4:b0:54f:c57d:d25 with SMTP id
 2adb3069b0e04-550d61ddbe6mr2771666e87.48.1747315298977; Thu, 15 May 2025
 06:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-2-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-2-0a1329496c31@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 15 May 2025 15:21:27 +0200
X-Gm-Features: AX0GCFtZbZz82-8yLUwL6JXmvjJbvTtiMA_mPveEttmh8tJJN9Z9Kzc8Qdt9YDU
Message-ID: <CAJqdLrqrVWV_iHG+f51fRZ=JKLeu9jSd_7i5BQ=zCu9FFPjiog@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] coredump: massage do_coredump()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Do., 15. Mai 2025 um 00:04 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> We're going to extend the coredump code in follow-up patches.
> Clean it up so we can do this more easily.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/coredump.c | 122 +++++++++++++++++++++++++++++++---------------------------
>  1 file changed, 65 insertions(+), 57 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 368751d98781..0e97c21b35e3 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -646,63 +646,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                 goto fail_unlock;
>         }
>
> -       if (cn.core_type == COREDUMP_PIPE) {
> -               int argi;
> -               int dump_count;
> -               char **helper_argv;
> -               struct subprocess_info *sub_info;
> -
> -               if (cprm.limit == 1) {
> -                       /* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
> -                        *
> -                        * Normally core limits are irrelevant to pipes, since
> -                        * we're not writing to the file system, but we use
> -                        * cprm.limit of 1 here as a special value, this is a
> -                        * consistent way to catch recursive crashes.
> -                        * We can still crash if the core_pattern binary sets
> -                        * RLIM_CORE = !1, but it runs as root, and can do
> -                        * lots of stupid things.
> -                        *
> -                        * Note that we use task_tgid_vnr here to grab the pid
> -                        * of the process group leader.  That way we get the
> -                        * right pid if a thread in a multi-threaded
> -                        * core_pattern process dies.
> -                        */
> -                       coredump_report_failure("RLIMIT_CORE is set to 1, aborting core");
> -                       goto fail_unlock;
> -               }
> -               cprm.limit = RLIM_INFINITY;
> -
> -               dump_count = atomic_inc_return(&core_dump_count);
> -               if (core_pipe_limit && (core_pipe_limit < dump_count)) {
> -                       coredump_report_failure("over core_pipe_limit, skipping core dump");
> -                       goto fail_dropcount;
> -               }
> -
> -               helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
> -                                           GFP_KERNEL);
> -               if (!helper_argv) {
> -                       coredump_report_failure("%s failed to allocate memory", __func__);
> -                       goto fail_dropcount;
> -               }
> -               for (argi = 0; argi < argc; argi++)
> -                       helper_argv[argi] = cn.corename + argv[argi];
> -               helper_argv[argi] = NULL;
> -
> -               retval = -ENOMEM;
> -               sub_info = call_usermodehelper_setup(helper_argv[0],
> -                                               helper_argv, NULL, GFP_KERNEL,
> -                                               umh_coredump_setup, NULL, &cprm);
> -               if (sub_info)
> -                       retval = call_usermodehelper_exec(sub_info,
> -                                                         UMH_WAIT_EXEC);
> -
> -               kfree(helper_argv);
> -               if (retval) {
> -                       coredump_report_failure("|%s pipe failed", cn.corename);
> -                       goto close_fail;
> -               }
> -       } else if (cn.core_type == COREDUMP_FILE) {
> +       switch (cn.core_type) {
> +       case COREDUMP_FILE: {
>                 struct mnt_idmap *idmap;
>                 struct inode *inode;
>                 int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW |
> @@ -796,6 +741,69 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                 if (do_truncate(idmap, cprm.file->f_path.dentry,
>                                 0, 0, cprm.file))
>                         goto close_fail;
> +               break;
> +       }
> +       case COREDUMP_PIPE: {
> +               int argi;
> +               int dump_count;
> +               char **helper_argv;
> +               struct subprocess_info *sub_info;
> +
> +               if (cprm.limit == 1) {
> +                       /* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
> +                        *
> +                        * Normally core limits are irrelevant to pipes, since
> +                        * we're not writing to the file system, but we use
> +                        * cprm.limit of 1 here as a special value, this is a
> +                        * consistent way to catch recursive crashes.
> +                        * We can still crash if the core_pattern binary sets
> +                        * RLIM_CORE = !1, but it runs as root, and can do
> +                        * lots of stupid things.
> +                        *
> +                        * Note that we use task_tgid_vnr here to grab the pid
> +                        * of the process group leader.  That way we get the
> +                        * right pid if a thread in a multi-threaded
> +                        * core_pattern process dies.
> +                        */
> +                       coredump_report_failure("RLIMIT_CORE is set to 1, aborting core");
> +                       goto fail_unlock;
> +               }
> +               cprm.limit = RLIM_INFINITY;
> +
> +               dump_count = atomic_inc_return(&core_dump_count);
> +               if (core_pipe_limit && (core_pipe_limit < dump_count)) {
> +                       coredump_report_failure("over core_pipe_limit, skipping core dump");
> +                       goto fail_dropcount;
> +               }
> +
> +               helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
> +                                           GFP_KERNEL);
> +               if (!helper_argv) {
> +                       coredump_report_failure("%s failed to allocate memory", __func__);
> +                       goto fail_dropcount;
> +               }
> +               for (argi = 0; argi < argc; argi++)
> +                       helper_argv[argi] = cn.corename + argv[argi];
> +               helper_argv[argi] = NULL;
> +
> +               retval = -ENOMEM;
> +               sub_info = call_usermodehelper_setup(helper_argv[0],
> +                                               helper_argv, NULL, GFP_KERNEL,
> +                                               umh_coredump_setup, NULL, &cprm);
> +               if (sub_info)
> +                       retval = call_usermodehelper_exec(sub_info,
> +                                                         UMH_WAIT_EXEC);
> +
> +               kfree(helper_argv);
> +               if (retval) {
> +                       coredump_report_failure("|%s pipe failed", cn.corename);
> +                       goto close_fail;
> +               }
> +               break;
> +       }
> +       default:
> +               WARN_ON_ONCE(true);
> +               goto close_fail;
>         }
>
>         /* get us an unshared descriptor table; almost always a no-op */
>
> --
> 2.47.2
>

