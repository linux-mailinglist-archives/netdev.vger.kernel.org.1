Return-Path: <netdev+bounces-196531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A11B1AD5330
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0963A360F
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FA525BEE9;
	Wed, 11 Jun 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVe9xWOg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC19522836C
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639724; cv=none; b=DJbEvMYJk7JZ6qJ22Lwmxh1Yo1glFvokflKCgUidlvLIw9ku1TntjhX7B5CBo2OQxXQiZs1wgFm+ssNO7ke48vvL7FSnf1NAfCrrVmOI+emTx/jnBhhyWd9U+hle7OFPvGXhAGplnASIUsg1whYX3alpDypUn0Dg+osAfeEjI4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639724; c=relaxed/simple;
	bh=mfNuq8qqM9FELM8DMdWpUjS2hDSLNhV5GUILu/F7K0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIUXKXVG/fFDDF5UETNIhOgiEMYTvfI0avLwCjU4zE7ylAtwQ1GF/M2Z/fZ7fl0yQG3+CP9MS1s6fN1OxGftZTV7Cv9jbYplvmEZWYD35MNETU+C+rG/jiN+P7nxU6eQtw28GWlrCmTy2ehYW5TE1McQM/aGARrG0jciL+pbwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVe9xWOg; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a58e0b26c4so105692281cf.3
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 04:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749639722; x=1750244522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEcPA+VcNcYPrTwLHeIWkO1tOdH6aS2HR/j6LYlGc+c=;
        b=dVe9xWOgOiZ6PTkoPsgvCPuUkzsLn+3o7CVibmzDn6+r+FPX8pF7iSTcu6cckiP+eO
         Xo1Fj7edXFNfRyd/DX+xT5mLbmMIceUVDlKfHt/wJUPn4XND0a1tUzZZc5PTY4Gbok6q
         VDRH/mW58F0BeQZc8B/SiTCkLaiwlilgdK1l90z9md/PuXVteMRW1PjOlEqIli2JimSS
         U3Ey2WsqhMrl/+/EyVHnWgvOW978gctUqtE7nYF20VUE3kkae7r0YSXBqWeNwRuj6Ykz
         zG8qI2szSK35sNhNS/49RTdYW/5x/XiJRl+njhknVPlt5Nw1olRj70CJ8KarmZR/hf/w
         8uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749639722; x=1750244522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEcPA+VcNcYPrTwLHeIWkO1tOdH6aS2HR/j6LYlGc+c=;
        b=dVq6Phe3H2uii6amMTIlftANASOSxrNL1gmvYrl+1MS8U1/lpIx5+PSr36TomYYwy7
         AJx2hQisKL8YYmwHTJ8BY8ZtmYnDUGgXY7hg8gGKM58q5nGxMUzChX+wmorb5dhCwmFY
         vWdD7qHmnaoCSInA6EH/ngHjRMoHakcbG6MwJI/6eSagTFCMikrI37PL2lx4RRv07NsO
         BT2MRYHl7D8BpWu5Gf/+EWGdycf8bUjHQtP+HLPM7ns6GIKBl0GO3cu0/KHJhm2Q6Ubz
         hVtXGiduItnnNhAmk5d47Ex6vTUK7ag6vuP5QBuSw6gwDHpXWkkjCjXoPLbx4hiZmJ0S
         7eqA==
X-Forwarded-Encrypted: i=1; AJvYcCXgfb2W7ieC9fOfd8GQ7eV9uSm6Se7dkfmmml60ixVV66+rYbrNpGFgVdIiBUtrdScjectE+AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ35zyoLe9QHsZseXBKwExJvFDU9kCa1EUQ9dGXZAAbYGXPE+b
	W1EfHEc9wfvoc908IWtemUu3+yGv0cLLfJ6zLCp4YZNHX3aQNUvpA3Nq8rZqLQO5E6+JfUtz1My
	lIQDwRKvH1zo4KU4NevoOD37GHbXTwuoT7VPMLvtT
X-Gm-Gg: ASbGncuLoGYK2VVCqTsuudLl9aK2x1v3aIW73yIRu3kkpOzAlkRAFhs0P28z9MiYKy5
	+1RLBPSFxi0DGgwiEb9sxpPL6uJ181KX5mQWP9jXn7T6tDUdo/UWlRIdTmwiNwQ4XaDz4cjah5X
	+ycK++qL09Gj7LFRgh7CctnvaeOjbMy35Jm0Q2ZeXpYvo2+WKnO5eX/xxM2sv0lTY2ypXMdDzs2
	f9zog==
X-Google-Smtp-Source: AGHT+IFfutvVU++UC7xqMGNQ7WfZgZpy5V79rcQFitLlUUVWRRFA+j10eZmo3w8QohWFRPSXjBH1eRj4+AUgum4BQwk=
X-Received: by 2002:a05:622a:5510:b0:4a5:a632:2888 with SMTP id
 d75a77b69052e-4a714dc4634mr44356131cf.47.1749639721115; Wed, 11 Jun 2025
 04:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aElUZyKy7x66X3SD@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <aElUZyKy7x66X3SD@v4bel-B760M-AORUS-ELITE-AX>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Jun 2025 04:01:50 -0700
X-Gm-Features: AX0GCFsfOEhVn8izBxpmPld9_HpI_yCr0g8ZPjlxl8G1e1cjk3xW2-Suqh6wURU
Message-ID: <CANn89iJiLKn8Nb8mnTHowBM3UumJQrwKHPam0JYGfo482DoE-w@mail.gmail.com>
Subject: Re: [PATCH] net/sched: fix use-after-free in taprio_dev_notifier
To: Hyunwoo Kim <imv4bel@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, v4bel@theori.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 3:03=E2=80=AFAM Hyunwoo Kim <imv4bel@gmail.com> wro=
te:
>
> Since taprio=E2=80=99s taprio_dev_notifier() isn=E2=80=99t protected by a=
n
> RCU read-side critical section, a race with advance_sched()
> can lead to a use-after-free.
>
> Adding rcu_read_lock() inside taprio_dev_notifier() prevents this.
>
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Looks good to me, but we need a Fixes: tag and/or a CC: stable@ o make
sure this patch reaches appropriate stable trees.

Also please CC the author of the  patch.

It seems bug came with

commit fed87cc6718ad5f80aa739fee3c5979a8b09d3a6
Author: Vladimir Oltean <vladimir.oltean@nxp.com>
Date:   Tue Feb 7 15:54:38 2023 +0200

    net/sched: taprio: automatically calculate queueMaxSDU based on TC
gate durations




> ---
>  net/sched/sch_taprio.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 14021b812329..bd2b02d1dc63 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -1320,6 +1320,7 @@ static int taprio_dev_notifier(struct notifier_bloc=
k *nb, unsigned long event,
>         if (event !=3D NETDEV_UP && event !=3D NETDEV_CHANGE)
>                 return NOTIFY_DONE;
>
> +       rcu_read_lock();
>         list_for_each_entry(q, &taprio_list, taprio_list) {
>                 if (dev !=3D qdisc_dev(q->root))
>                         continue;
> @@ -1328,16 +1329,17 @@ static int taprio_dev_notifier(struct notifier_bl=
ock *nb, unsigned long event,
>
>                 stab =3D rtnl_dereference(q->root->stab);
>
> -               oper =3D rtnl_dereference(q->oper_sched);
> +               oper =3D rcu_dereference(q->oper_sched);
>                 if (oper)
>                         taprio_update_queue_max_sdu(q, oper, stab);
>
> -               admin =3D rtnl_dereference(q->admin_sched);
> +               admin =3D rcu_dereference(q->admin_sched);
>                 if (admin)
>                         taprio_update_queue_max_sdu(q, admin, stab);
>
>                 break;
>         }
> +       rcu_read_unlock();
>
>         return NOTIFY_DONE;
>  }
> --
> 2.34.1
>

