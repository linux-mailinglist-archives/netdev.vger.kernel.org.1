Return-Path: <netdev+bounces-72140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D80C856B19
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2888F1F22FDA
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C99712DD9A;
	Thu, 15 Feb 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="b1I078Gn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B913699E
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018435; cv=none; b=Mo9KsBFRPV2bKW8mQJIZTAJ7qJXiTh6fJHT8z5X6RKp41EDNAxbUXJjx3uaubUAKrcFfKUgYPTHBwz04qdZ/oZEiJzyrfJ34tu5j+hyudm115sFFsKbw9cUHefGZpssaTS66xwRbQtMgE8sRmA6WAHjBSFJ3XG30F1JwxhUo0R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018435; c=relaxed/simple;
	bh=Es5Mtj9anf+Xiu2Ppa/44Ozp6TT+PZenEPAhFcBFnnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eX718wP1VSEMAl20djk5hh1OiVTOhoKgKvz23yj4JluIvX2vMsAVsbzoCXNoUshmu3pVQjCs3OqE/mAEwLaq7BDTEUw3g5MDrmSjX8Y7Z/BVcD0GanjnKqkI3c91k36UR1gW98a9YNHUmvKQEUmpD3Edvewasyc3grPVEfng/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=b1I078Gn; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso1047881276.0
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 09:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708018432; x=1708623232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa/0/9FROsSJsRbMtv8LhZavsOQVcPGFC3qwzwJJBxc=;
        b=b1I078GnUQw/JwmqHmtsDsKLMtl6GoSMzE36lTP251ecQNbqss8o+1O8YV5l3jPVZT
         /9RdiEDIItDQSVazRqyK3iQoKy9z1FWDtC3n3w8uym3pP7Gi1Y5cAuQIml6OZi3XvLSt
         M8zKSueZARt5hjoSEGCmBdBfGvXRoYUDZ8hvujK3ffFAxysoht2+Ri8ZZvS1WXGqcegi
         1UVF1DfU0UsnYmxRsyjJJCnlq6BwC6GYZfE4/aKYijcuxvCHsQ7Ii40Ybinhq1LlJCyX
         IztkrN+/KoDNqc7kA6IOlokfMWElQOGfDN6ygoVenwoyzPM73eXOURskdjlpB1Yuz/X9
         bILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708018432; x=1708623232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa/0/9FROsSJsRbMtv8LhZavsOQVcPGFC3qwzwJJBxc=;
        b=Sr5suQTZpgKl0PnlTdbwH+aMQzkpmadkOFmVPsDfhpkzuN6GdjQozFAZn4FmhLMUj4
         HV6SVIgsHw3pcwI5w5KP/0oh5/Vau9q9A7hz3pXknHflRnSy+p3LtM4vF4dhWO2UhLCm
         8TVUge3Ju1c2eC6ofXI7pJNp7KZorhO0EvwSVT0ImB73Yl0AuZQ4aX2qj/nEqwr2HuGF
         6JKW3HwwLbJZKehRFFDStW2YgQCFpPoARMFf5Jzug4dHVN1JX8wVbqEodOJLm4y+FWDe
         hxphqemupOGukgaozakp5Y+wkgZp0kN9ij6YBgKYW1LBpWoBmDA6EcYf6KHPafOeGqBQ
         1P2A==
X-Forwarded-Encrypted: i=1; AJvYcCVGExxZz7H5+ar5dAk2QsqdSzkvUbF9B7gPBOFZxp+tjEQVBij8oiLyDtt2ppQcT4in0+YwvS2p33hbgFu1PzZRsuaEmSxp
X-Gm-Message-State: AOJu0YzWBUVf3d1ikq1rIineZdYuMdiqBshrB+8lkF0a/TRJZ94hc+sR
	ytsun5DqSzW4t3kTBFZSATbg0QkDqFgLc949H6JlJkhK+7OMDwU5kZcfMg84uMNaWX+riE41qEl
	Ndif9NIRXChNYx0PBC1MECENS2dOGRmg0uXry
X-Google-Smtp-Source: AGHT+IFbAe+PKGr1nouPmjln84Blb+HUXRK9WfYr7VBYoZu0/iT9qdjImqK8NHeBdyPEiiusHprL+3dOOI1ix1eNEBs=
X-Received: by 2002:a25:b20f:0:b0:dc6:4b5a:410a with SMTP id
 i15-20020a25b20f000000b00dc64b5a410amr2279256ybj.12.1708018432091; Thu, 15
 Feb 2024 09:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215143346.1715054-1-kuba@kernel.org> <20240215143346.1715054-2-kuba@kernel.org>
In-Reply-To: <20240215143346.1715054-2-kuba@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 15 Feb 2024 12:33:41 -0500
Message-ID: <CAM0EoMm3QgW7BRF0HUSCStHWDst=pajq3uFiKhotEeLmu9kJhw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] net/sched: act_mirred: don't override retval
 if we already lost the skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 9:33=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> If we're redirecting the skb, and haven't called tcf_mirred_forward(),
> yet, we need to tell the core to drop the skb by setting the retcode
> to SHOT. If we have called tcf_mirred_forward(), however, the skb
> is out of our hands and returning SHOT will lead to UaF.
>
> Move the retval override to the error path which actually need it.
>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Fixes: e5cf1baf92cb ("act_mirred: use TC_ACT_REINSERT when possible")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>


cheers,
jamal

> ---
> CC: jhs@mojatatu.com
> CC: xiyou.wangcong@gmail.com
> CC: jiri@resnulli.us
> ---
>  net/sched/act_mirred.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 291d47c9eb69..6faa7d00da09 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -266,8 +266,7 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, str=
uct tcf_mirred *m,
>         if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
>                 net_notice_ratelimited("tc mirred to Houston: device %s i=
s down\n",
>                                        dev->name);
> -               err =3D -ENODEV;
> -               goto out;
> +               goto err_cant_do;
>         }
>
>         /* we could easily avoid the clone only if called by ingress and =
clsact;
> @@ -279,10 +278,8 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, st=
ruct tcf_mirred *m,
>                 tcf_mirred_can_reinsert(retval);
>         if (!dont_clone) {
>                 skb_to_send =3D skb_clone(skb, GFP_ATOMIC);
> -               if (!skb_to_send) {
> -                       err =3D  -ENOMEM;
> -                       goto out;
> -               }
> +               if (!skb_to_send)
> +                       goto err_cant_do;
>         }
>
>         want_ingress =3D tcf_mirred_act_wants_ingress(m_eaction);
> @@ -319,15 +316,16 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, s=
truct tcf_mirred *m,
>         } else {
>                 err =3D tcf_mirred_forward(at_ingress, want_ingress, skb_=
to_send);
>         }
> -
> -       if (err) {
> -out:
> +       if (err)
>                 tcf_action_inc_overlimit_qstats(&m->common);
> -               if (is_redirect)
> -                       retval =3D TC_ACT_SHOT;
> -       }
>
>         return retval;
> +
> +err_cant_do:
> +       if (is_redirect)
> +               retval =3D TC_ACT_SHOT;
> +       tcf_action_inc_overlimit_qstats(&m->common);
> +       return retval;
>  }
>
>  static int tcf_blockcast_redir(struct sk_buff *skb, struct tcf_mirred *m=
,
> --
> 2.43.0
>

