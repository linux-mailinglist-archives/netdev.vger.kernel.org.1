Return-Path: <netdev+bounces-88072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 717CA8A5928
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 19:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10571F229E3
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2FB84D39;
	Mon, 15 Apr 2024 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGCp7Sza"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E98284A5A
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713202395; cv=none; b=a3LlBOgNYhGF3weit2o6Rsa/hARvd8i6I4eHEIlP7LQQpK6oHafd8WLCzpiukk5w1BTfRUClaUD3neAB0dWACCJtAtmhPFB9MU43e3qdS7nR+3UICi5/MPDV9RqmxVFV8ZzAxFsAMxsxOugI09ulvlUaoQMZpVZacFNnEcrGijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713202395; c=relaxed/simple;
	bh=fVy4/qxgl9tInqx5RaGpJ8jCmmUJpdjjrYyl5Pd0ifA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJEPeNHJMTLvLPHj14S64MziCKOdAFaULPS8aeQGJzpRcxzdWQIQAhSBKNWLXQZkN28Sm//3JeWJr7106ac7EglQ3th0Ows4N0QjDBNhbxqZs6DjjIcvR0w66mCSl9n4yxyI5XlcAZMTXo5EUfvKEKgJxdpcjf2RO9efl3/pZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGCp7Sza; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so1125a12.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 10:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713202393; x=1713807193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSr3+keZEEUpgLhE9iNBG2D84pBypL07nhs/T7aX3QY=;
        b=rGCp7SzaJVlwzvqiNF2K5FRm9MQZD0PmwK6/X1uH2hRCsksW8bOmxPaO+sOh7rali9
         hrLFFFTk9XPOWpmFy6+4vVtPkc5Kszc+Mu77XcWMmQ4RBli4VWgcOEmFAE5n/dJnY9vl
         Uzq39WspCHq1NUK7phqfr7XtexyhWvvYzYolv0gLELXvJs3cg+3ljsm93Rs0QyLmH3Z1
         WgRMrn1GVTZXEYmkfaYSIn8Sl0KKx4XXK9t+ccjIqBAC5OzRYJ0EghqYkULjesOJOFAe
         XK8mRSTAHeVaUaKWJAad8TBCqBPxA5GHvYG5friSyYWStlBV1zfk+f7v+CEMXF+55Oaf
         +OiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713202393; x=1713807193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSr3+keZEEUpgLhE9iNBG2D84pBypL07nhs/T7aX3QY=;
        b=HIvQILhkGi6gfB5iVCVpNwzfjV25FHmpvcdMMGC3XQ6S+gSTsxjGYL7mmUltZzbuJD
         N47ghJiel2ixs3ckOWbGiz2nBYEg4CO35dFZGWfTlmwCnYwRYt55M+BFDmrKqZPQf2N1
         KDCCgTVk7aR5kRqVogG+AhKMvtGpndNGrcM4ERihkvpl99Ty27c6LwZsZSx9UqYKnJ86
         Brhq8Ykqa6PfD5xY37PmVXtZxxysDdI4g8UOdT0A1iTi44E+ttOv1cizKhA2fPx/1xDQ
         E3fdld95CVwXBYNxlthuHUTA2mGpXrAl9M9+XFS+aYU6cXtHfN2V7vK5/EcaDeiKuBgu
         Cu+A==
X-Forwarded-Encrypted: i=1; AJvYcCVzrzQhhGjzWgxjDsSoud2tMLlVlg283VYXef6URyKECHtcYZje073pxDdeUXf9DvhlBmawc2dx6/BG34JUp8xmbXTTND+g
X-Gm-Message-State: AOJu0YyQbXv8cdb22HCLWf/RJPlVoDgHknVt2OV6fjz9YZwGoAgTDhRv
	n7970ssGZSqivBra4/Mrr8ubqBLF9gjou6vo4fspb1gEXv1d5oA7emS2XmE85VFVZD9gfmynpf4
	WqzuWGYbgkdukCG4xf22GUCw7N0DNpC9pBZGS
X-Google-Smtp-Source: AGHT+IH810ux34EZKW9Uz3R3oXi/ZuIa3p05Bogdhvu55oIUMngGKz41OARjPzCxIdf/U/1GeyegG2SYZudPeI/Lqns=
X-Received: by 2002:aa7:d3da:0:b0:570:25a1:7671 with SMTP id
 o26-20020aa7d3da000000b0057025a17671mr2746edr.2.1713202392702; Mon, 15 Apr
 2024 10:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415160619.8249-1-jain.abhinav177@gmail.com>
In-Reply-To: <20240415160619.8249-1-jain.abhinav177@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Apr 2024 19:33:01 +0200
Message-ID: <CANn89i+7OrEtM18hPjfjnZ9wf04KJ2NQsKDAV5dVwPV2UYwsPA@mail.gmail.com>
Subject: Re: [PATCH] inet: inet_defrag: Removing the usage of refcount_inc_not_zero
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 6:06=E2=80=AFPM Abhinav Jain <jain.abhinav177@gmail=
.com> wrote:
>
> Remove refcount_inc_not_zero as per the listed TODO in the file.
> Used spin_(un)lock and refcount_* functions for synchronization.
>
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  net/ipv4/inet_fragment.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
> index c88c9034d630..e4838bbe0abb 100644
> --- a/net/ipv4/inet_fragment.c
> +++ b/net/ipv4/inet_fragment.c
> @@ -358,7 +358,6 @@ static struct inet_frag_queue *inet_frag_create(struc=
t fqdir *fqdir,
>         return q;
>  }
>
> -/* TODO : call from rcu_read_lock() and no longer use refcount_inc_not_z=
ero() */
>  struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key)
>  {
>         /* This pairs with WRITE_ONCE() in fqdir_pre_exit(). */
> @@ -375,8 +374,14 @@ struct inet_frag_queue *inet_frag_find(struct fqdir =
*fqdir, void *key)
>                 fq =3D inet_frag_create(fqdir, key, &prev);
>         if (!IS_ERR_OR_NULL(prev)) {
>                 fq =3D prev;
> -               if (!refcount_inc_not_zero(&fq->refcnt))
> +               spin_lock(&fq->lock);
> +               if (refcount_read(&fq->refcnt) > 0) {
> +                       refcount_inc(&fq->refcnt);
> +                       spin_unlock(&fq->lock);
> +               } else {
> +                       spin_unlock(&fq->lock);
>                         fq =3D NULL;
> +               }
>

This is bogus. I do not think you understood the comment.

