Return-Path: <netdev+bounces-189337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BA0AB1A9F
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 18:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9555C3B8B85
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212CE2356B9;
	Fri,  9 May 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="RnX2XLF3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA2B21A931
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746808588; cv=none; b=LEr0fAeGNQzOKGJ7MvpPZ5NHR7MyuaHm52Jy6OUqWyOgU2sa/n5pJGCVud8rPT6uobW+RhR4+NZMQKONSW4no+DtcjHMyJH+BXAUCfX3Fu7jZVhZ3CoCtM0/CdU14bt2F/dxUElf+qrjvabs8mC0GmV/5qDagzZlbNAMannD1QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746808588; c=relaxed/simple;
	bh=SElwm06j+DlRR4yCYm42BAqEpJ3JJLetNH0N75LAQZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEYTvB3RJdI29E6g/dKmQ6xg/vnzcJbjqpk8Lw25iO4h1zrwnjHUwusscS/4X0gkrZ3JN0DAeaiIDB9QyfjZU76eRTNqCqPr0td/mdR/ArqxizICN2jyltfTrPEsUkRKbFvXcfkL+6Qo9WkuxC16y7DSfvyY7XfNFVRta6nNr5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=RnX2XLF3; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3104ddb8051so23593071fa.1
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1746808584; x=1747413384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zzddh/3eTx6uQ05Z0QrC85lC2xnXc5MveRhZzr/KB1o=;
        b=RnX2XLF3idIdiYQEzvbzFqoxqPfoUkyCGUvSprCsOfMac+aFEygT0GMtuUavCNaxbH
         O9cSRPZVRrzJbBpVj9swKkcgOhcFRQl/wqoTiHHS2Hg7sQC3pRDfiNl3iRv//aAvF+ZM
         UFsdaCtIzqcJS0WoTGfZ/bC9Yswobjm1AwIx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746808584; x=1747413384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zzddh/3eTx6uQ05Z0QrC85lC2xnXc5MveRhZzr/KB1o=;
        b=OUh8zxfAMTR/BX1JklLy/xkGmUedMZSqDUogjTYsR0c4Ip0LbC8ue88uVtFdqEvGpP
         pOEPakL/euMHEdUomxpr/LFY8ZDsbHDnxJtwe0HsVkY+w2RdlxrRA0nSGVUlj2zkNOEj
         EJkc6NKTqrjv7F4pfKo/rkFc/ajFIYIURScj3RhGqjImfAcPMjSxF4gDXlqC0vZ0ic60
         IPqNqNB5GOuIyUUfPHJYkS2rCUP76iiVUA6U4rhPxF8OaKI8GfBE3Jsk/xJJjkA9+6Tn
         VE1TtTwYNx/EhgBolAweHxUdsw5OVsbbsnV6myQ8ssB/yONaK5Hk6QYGxgmZtf/5uxbv
         n2GA==
X-Forwarded-Encrypted: i=1; AJvYcCV4jChJNDEdqBqLZH7P76Px36/mkRVSJe5NAbyYDfg2L9vhDS6DLMB4IKtk6lpl7SmJBmTq3Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOUN0uXtlQy7UcPpdj7KXqe34bbCyYmeEKONM2YoZGg8I1ZqUh
	qQyYCTfVuqW5XvCf0lQUEdg+LANsQMM348p7FjnFeSxvlHBA4Mmj9e9OJ5uwMbxWEkEuAXJmwmb
	PHRVfll4f10N4V60WBqrLfkbbQ2k8fmfLDnFnkg==
X-Gm-Gg: ASbGnctw2AEyC0H7dvl4G9Y5uNENBCrv5vR8JIDvDEFg+IxJzgdGge67zokHlUrymR/
	J5leZD5jFx8FWsbI2Sm+IHjGppxVHWgDDFxhe+/Elb66Ch/1uvdj965aEMA9J1W1oMXrXA0BrAg
	V9wRh5F3EyBNtK/aeUmEqT+zQ=
X-Google-Smtp-Source: AGHT+IH+OGShjApAd9yBXoPzGyz7erva33bTf7tcbh9TZCZv8N/0Z47UJruRu0/G2XeKDRmeA7pJn36NDyQUl8d5EeY=
X-Received: by 2002:a05:651c:210a:b0:30d:b25d:72d0 with SMTP id
 38308e7fff4ca-326c457585amr16758911fa.17.1746808583777; Fri, 09 May 2025
 09:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org> <20250509-work-coredump-socket-v5-3-23c5b14df1bc@kernel.org>
In-Reply-To: <20250509-work-coredump-socket-v5-3-23c5b14df1bc@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 9 May 2025 18:36:11 +0200
X-Gm-Features: AX0GCFvUuqDpuhS2JQ9T3QaKQJ6V58kyD4zcgQGwY68-T7tQ-lOHd3RNIb0VEdI
Message-ID: <CAJqdLrotSo_3gdq-eQhiBiA6Y76DV_Vi9x1sTZNjz97PZc=6PA@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] coredump: reflow dump helpers a little
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

Am Fr., 9. Mai 2025 um 12:26 Uhr schrieb Christian Brauner <brauner@kernel.org>:
>
> They look rather messy right now.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/coredump.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 41491dbfafdf..b2eda7b176e4 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -867,10 +867,9 @@ static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
>         struct file *file = cprm->file;
>         loff_t pos = file->f_pos;
>         ssize_t n;
> +
>         if (cprm->written + nr > cprm->limit)
>                 return 0;
> -
> -
>         if (dump_interrupted())
>                 return 0;
>         n = __kernel_write(file, addr, nr, &pos);
> @@ -887,20 +886,21 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
>  {
>         static char zeroes[PAGE_SIZE];
>         struct file *file = cprm->file;
> +
>         if (file->f_mode & FMODE_LSEEK) {
> -               if (dump_interrupted() ||
> -                   vfs_llseek(file, nr, SEEK_CUR) < 0)
> +               if (dump_interrupted() || vfs_llseek(file, nr, SEEK_CUR) < 0)
>                         return 0;
>                 cprm->pos += nr;
>                 return 1;
> -       } else {
> -               while (nr > PAGE_SIZE) {
> -                       if (!__dump_emit(cprm, zeroes, PAGE_SIZE))
> -                               return 0;
> -                       nr -= PAGE_SIZE;
> -               }
> -               return __dump_emit(cprm, zeroes, nr);
>         }
> +
> +       while (nr > PAGE_SIZE) {
> +               if (!__dump_emit(cprm, zeroes, PAGE_SIZE))
> +                       return 0;
> +               nr -= PAGE_SIZE;
> +       }
> +
> +       return __dump_emit(cprm, zeroes, nr);
>  }
>
>  int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
>
> --
> 2.47.2
>

