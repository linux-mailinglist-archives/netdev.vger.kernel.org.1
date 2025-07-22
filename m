Return-Path: <netdev+bounces-209033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48065B0E0D7
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F14540BE4
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD788279DAB;
	Tue, 22 Jul 2025 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0xA+kf0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38D5279903
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198922; cv=none; b=Ra70nccxiFh5rT52pmZMugD+x/h2bKQwC8SoRJ/IbE8eYQg/+ZOBf27eNUhOw75wEXFb1BX/BjpOaHKD0nA8ylXiil/DB1F39K4bMJj1pPru9kXa/yOOUfwVMPxnI57j4zkVQdJNxOQo5DzMyPDQXEOQHLhluEt0Ov7SiKsSG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198922; c=relaxed/simple;
	bh=g9EEklXk902C8ofxuE8rx2WBA3m7abatvb7woZ+cMsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WG5WiJjuAa5+oDpNfxJzC3qt1J7LhnJOO/FKpUerqw6EpraPCu/nU7NmU4MfkMiruy+JRy1/Put0fCSUi+vhZWZZMnhy0oQJpUs9GWnHAY0ZrWChzGPSsV0QClJio9OYu3KvJCW4T9ndVXkWz1pE/drniZa7cQ8WjzHGdeMh8EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0xA+kf0; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab8e2c85d7so78749391cf.2
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 08:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753198920; x=1753803720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qBHdKmYPMFtPjBkykZtOEGhLmANMjG/wOtN6adOqo0=;
        b=k0xA+kf0W/hi+5CA7OXgy3ZpOEekh2tL9D+GJo1GQ4Y3lRXv7TSXsVvWc/6ArmOj9I
         ARyAMZazO20Ia515EQQDXKA+Q3Ft+9Nla+8yIBy4iPlAKiU5oLDIfSyDRWqASNPQ2C+N
         eAXL8SGPGTGO6/wvK0joh7s7p7+CyIAFhhDhwk6QyNywcWdXJzUZ4qq+MADDWZiSreXY
         IO2kQKmQkvs9s5ze0XxY7gHQHIv9yFqNSoEnBOGZshTzLn+tn+S5dbPbGZQwCf49+q/4
         hi18z/07g7nbhNEnNoufmvHpFQ9qqu1rfrJzGP94LAznzVFJgX4Kgm/ff4GZkuKVWDSM
         +0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753198920; x=1753803720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qBHdKmYPMFtPjBkykZtOEGhLmANMjG/wOtN6adOqo0=;
        b=AyBiefvQUotSOq2W5BkCh0mwf5PzDMpqfLNG2xAVkIZx/oBrH8eUHbROawp/zzI1aS
         kh6og01ORyaeD2BFlWGj4yafNMNeg7rvA1PW9S/1XEim4zagGbBLf4MHRqDC5zQqQBtg
         gG9u07uJRT+4OvTWady876BNMXwMMsG1avEJz0lf7gqgjbWcVRq9lJ6GKuP/W8gJjMiI
         TgFCq9J4LqD+Bi3zIvpjNxqE/XUtOI88DvXDkOrKfnAP4w4u56MUSq4zOagg/SrMiqp6
         avI3UUO/c6tJl+nCUu6SSEEd7oV1I4q0dZk0aQb3HhhfNAcRGaYVgCVkZdbGTgVtazV3
         s7+w==
X-Forwarded-Encrypted: i=1; AJvYcCV6ySY5UuFS+X5UTg2ZNhpjK4uyunlcZQzitshfm3DsJq4L8tPZxTR/R71b87/4DvTLUPAA5N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkERvV2wW83fujaoqdU/3Hvs9U4fO+PCuecf8IKDOKzMDA50sa
	vs0mWOHQwI3kFScuuYcmLGGCDAGOc/QmFZE5F+Li98+Uw6ssg3t1j/fF67sdOYPwAT5LnFkECLA
	rJuaZ+8HXxYpY7jPWzvQ9ZIXonC2JRToz3EFTO62/
X-Gm-Gg: ASbGnctlqJ9Kg+g8BMBv0C4zxYwlvGkSU4RHXCDRi75waLn0GsIPt9fau/hs0KEd77j
	hNj8AZCDwT3JxH9DYYxb/P6ICOFAnAE908xnJQ824hYI7Ew7WFFSMGyoI1dUrHir7lzo60wvleS
	ESbzFTc1vXaWsPw7LSTu/4HNGyI0Swb2BfssAdF/W7PJljNqCFAcI3BItjz4SGOuWkZ36cfhHGV
	t/wwg==
X-Google-Smtp-Source: AGHT+IFz3i1EtapV0IvQfMG2OwnY161D0xKDC7JwKfOL7HxpCFq49fqtCqXRwaiQlIgHTAbfGBWChoDUfHIlflY9Vnw=
X-Received: by 2002:a05:622a:190c:b0:4ab:3ff6:f0e9 with SMTP id
 d75a77b69052e-4ab93c430f7mr382067691cf.1.1753198919441; Tue, 22 Jul 2025
 08:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071508.12497-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20250722071508.12497-1-suchitkarunakaran@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 08:41:48 -0700
X-Gm-Features: Ac12FXwxZbJIBYib8fr6Oyem19af1On_m2X-wW_EUa_K4ODkvuxy53heJa_cUR8
Message-ID: <CANn89iJgG3yRQv+a04wzUtgqorSOM3DOFvGV2mgFV8QTVFjYxg@mail.gmail.com>
Subject: Re: [PATCH] net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, sdf@fomichev.me, 
	kuniyu@google.com, aleksander.lobakin@intel.com, netdev@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 12:15=E2=80=AFAM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> When changing the tx queue length via dev_qdisc_change_tx_queue_len(),
> if one of the updates fails, the function currently exits
> without rolling back previously modified queues. This can leave the
> device and its qdiscs in an inconsistent state. This patch adds rollback =
logic
> that restores the original dev->tx_queue_len and re-applies it to each pr=
eviously
> updated queue's qdisc by invoking qdisc_change_tx_queue_len() again.
> To support this, dev_qdisc_change_tx_queue_len() now takes an additional
> parameter old_len to remember the original tx_queue_len value.
>
> Note: I have built the kernel with these changes to ensure it compiles, b=
ut I
> have not tested the runtime behavior, as I am currently unsure how to tes=
t this
> change.
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  include/net/sch_generic.h |  2 +-
>  net/core/dev.c            |  2 +-
>  net/sched/sch_generic.c   | 12 +++++++++---
>  3 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 638948be4c50..a4f59df2982f 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -681,7 +681,7 @@ void qdisc_class_hash_remove(struct Qdisc_class_hash =
*,
>  void qdisc_class_hash_grow(struct Qdisc *, struct Qdisc_class_hash *);
>  void qdisc_class_hash_destroy(struct Qdisc_class_hash *);
>
> -int dev_qdisc_change_tx_queue_len(struct net_device *dev);
> +int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int o=
ld_len);
>  void dev_qdisc_change_real_num_tx(struct net_device *dev,
>                                   unsigned int new_real_tx);
>  void dev_init_scheduler(struct net_device *dev);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index be97c440ecd5..afa3c5a9bba1 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9630,7 +9630,7 @@ int netif_change_tx_queue_len(struct net_device *de=
v, unsigned long new_len)
>                 res =3D notifier_to_errno(res);
>                 if (res)
>                         goto err_rollback;
> -               res =3D dev_qdisc_change_tx_queue_len(dev);
> +               res =3D dev_qdisc_change_tx_queue_len(dev, orig_len);
>                 if (res)
>                         goto err_rollback;
>         }
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 16afb834fe4a..701dfbe722ed 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -1445,7 +1445,7 @@ void mq_change_real_num_tx(struct Qdisc *sch, unsig=
ned int new_real_tx)
>  }
>  EXPORT_SYMBOL(mq_change_real_num_tx);
>
> -int dev_qdisc_change_tx_queue_len(struct net_device *dev)
> +int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int o=
ld_len)
>  {
>         bool up =3D dev->flags & IFF_UP;
>         unsigned int i;
> @@ -1456,12 +1456,18 @@ int dev_qdisc_change_tx_queue_len(struct net_devi=
ce *dev)
>
>         for (i =3D 0; i < dev->num_tx_queues; i++) {
>                 ret =3D qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
> -
> -               /* TODO: revert changes on a partial failure */
>                 if (ret)
>                         break;
>         }
>
> +       if (ret) {
> +               dev->tx_queue_len =3D old_len;

WRITE_ONCE() is missing.

> +               while (i >=3D 0) {
> +                       qdisc_change_tx_queue_len(dev, &dev->_tx[i]);

What happens if one of these calls fails ?

I think a fix will be more complicated...

