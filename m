Return-Path: <netdev+bounces-102368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E5A902BAB
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322AC1F21E74
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2821514F2;
	Mon, 10 Jun 2024 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qOsuBHUx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DB91514CC
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058520; cv=none; b=Exk2PY0e1sBVRmUJgpN7/sG9vjYQELnzdHkKlMtCsDBEeBIdh/Hb5e7SFihjkLYRfWGMRssXi1lMaDcu6c/pewkGGQsZcL4eFfnQ3FEgOfcCGw33VZIATWeaPenscfUr9P/6wPXPWo+u6JvfqkkJAYq03Mdy6VYekA63btvPX6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058520; c=relaxed/simple;
	bh=//h+SQzpQEpDtNpeBuStauUMjF/1FnjkWddWusmEJoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDWm1DXfE3f7gOA7hnYxNleg8OTf1C3UnWxzfrhEZ5dbf4oueDVZFXu/goqWI9audldaQSir54+jTkOOD7FrcEmrOlxGDds46bkwYlby7ltpI2bPFjGOhM7UD63jm4zBOrgNwKdVTzL0AyvS8hGjYKAFeimp2sAER4JMytVORAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qOsuBHUx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f61742a024so66505ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718058518; x=1718663318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CltNPHp24X0YdbNxXIq1nZmVRV43NqFIhiiPqMk86LI=;
        b=qOsuBHUxVv7JdC0fC1XPGmTCR1Gr/Yb2Fmt1DMNtBp7B299EnwZ0ABmihyCpphO9Di
         5gs5C71Jok9EIQb3+NZ4XXSit4ZHgvUgKeInWrr8BthF4wqhHzGWsC+oGH6YjQrWqO9J
         yjNehOoyoSZ3FdX80UnKtZ4TGx1CFX33e4I+9UOPSTNofxFAYieRE6ihQYOChBriInAX
         imNZECoYSUB/0d8U9WTu7Jaf/jXfiQ3pqzf7nuRdNh8YIhXvB37Ulf/+bP3abRRBVtBn
         L2jx7uRYMycBsMX1IfCBpU0ETM58P3Kqitx2/vlDPMyfz/RxDavOp9+iDB4OnnstaFMo
         /zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058518; x=1718663318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CltNPHp24X0YdbNxXIq1nZmVRV43NqFIhiiPqMk86LI=;
        b=Rr9WapBElkybjVHtGoExdIZ7/+gmdhFM5lqhEayK10CJwkWZZ7ZCl2VZFagffibfs1
         X++kBshwgUEInR3nCsJJ3ZrUxEGseZsM7qAIidE0vZGbqyHLTq1VUu8DHvk/haZq8XpA
         hGEBlRtC0c2MdoSEL28rB3kBajPYJOWq5/YormIqoZHjKTp36N6dTJBpeYBc3fg6e0s5
         luBmnlZMC3CBwHhLreoUrG9vXqXpLtEv/KLRa6+pJlkccguCg2yBmWvQf5zvzSAxJr2l
         I+RI+XOqIxKuc+CptdFqN7lJMCeLPDMVq2JJ9LW2kzbSd+MoSNS6vl9bD+076n9mJDo1
         ENNg==
X-Forwarded-Encrypted: i=1; AJvYcCUG2m5ZxSaqO/6T+l/0YHFxN9KQDQn+8guKutnklvI/GFSjzllMmd9NWcHZrIDutAsCFTatYquqLlLfFVHHLMFTu+/es+e0
X-Gm-Message-State: AOJu0YysDZZopu1gT/y6nBKqwK+w4IAcdpi+6p9gztB/iOmFuoitXDr+
	KdKJHQpKe+sDJkw4hXFQPjRBX4yXaQF+KBowxJuGuBYYSudR6Bdou7Xn29eaY2JaVNdYRtSTMk9
	9z43K5yZbE4TlvDwyocPiMq8VZBAcRsQcWQgE
X-Google-Smtp-Source: AGHT+IG5DxgTD1WhUH3nJ9EmVhkKot+5sCCwTEAuekdiSfrw+FdsqlljtFn9AaT3xI8iDYGmH91HNrjaFh3g24AwBas=
X-Received: by 2002:a17:902:6acc:b0:1f6:7fce:5684 with SMTP id
 d9443c01a7336-1f72f726f4amr440435ad.3.1718058517742; Mon, 10 Jun 2024
 15:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000>
In-Reply-To: <ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000>
From: Jann Horn <jannh@google.com>
Date: Tue, 11 Jun 2024 00:27:58 +0200
Message-ID: <CAG48ez3NvVnonOqKH4oRwRqbSOLO0p9djBqgvxVwn6gtGQBPcw@mail.gmail.com>
Subject: Re: [PATCH v3] landlock: Add abstract unix socket connect restriction
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, outreachy@lists.linux.dev, netdev@vger.kernel.org, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

Thanks for helping with making Landlock more comprehensive!

On Fri, Jun 7, 2024 at 1:44=E2=80=AFAM Tahera Fahimi <fahimitahera@gmail.co=
m> wrote:
> Abstract unix sockets are used for local inter-process communications
> without on a filesystem. Currently a sandboxed process can connect to a
> socket outside of the sandboxed environment, since landlock has no
> restriction for connecting to a unix socket in the abstract namespace.
> Access to such sockets for a sandboxed process should be scoped the same
> way ptrace is limited.

This reminds me - from what I remember, Landlock also doesn't restrict
access to filesystem-based unix sockets yet... I'm I'm right about
that, we should probably at some point add code at some point to
restrict that as part of the path-based filesystem access rules? (But
to be clear, I'm not saying I expect you to do that as part of your
patch, just commenting for context.)

> Because of compatibility reasons and since landlock should be flexible,
> we extend the user space interface by adding a new "scoped" field. This
> field optionally contains a "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to
> specify that the ruleset will deny any connection from within the
> sandbox to its parents(i.e. any parent sandbox or non-sandbox processes)

You call the feature "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET", but I
don't see anything in this code that actually restricts it to abstract
unix sockets (as opposed to path-based ones and unnamed ones, see the
"Three types of address are distinguished" paragraph of
https://man7.org/linux/man-pages/man7/unix.7.html). If the feature is
supposed to be limited to abstract unix sockets, I guess you'd maybe
have to inspect the unix_sk(other)->addr, check that it's non-NULL,
and then check that `unix_sk(other)->addr->name->sun_path[0] =3D=3D 0`,
similar to what unix_seq_show() does? (unix_seq_show() shows abstract
sockets with an "@".)

Separately, I wonder if it would be useful to have another mode for
forbidding access to abstract unix sockets entirely; or alternatively
to change the semantics of LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET so
that it also forbids access from outside the landlocked domain as was
discussed elsewhere in the thread. If a landlocked process starts
listening on something like "@/tmp/.X11-unix/X0", maybe X11 clients
elsewhere on my system shouldn't be confused into connecting to that
landlocked socket...

[...]
> +static bool sock_is_scoped(struct sock *const other)
> +{
> +       bool is_scoped =3D true;
> +       const struct landlock_ruleset *dom_other;
> +       const struct cred *cred_other;
> +
> +       const struct landlock_ruleset *const dom =3D
> +               landlock_get_current_domain();
> +       if (!dom)
> +               return true;
> +
> +       lockdep_assert_held(&unix_sk(other)->lock);
> +       /* the credentials will not change */
> +       cred_other =3D get_cred(other->sk_peer_cred);
> +       dom_other =3D landlock_cred(cred_other)->domain;
> +       is_scoped =3D domain_scope_le(dom, dom_other);
> +       put_cred(cred_other);

You don't have to use get_cred()/put_cred() here; as the comment says,
the credentials will not change, so we don't need to take another
reference to them.

> +       return is_scoped;
> +}

