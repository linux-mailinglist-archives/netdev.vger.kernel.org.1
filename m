Return-Path: <netdev+bounces-190735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DB1AB88DC
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B1A1BC39F4
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51CE1ACEAC;
	Thu, 15 May 2025 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="Z72aYsf6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62ED1A9B5B
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317845; cv=none; b=S/EaJ8X1AOvI8pAJSNtDNPkX3403F5gVV8PLAATYXlDtg9c9lOmaeSbX12XmpIh2TswDS+vAkF+s/MNhqA05iEr7yjw0/HffGv/prgwxc+vWRzie7eU7JQqSWDnnsh3HiC7MZBSiKo/V4xsYnW+9GT0RU6/+Pg6YCylB2/MVkLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317845; c=relaxed/simple;
	bh=DsRj+jneIY2sA6r65luroD5vKWTeHga6pT4b93go548=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3WgE+sdv0dLm8dWylYDcU2viA3QEdGtK53ncn19Z+kEEhQdRT5XZyxJAnW8aGWpX6YjWT6c0rIupRVkFFGedr1o/K54xoVm+5jeKM7KAijAFiFJLkc5k1RJ/tTdV11w+7IELW7Qv3NYJ1yhYuVT+eVCGlRho1ZUHV7bx85NcwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=Z72aYsf6; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54e816aeca6so1257124e87.2
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1747317842; x=1747922642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d35JeSz60cGLvBbWCEkXPoHFgobJD8TSYk4oLoUb8Jc=;
        b=Z72aYsf6Ur4NaGzBtnAtynfQr3+i9KM4Xnp1WCWPuNIHQUDl16SIHxXORgRmGZ9qhl
         xepheZq23ouhWZRD1IEywpYuaz5sGdHufi7p0sidQAmuoeAFfHQkxlUyZnrLaRbYkcrN
         49ktLs39h8GK+f1MT4bXn7454rnhG6EXOylKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747317842; x=1747922642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d35JeSz60cGLvBbWCEkXPoHFgobJD8TSYk4oLoUb8Jc=;
        b=tpSud+brr/M53RkGpY+xFztDi7EFvPF99ITYfr7DQgjVN2g8JuT074qOvG+s59GyeY
         73axsyEuazVRxnnwlDGCdTTnBtH5KQxKkPvOM/psiTBv+OdXoR6d8rPAP5V4m9OJFHdl
         fd41dwKeJdLifRvujNekXLkoy3GnFhYlbPX0fKwDVgCSTIdn1tmqz+vuu8+1LEv9i1JV
         ZC21UYtyqikor3w50uD53+5EjChMkDUj0rCvxV1yfyq4NClEDLhgqSW9Hb3sFpbTpZyg
         Faibnnj6I6XIZDQGfy/hF/1Gm/qKJMa5fWeVzaeQnvcJ0Acko67ezYm71EPFGGrIee3b
         UKyw==
X-Forwarded-Encrypted: i=1; AJvYcCVSpop5X+RdxrFzKbP44N/HjS23tn9RysdSM0AlUysjevs4GBChdbiGmgRkge9LEZhwYR4Ck2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpDLAOKAGStcsyAdqz4D28kq5f4eeukQEdMdTvonEJqS2csc9x
	1mO/UJNC/x4Rvj9n4OTPvURmldabkUYS+hnJ7sKd72RA37l9sAFOZ8ZtHLfgYRax/ZwdliU3jHF
	UQj+ArN+FH0VipM1JQ9SyvChoughDt/YmLG2wTQ==
X-Gm-Gg: ASbGncvwS5/lsJ8ZZGDEw+jTlls674QdVpy9gdSQ3LZBXzEdB0mUNoHemWRnKGOvUPB
	0JJ/bVwgday128n85o1np65xy2I69SUDV3NeN1Ah6H0AjWXqgdYBq4ZoPODAToZFoxn+9k87M9W
	/EQFz6eso78N7JvtuSQTchdhVDdXGOk7r6boDeFLnMHvRW
X-Google-Smtp-Source: AGHT+IFL9ojUwqLTPuSTYsHfs2cnzH8sa00mdSfBUjswRLfNB8BX2UwMPe5/nMKCpf2uCx4jaw02E7zhcwzkR4jIXnc=
X-Received: by 2002:a05:6512:2618:b0:54e:86f3:5e54 with SMTP id
 2adb3069b0e04-550d5fae056mr2628304e87.5.1747317840276; Thu, 15 May 2025
 07:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-7-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-7-0a1329496c31@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 15 May 2025 16:03:49 +0200
X-Gm-Features: AX0GCFsHLEGADAYqPdli5zm43751kHI-Zre11GNAREbwlvpOpR_Hl8TIVXvYN_M
Message-ID: <CAJqdLroQx3v-xD279phQB1ToF70T-2cAbAA0SC-nbnAK+EHGmA@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] coredump: validate socket name as it is written
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
> In contrast to other parameters written into
> /proc/sys/kernel/core_pattern that never fail we can validate enabling
> the new AF_UNIX support. This is obviously racy as hell but it's always
> been that way.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/coredump.c | 37 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 6ee38e3da108..d4ff08ef03e5 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1228,13 +1228,44 @@ void validate_coredump_safety(void)
>         }
>  }
>
> +static inline bool check_coredump_socket(void)
> +{
> +       if (core_pattern[0] != '@')
> +               return true;
> +
> +       /*
> +        * Coredump socket must be located in the initial mount
> +        * namespace. Don't give the that impression anything else is
> +        * supported right now.
> +        */
> +       if (current->nsproxy->mnt_ns != init_task.nsproxy->mnt_ns)
> +               return false;
> +
> +       /* Must be an absolute path. */
> +       if (*(core_pattern + 1) != '/')
> +               return false;
> +
> +       return true;
> +}
> +
>  static int proc_dostring_coredump(const struct ctl_table *table, int write,
>                   void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -       int error = proc_dostring(table, write, buffer, lenp, ppos);
> +       int error;
> +       ssize_t retval;
> +       char old_core_pattern[CORENAME_MAX_SIZE];
> +
> +       retval = strscpy(old_core_pattern, core_pattern, CORENAME_MAX_SIZE);
> +
> +       error = proc_dostring(table, write, buffer, lenp, ppos);
> +       if (error)
> +               return error;
> +       if (!check_coredump_socket()) {
> +               strscpy(core_pattern, old_core_pattern, retval + 1);
> +               return -EINVAL;
> +       }
>
> -       if (!error)
> -               validate_coredump_safety();
> +       validate_coredump_safety();
>         return error;
>  }
>
>
> --
> 2.47.2
>

