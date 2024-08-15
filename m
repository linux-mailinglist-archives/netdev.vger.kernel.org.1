Return-Path: <netdev+bounces-118971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE3A953B66
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 22:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1616286F86
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEFC1494C7;
	Thu, 15 Aug 2024 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ID8BNhMO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A7F1465A3
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723753557; cv=none; b=rktCXs7CNuLzi49cD4XFSf7Av0In3qgYRPqjugrZ8t/41AFkI6eIBQTv46dxud3+3GIwvzVwzR7V0kuxUEP5xqu4CzQDRKFkKy63BcZTSSr/ZoNBq05+euT1ECas+GpsRCiHvpakhI26005xTt3H49S2qSCO2zsTIbU6pZt0I3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723753557; c=relaxed/simple;
	bh=YAJU5FXFJWul5IBRO+xgbMm+u28pgF2I2YVoq8F/x7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6Z3BSv0jwFrJZcpAnu0DDsHkctoGfJXsZFVYVGfq4Gj85TwnDcDDTR5X9bXDBrxmdejZgn/oHoxU0n52jlpJ8Y69vrzhBeQZ9mHTf5/gaZ23bCWfsz+xpTupMZJZeZKsb5HOtj+KjA2VsRgwR4m4dHJciJKKVpLkEsX5LNqjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ID8BNhMO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bebb241fddso332a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 13:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723753554; x=1724358354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGBFlGgZ7VtdNdOp2YXWEF9NLY36Dieaz09krWWwzbA=;
        b=ID8BNhMOSXOQpxkxo20k3fZPIzyAOjUmYrwl0zDj2l09MDoc3TNK2WqghNV52+hRrR
         2aoQ1n6ziQcVf+u4LvUnEme4YVl4NnrP7qAqwtPO5C9pLjKGyOH6HNkOfvCLYtjinViK
         SqZ5o6VMYdo7OmnT8N+sPNqzqmJSCLi4uPyYkwEUbM6I/MPUV4m1aDHe22XfpSfQRaNL
         oN7XwWFjak61VoQPXt7kHxR6H69xkjedtVOMCmjO8yMeunPiWI8ATD+a5Sg+0jxU5crh
         y/AGYFmt3iAMJDhD79owgL+Qspy2TEpVUxOlZSJ1tw3jt5i7Y0vxc/aJp85FxoHAqO6q
         jhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723753554; x=1724358354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGBFlGgZ7VtdNdOp2YXWEF9NLY36Dieaz09krWWwzbA=;
        b=Ap9962QMxfYBajWp/bcfrtloMpsO/VVKymXQbyHBl326wbXFzMJ6hJrKnJjZONdyZs
         Wobk5djBKdYfzC20nYBKT2D2gkjyf+9XM3YZNoLyxZwVTxx7CEoCCt0uqftijuRjcXwP
         Du4PSbvY7Gy4M3mgUNcjtjUSJZufC9Y16DOOyOX059oTTvDkazQwMi5N+eOarYLP22aW
         uG9ExTvvzljRQUMxyDxIVkJ6XLdPl6etjbCQ8SfCFKGWZ3q+o84DircPJBnYBU6OiBlT
         pJ7HShl2WnMEADAwmn/w+b6sejozjR+vq4gn8lNH8Ub2x8marXSPSUoR0ixkxSdyA6OX
         K7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWbv6uwAaO4/2u8YuHqqBrxO1J03md4Q1jYD90osWfJ7LsNWnp52fKqeO29K88lWRqlFNct2Si289eOndHrAiWHBwga4h1A
X-Gm-Message-State: AOJu0Yx2BJlZw0rY0vYO9eadKNnfASp2cNuORQuJI31nQesV4mAAbmKE
	pC/EBQApQbd4SZxNRIYzBVgP6wZ6WKFpPJvwnhn95mnsJxjo2u4r3FEO0M/Iteb7+vF57ULbNkP
	wBK0ctmTmHIIVWR50yR9sqg82c9KdvY66lgID
X-Google-Smtp-Source: AGHT+IHW5fNrRqjmAxt5DnpIwzQVwF2s/Lpn7NEkdzTAcCzAlgn22XdfKmFmZSjDvwO/Heip3bPeXDyJhSVfcONpWDs=
X-Received: by 2002:a05:6402:4407:b0:58b:93:b624 with SMTP id
 4fb4d7f45d1cf-5becd683a30mr323a12.1.1723753551916; Thu, 15 Aug 2024 13:25:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723680305.git.fahimitahera@gmail.com> <d04bc943e8d275e8d00bb7742bcdbabc7913abbe.1723680305.git.fahimitahera@gmail.com>
In-Reply-To: <d04bc943e8d275e8d00bb7742bcdbabc7913abbe.1723680305.git.fahimitahera@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 Aug 2024 22:25:15 +0200
Message-ID: <CAG48ez2Sw0Cy3RYrgrsEDKyWoxMmMbzX6yY-OEfZqeyGDQhy9w@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] Landlock: Adding file_send_sigiotask signal
 scoping support
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, mic@digikod.net, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 8:29=E2=80=AFPM Tahera Fahimi <fahimitahera@gmail.c=
om> wrote:
> This patch adds two new hooks "hook_file_set_fowner" and
> "hook_file_free_security" to set and release a pointer to the
> domain of the file owner. This pointer "fown_domain" in
> "landlock_file_security" will be used in "file_send_sigiotask"
> to check if the process can send a signal.
>
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
>  security/landlock/fs.c   | 18 ++++++++++++++++++
>  security/landlock/fs.h   |  6 ++++++
>  security/landlock/task.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+)
>
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 7877a64cc6b8..d05f0e9c5e54 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1636,6 +1636,21 @@ static int hook_file_ioctl_compat(struct file *fil=
e, unsigned int cmd,
>         return -EACCES;
>  }
>
> +static void hook_file_set_fowner(struct file *file)
> +{
> +       write_lock_irq(&file->f_owner.lock);

Before updating landlock_file(file)->fown_domain, this hook must also
drop a reference on the old domain - maybe by just calling
landlock_put_ruleset_deferred(landlock_file(file)->fown_domain) here.

> +       landlock_file(file)->fown_domain =3D landlock_get_current_domain(=
);
> +       landlock_get_ruleset(landlock_file(file)->fown_domain);
> +       write_unlock_irq(&file->f_owner.lock);
> +}
> +
> +static void hook_file_free_security(struct file *file)
> +{
> +       write_lock_irq(&file->f_owner.lock);
> +       landlock_put_ruleset(landlock_file(file)->fown_domain);
> +       write_unlock_irq(&file->f_owner.lock);
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init =3D {
>         LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
>
> @@ -1660,6 +1675,9 @@ static struct security_hook_list landlock_hooks[] _=
_ro_after_init =3D {
>         LSM_HOOK_INIT(file_truncate, hook_file_truncate),
>         LSM_HOOK_INIT(file_ioctl, hook_file_ioctl),
>         LSM_HOOK_INIT(file_ioctl_compat, hook_file_ioctl_compat),
> +
> +       LSM_HOOK_INIT(file_set_fowner, hook_file_set_fowner),
> +       LSM_HOOK_INIT(file_free_security, hook_file_free_security),
>  };
>
>  __init void landlock_add_fs_hooks(void)
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> index 488e4813680a..6054563295d8 100644
> --- a/security/landlock/fs.h
> +++ b/security/landlock/fs.h
> @@ -52,6 +52,12 @@ struct landlock_file_security {
>          * needed to authorize later operations on the open file.
>          */
>         access_mask_t allowed_access;
> +       /**
> +        * @fown_domain: A pointer to a &landlock_ruleset of the process =
own
> +        * the file. This ruleset is protected by fowner_struct.lock same=
 as
> +        * pid, uid, euid fields in fown_struct.
> +        */
> +       struct landlock_ruleset *fown_domain;
>  };
>
>  /**
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 9de96a5005c4..568292dbfe7d 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -18,6 +18,7 @@
>
>  #include "common.h"
>  #include "cred.h"
> +#include "fs.h"
>  #include "ruleset.h"
>  #include "setup.h"
>  #include "task.h"
> @@ -261,12 +262,38 @@ static int hook_task_kill(struct task_struct *const=
 p,
>         return 0;
>  }
>
> +static int hook_file_send_sigiotask(struct task_struct *tsk,
> +                                   struct fown_struct *fown, int signum)
> +{
> +       struct file *file;
> +       bool is_scoped;
> +       const struct landlock_ruleset *dom, *target_dom;
> +
> +       /* struct fown_struct is never outside the context of a struct fi=
le */
> +       file =3D container_of(fown, struct file, f_owner);
> +
> +       read_lock_irq(&file->f_owner.lock);
> +       dom =3D landlock_file(file)->fown_domain;
> +       read_unlock_irq(&file->f_owner.lock);

At this point, the ->fown_domain pointer could concurrently change,
and (once you apply my suggestion above) the old ->fown_domain could
therefore be freed concurrently. One way to avoid that would be to use
landlock_get_ruleset() to grab a reference before calling
read_unlock_irq(), and drop that reference with
landlock_put_ruleset_deferred() before exiting from this function.

> +       if (!dom)
> +               return 0;
> +
> +       rcu_read_lock();
> +       target_dom =3D landlock_get_task_domain(tsk);
> +       is_scoped =3D domain_is_scoped(dom, target_dom, LANDLOCK_SCOPED_S=
IGNAL);
> +       rcu_read_unlock();
> +       if (is_scoped)
> +               return -EPERM;
> +       return 0;
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init =3D {
>         LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
>         LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
>         LSM_HOOK_INIT(unix_stream_connect, hook_unix_stream_connect),
>         LSM_HOOK_INIT(unix_may_send, hook_unix_may_send),
>         LSM_HOOK_INIT(task_kill, hook_task_kill),
> +       LSM_HOOK_INIT(file_send_sigiotask, hook_file_send_sigiotask),
>  };
>
>  __init void landlock_add_task_hooks(void)
> --
> 2.34.1
>

