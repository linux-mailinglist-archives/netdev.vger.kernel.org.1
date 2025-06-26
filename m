Return-Path: <netdev+bounces-201398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F190AE948C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 05:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B6B3BCEEA
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 03:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8C515689A;
	Thu, 26 Jun 2025 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ft0CKFTf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD82143C61
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750908731; cv=none; b=YQjyKtmrx4pd9j4vDM9g3XZQ6ulwVwYbk7S2aW8pbJDPE+B/7Lu/9+I2lSnTIFQfUtW2dAriiGYwmQbYXvHirzlT8r5+stGISQqy2W9ObFHjKE+Z8IiVaaaAD3CGAwzkQN/p575AdSaaDZb0FxahOEs1F5nKm+5T1XV49twKk/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750908731; c=relaxed/simple;
	bh=KQQLZPykY0DQhg4C2afSEMhGY2FfRe/jFAwSIUCvE0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDYTS6RnPJNss8ewKaWYg/aEBOcjj7pwQThFOJ/MwOcnuyjY40O4WrBH0nOaXTaVXHJ9sXLbKenpdUE3pE/vDHxy1/wNSLWTU6upvILAdn+ohGhEKDGhbpyWHncw9ZB2OMqF/pIBF7094n6Zm9PNz8r1dncoqiJH8o56t5JPUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ft0CKFTf; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a7f46f9bb6so4118171cf.3
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 20:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750908728; x=1751513528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAR0KhNmSTLdc5IlLyk3RFNMjr4Z74Gp1ztOJmXzAWY=;
        b=Ft0CKFTfZ9pf06gHiicScPmwYOyJNDnXBTXfgwOXeR68otILi4uItke38Tt6N1hZE0
         ZIOS4bcQueekbvUfqgwbMDA6hFwF/nzA6HGVGK6LTYmG9/QSFnL4fGr3rv5TrK7xdXKe
         ZiOgoUWTPPy9nDiatywPZ2fOhyRnn5xJyzi90RcyMtHG1Fqd9Vgt5gt4KgMr6YozDkrh
         IeZtr9P4mQeDDA1Dx5RPgfL3nA98R9Zz4YpUQxOvrONDQLH7+vtLYN96iTNiSeg+S7zU
         J8nOUkQ6e4H1Vuts9yNbsB3tKIU5cgnRvqBh5Lskfc5OEmR/FHLndnflTKFlotJQdR8N
         kbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750908728; x=1751513528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAR0KhNmSTLdc5IlLyk3RFNMjr4Z74Gp1ztOJmXzAWY=;
        b=EjjfPqNpY6Qx2UyAgTKgRIrdux0eXUuTp/qQCp8hM7G7wJxY4lxSMQcr4+h4MVQCRo
         7yUB9kqJ0Nn+8hvVpZ7CX+RMdoQvKV9XEFBQXUErhOoXSkH57PEE6gGy8DHmFCOR1RPY
         zLV2+apM9ZAyjg3DgKfkpGe7WI1bn67+X1YddYPf2pg6j67p5DDDiUi7RkGETSOev+sS
         JFxOdBRvwXlouXWWlzmvgrH8HfPakBUEg1ppyVvjNiIN8I/mi9lVrit5egCCHrk9fuNe
         /xSO35MmyvNJGKaCAP2qY2Ss7X1YF6G8ZFTNKOKm8IcrTay0vi0mUYXLwi6j2iObnbKh
         r9wA==
X-Forwarded-Encrypted: i=1; AJvYcCXp5cTRtMl81CoheKltm5dBkgh1+Y9m/HNtyY6tRi6JH9s20XlMuhy1JO1uPpTI0n32R8IyURI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDqtJ+jwoXCleJv8187CzxT/Fk6sHFfMKd8CddpZlo8bbzxswp
	pOqyqpVeGBqGgP7KP+vAuXUYFsNL8sFGvOSWwDZo+SisVfzm7Cir8KagbJuf3BOl3OLmBOwJK6R
	iFizz7yVVQucg5bZ8Otl9LBxnBje8cv57qheDpsA1
X-Gm-Gg: ASbGnct/lo/UvvfMMoc7bZR+30mumZ555a2PrpA5WjKa5baHa1TqqekcKiOz+x2av6F
	QCIEGbs8RcYMjmMidOc4MvtXa/QSbajW9KxYuSg5a1k604IH9h1hMWfigUQjf7+d9rWfiKJmKMp
	UG9N+3PQ8RdWpb18r5mI/FQg1bn7wC+mSpOH5hlez2qKo=
X-Google-Smtp-Source: AGHT+IF5c6/Ffr2ZlLmLBLEa9u4updyjaW2akXYsbGKR25gVnGjqxApkMKJsmYID0ISi/gUvyJzJuGiVPCpD1WS7pr8=
X-Received: by 2002:ac8:7dc8:0:b0:4a6:f546:e157 with SMTP id
 d75a77b69052e-4a7c05f4af1mr104663651cf.4.1750908728324; Wed, 25 Jun 2025
 20:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625135210.2975231-1-daniel.zahka@gmail.com> <20250625135210.2975231-9-daniel.zahka@gmail.com>
In-Reply-To: <20250625135210.2975231-9-daniel.zahka@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Jun 2025 20:31:57 -0700
X-Gm-Features: Ac12FXzKd3gDVaQ1V8FammYEd0oPsY3K68S8oXKynx0DuIWEVVe_GbwPyQrZ9qs
Message-ID: <CANn89iKvLQ3jZ8fYwRiBHo-PmSKbhwujWpjFUKtRYANGaPk70g@mail.gmail.com>
Subject: Re: [PATCH v2 08/17] net: psp: add socket security association code
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Boris Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>, 
	Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 6:52=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Add the ability to install PSP Rx and Tx crypto keys on TCP
> connections. Netlink ops are provided for both operations.
> Rx side combines allocating a new Rx key and installing it
> on the socket. Theoretically these are separate actions,
> but in practice they will always be used one after the
> other. We can add distinct "alloc" and "install" ops later.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
> +/**
> + * psp_assoc_put() - release a reference on a PSP association
> + * @pas: association to release
> + */
> +void psp_assoc_put(struct psp_assoc *pas)
> +{
> +       if (pas && refcount_dec_and_test(&pas->refcnt))
> +               call_rcu(&pas->rcu, psp_assoc_free_queue);
> +}
> +
> +void psp_sk_assoc_free(struct sock *sk)
> +{
> +       rcu_read_lock();

This is a writer side.

rcu_read_lock() here is wrong, and only silences lockdep.

Use instead rcu_dereference_protected(sk->psp_assoc,
whatever_assert_making_sure_we_are_under_some_protection_against_another_wr=
iter);

The condition can be 1 if we are in a sk dismantle point, otherwise
lockdep_sock_is_held(sk) is often used.


> +       psp_assoc_put(rcu_dereference(sk->psp_assoc));
> +       rcu_assign_pointer(sk->psp_assoc, NULL);
> +       rcu_read_unlock();
> +}

